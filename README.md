# Koreader Sleep Logger 💤📘

A tiny [KOReader](https://koreader.rocks/) plugin that logs the device's last sleep times to a simple text file and shows them in an info popup.

<img src="koreader_sleeplogger.png" alt="SleepLogger screenshot" width="300"/>

Features:

- ✅ Automatically logs the time when the device suspends
- 🕒 Keeps the last 6 sleep times (no wake times)
- 🧭 Accessible from the KOReader UI (via gesture)
- 🧾 Human-friendly plain text log for easy debugging
- 🔁 Persists across device restarts
- ✅ Tested on PocketBook Era Color and Android

## Installation 🛠️

1. Open your KOReader installation folder and navigate to:
   `koreader/plugins/`

2. Create the plugin directory:
   `sleeplogger.koplugin`

3. Add the plugin files:
   - `_meta.lua` → `koreader/plugins/sleeplogger.koplugin/_meta.lua`
   - `main.lua`  → `koreader/plugins/sleeplogger.koplugin/main.lua`

4. Restart KOReader.

5. Enable the plugin:
   - Tools → More tools → Plugin management → Enable "Sleep Logger"
  
6. Create a gesture (it's in the `General` section)

That's it — the plugin will automatically start logging future sleep events.
