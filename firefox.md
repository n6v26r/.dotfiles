# Set a custom firefox start page on new tab pages 
## I used [chevron](https://github.com/kholmogorov27/chevron), but any startpage works

* Find your firefox directory. On my system it was /usr/lib/firefox.
  It should have a folder named defaults.
* Create the file autoconfig.js inside defaults/pref.
  It should contain the following lines:

```js
pref("general.config.filename", "mozilla.cfg");
pref("general.config.obscure_value", 0);
pref("general.config.sandbox_enabled", false);
```

* Create the file mozilla.cfg inside the firefox config folder. (this is the folder containing defaults/pref, in my case /usr/lib/firefox)

```js
// Any comment. You must start the file with a single-line comment!
let { classes:Cc, interfaces:Ci, utils:Cu } = Components;

try {
  Cu.import("resource:///modules/AboutNewTab.jsm");
  let newTabURL = "PATH TO STARTPAGE";
  AboutNewTab.newTabURL = newTabURL;
} catch(e) { Cu.reportError(e); }

// Auto focus new tab content
try {
  Cu.import("resource:///modules/BrowserWindowTracker.jsm");
  const Services = globalThis.Services

  Services.obs.addObserver((event) => {
    window = BrowserWindowTracker.getTopWindow();
    window.gBrowser.selectedBrowser.focus();
  }, "browser-open-newtab-start");
} catch(e) { Cu.reportError(e); }
```
### WARNING: the file mozilla.cfg must start with a single comment line and must be formated UNIX stile, regardless of your os.

You may now find the when firefox opens, the first page will have the cursor focused on the url bar, while all following tabs have it focused on the homepage
* In order to focus the cursor on the first page, I've found a workaround, by setting the PATH TO STARTPAGE to begin with `file://` and in the firefox settings, the homepage path without it.
