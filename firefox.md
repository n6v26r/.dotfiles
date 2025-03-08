# Set a custom firefox start page on new tab pages

#### I used [chevron](https://github.com/kholmogorov27/chevron), but any startpage works

- Find your firefox directory. On my system it was `/usr/lib/firefox`. It should
  have a folder named `defaults`.
- Create the file `autoconfig.js` inside `defaults/pref`. It should contain the
  following lines:

```js
pref("general.config.filename", "mozilla.cfg");
pref("general.config.obscure_value", 0);
pref("general.config.sandbox_enabled", false);
```

- Create the file `mozilla.cfg` inside the firefox config folder. (this is the
  folder containing `defaults/pref`)

```js
// Any comment. You must start the file with a single-line comment!
var { classes: Cc, interfaces: Ci, utils: Cu } = Components;

// Set new tab page
try {
  ChromeUtils.importESModule(
    "resource:///modules/AboutNewTab.sys.mjs",
  ).AboutNewTab.newTabURL = "PATH_TO_STARTPAGE_";
} catch (e) {
  Cu.reportError(e);
} // report errors in the Browser Console

// Auto focus new tab content
try {
  const { BrowserWindowTracker } = ChromeUtils.importESModule(
    "resource:///modules/BrowserWindowTracker.sys.mjs",
  );
  const Services = globalThis.Services;
  Services.obs.addObserver((event) => {
    window = BrowserWindowTracker.getTopWindow();
    window.gBrowser.selectedBrowser.focus();
  }, "browser-open-newtab-start");
} catch (e) {
  Cu.reportError(e);
}
```

> [!WARNING]
> The file mozilla.cfg must start with a single comment line and must be
> formated UNIX stile, regardless of your os.

You should now have your local html file set as your newtab page. If you want to
set it as the startpage you can do that in settings.

> [!NOTE]
> You may now find that when firefox opens, the first page will have the
> cursor focused on the url bar, while all following tabs have it focused on the
> page.
> - In order to focus the cursor on the startpage, I've found a workaround, by
> setting the PATH_TO_STARTPAGE to begin with `file://` and in the firefox
> settings, the startpage path without it.
