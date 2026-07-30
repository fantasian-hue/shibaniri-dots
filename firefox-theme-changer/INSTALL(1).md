# Theme Sync (Live CSS) — install steps

This replaces the reload-based version. Instead of reloading tabs, it
injects your colors.css directly into every open tab's DOM via
`browser.scripting.insertCSS`, live — no reload, no restart.

## 0. Important: check your colors.css is self-contained CSS

This extension injects the raw contents of colors.css as a `<style>`
block into each page. That means it needs to be valid standalone CSS —
i.e. the variable declarations must already be wrapped in a selector,
e.g.:

```css
:root {
  --bg: #1e1e2e;
  --fg: #cdd6f4;
  /* ... */
}
```

If your current colors.css relies on being wrapped by something in
userContent.css (e.g. it's just bare `--bg: #1e1e2e;` lines with no
`:root { }` around them), add that wrapper to colors.css itself first.

## 1. Native host script

```bash
mkdir -p ~/.local/bin
cp theme_sync_host.py ~/.local/bin/
chmod +x ~/.local/bin/theme_sync_host.py
```

Edit `~/.local/bin/theme_sync_host.py` and set `DEFAULT_COLORS_PATH` to
your actual colors.css path.

## 2. Register the native host with Firefox

Edit `theme_sync_host.json`, replace the `path` with the real absolute
path from step 1, then:

```bash
mkdir -p ~/.mozilla/native-messaging-hosts
cp theme_sync_host.json ~/.mozilla/native-messaging-hosts/theme_sync.json
```

## 3. Load the extension

Same caveat as before — unsigned extensions can't be permanently
installed on release Firefox:

- **Easiest for a rice setup:** Firefox Developer Edition or Nightly,
  with `xpinstall.signatures.required` set to `false` in
  `about:config`, then install the packed extension permanently.
- **Stock Firefox:** `about:debugging#/runtime/this-firefox` → "Load
  Temporary Add-on" → `extension/manifest.json`, or use
  `web-ext run -s extension/` to reload it automatically each session.

Because this version needs `<all_urls>` host permission (to inject CSS
into any page), you'll see that permission listed when loading it —
that's expected and required for it to work on every tab.

## 4. CLI command

```bash
cp theme-sync-update ~/.local/bin/
chmod +x ~/.local/bin/theme-sync-update
```

## 5. Wire it into your themeswitch script

Last line of `themeswitch.sh`, after writing the new colors.css:

```bash
theme-sync-update
```

## Notes

- Tabs on protected pages (`about:*`, `addons.mozilla.org`, other
  extensions' pages) will silently reject the injection — that's a
  Firefox restriction, not a bug, and there's nothing to theme there
  anyway.
- The host also pushes your current colors.css once immediately when
  Firefox starts and connects the extension, so you don't need to
  manually run `theme-sync-update` right after launching Firefox.
