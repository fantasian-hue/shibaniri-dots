// Connects to the native host (theme_sync_host.py). Whenever the host
// forwards a fresh copy of colors.css, this:
//   1. removes the previously-injected CSS from every open tab
//   2. inserts the new CSS into every open tab (live, no reload)
// A tabs.onUpdated listener separately handles tabs opened/navigated
// after that point, injecting whatever CSS is currently known.

let port = null;
let currentCssText = "";

// Firefox discards idle non-persistent background pages after ~30s,
// which drops the native port and kills the host process along with
// it. A recurring alarm resets that idle timer so this page (and the
// connection) stays alive indefinitely.
browser.alarms.create("keepalive", { periodInMinutes: 0.4 });
browser.alarms.onAlarm.addListener((alarm) => {
  if (alarm.name === "keepalive" && !port) {
    connect();
  }
});

function connect() {
  port = browser.runtime.connectNative("theme_sync");

  port.onMessage.addListener((msg) => {
    if (msg && msg.cmd === "update" && typeof msg.css === "string") {
      applyCss(msg.css).catch((e) =>
        console.error("theme-sync: applyCss failed", e)
      );
    }
  });

  port.onDisconnect.addListener(() => {
    port = null;
    setTimeout(connect, 3000);
  });
}

async function applyCss(newCssText) {
  if (newCssText === currentCssText) return;

  const tabs = await browser.tabs.query({});
  for (const tab of tabs) {
    // Best-effort: about: pages, addons.mozilla.org, other extensions'
    // pages, and lazy/discarded (session-restored but unloaded) tabs
    // will reject this — that's expected, ignore it.
    if (currentCssText) {
      try {
        await browser.scripting.removeCSS({
          target: { tabId: tab.id },
          css: currentCssText,
        });
      } catch (e) {
        /* no permission on this tab, or nothing was injected yet */
      }
    }
    try {
      await browser.scripting.insertCSS({
        target: { tabId: tab.id },
        css: newCssText,
      });
    } catch (e) {
      /* ignore */
    }
  }

  currentCssText = newCssText;
}

// Handles tabs opened or navigated *after* the last applyCss() call —
// browser.contentScripts.register() used to cover this but that API
// no longer exists under Manifest V3, so we inject on load instead.
browser.tabs.onUpdated.addListener((tabId, changeInfo) => {
  if (changeInfo.status === "complete" && currentCssText) {
    browser.scripting
      .insertCSS({ target: { tabId }, css: currentCssText })
      .catch(() => {
        /* ignore - e.g. protected page */
      });
  }
});

connect();
