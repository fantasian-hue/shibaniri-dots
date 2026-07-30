#!/usr/bin/env python3
"""
Native messaging host for the Theme Sync (Live CSS) extension.

Firefox launches this when the extension calls
browser.runtime.connectNative("theme_sync") and keeps stdin/stdout open
for as long as the extension is loaded.

While alive, this listens on a local Unix socket (/tmp/theme-sync.sock).
Your bash script writes to that socket to tell this host to read the
current colors.css and push its contents to the extension, which
live-injects it into every tab.

Socket message format (plain text, one line):
    update                -> reads DEFAULT_COLORS_PATH below
    update:/abs/path.css  -> reads the given path instead

On startup (i.e. whenever Firefox opens and connects the extension),
this also immediately pushes DEFAULT_COLORS_PATH once, so tabs get the
current theme without you having to manually run the update command
right after launching Firefox.
"""
import json
import os
import socket
import struct
import sys
import threading

SOCK_PATH = "/tmp/theme-sync.sock"

# EDIT THIS to the actual path of the colors.css your themeswitch.sh writes.
DEFAULT_COLORS_PATH = os.path.expanduser("~/.config/mozilla/firefox/c4iv4shh.default-release/chrome/colours.css")


def send_to_firefox(payload: dict) -> None:
    encoded = json.dumps(payload).encode("utf-8")
    length = struct.pack("<I", len(encoded))
    sys.stdout.buffer.write(length)
    sys.stdout.buffer.write(encoded)
    sys.stdout.buffer.flush()


def push_css(path: str) -> None:
    try:
        with open(path, "r", encoding="utf-8") as f:
            css_text = f.read()
    except OSError as e:
        send_to_firefox({"cmd": "error", "message": f"could not read {path}: {e}"})
        return
    send_to_firefox({"cmd": "update", "css": css_text})


def watch_firefox_pipe() -> None:
    """Exit when Firefox closes our stdin (extension unloaded / browser quit)."""
    while True:
        raw_len = sys.stdin.buffer.read(4)
        if len(raw_len) == 0:
            print("[theme_sync_host] Firefox closed the pipe, exiting", file=sys.stderr, flush=True)
            os._exit(0)
        msg_len = struct.unpack("<I", raw_len)[0]
        sys.stdin.buffer.read(msg_len)  # unused, discard


def run_socket_server() -> None:
    if os.path.exists(SOCK_PATH):
        os.remove(SOCK_PATH)

    srv = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    srv.bind(SOCK_PATH)
    os.chmod(SOCK_PATH, 0o600)
    srv.listen(1)

    print(f"[theme_sync_host] listening on {SOCK_PATH}", file=sys.stderr, flush=True)
    try:
        while True:
            conn, _ = srv.accept()
            try:
                with conn:
                    data = conn.recv(4096).decode("utf-8", errors="ignore").strip()
                    if not data:
                        continue
                    print(f"[theme_sync_host] received: {data!r}", file=sys.stderr, flush=True)
                    if data == "update":
                        push_css(DEFAULT_COLORS_PATH)
                    elif data.startswith("update:"):
                        push_css(data[len("update:"):])
            except Exception as e:
                # A single bad request should never take the whole host
                # down — log it and keep serving.
                print(f"[theme_sync_host] error handling request: {e}", file=sys.stderr, flush=True)
    finally:
        srv.close()
        if os.path.exists(SOCK_PATH):
            os.remove(SOCK_PATH)


if __name__ == "__main__":
    threading.Thread(target=watch_firefox_pipe, daemon=True).start()
    # Push current colors immediately so a freshly (re)started Firefox
    # is themed without waiting for the next themeswitch.sh run.
    push_css(DEFAULT_COLORS_PATH)
    run_socket_server()
