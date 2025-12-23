# NukeOSX
Secure your macOS from Apple's eyes. One-time script. Apple stop spying on you. No Telemetry, no tracking, no questions. Tested. Silent. Yours to own, not for them to own you. The speed of Linux, the face of macOS. 

A low-noise macOS hardening script that reduces background activity, telemetry, and unbounded system data growth.

Designed for users who prefer a **quiet, private system** without switching to Linux.

---

## What this project is

`NukeOSX` is a shell script that disables or limits macOS background services responsible for:

- Telemetry and analytics
- Behavioral databases and “intelligence” services
- Persistent system caches
- Excessive disk I/O and swap pressure
- Unbounded “System Data” growth

The goal is not to remove macOS features randomly, but to **re-scope macOS for minimal background behavior**.

---

## Who this is for

- Users comfortable with Terminal and `sudo`
- Older Macs with limited RAM or SSD space, increase speed and decrease bloat and RAM use drastically
- If privacy matters to you more than Apple cloud features
- Those who want to limit what reports back to Apple 
  
---

## What it does

The script disables:

- Apple analytics and telemetry
- CoreDuet behavioral databases
- Siri and speech services
- iCloud background sync agents
- Photo and media analysis
- Spotlight indexing
- Time Machine local snapshots
- Hibernation sleep image
- Crash reporting dialogs and auto-submission
- Resume / app state persistence
- Network quality probes and captive portal checks
- Excessive system logging

Typical results:
- Significantly reduced “System Data”
- Lower disk and swap churn
- Quieter fans on Intel Macs
- More consistent battery behavior
- Predictable storage usage over time
- Doesn’t report to Apple

---

## What it intentionally breaks or limits

This script **disables Apple features by design**.

Expect loss or degradation of:

- Siri
- Some iCloud functionality
- Location-based services (Timezones won’t update automatically)
- Captive portal auto-detection
- App session won’t restore if battery is out
- Some local network discovery features (Bonjour)

These are trade-offs, not bugs.

---

## Supported systems

- ✅ Intel Macs
- ✅ Apple Silicon Macs

---

## Update behavior (important)

On **both Intel and Apple Silicon Macs**, macOS system updates may re-enable
some services disabled by this script.

For consistent results, **re-run the script after every macOS system update**.

---

## Usage

Clone the repository and run the script:
- gh repo clone sakisan6/NukeOSX
- cd NukeOSX
- sudo ./NukeOSX.sh

---

## Recommended
Install LuLu firework from objective0see.org, run it, then reboot, let it monitor. When it asks, deny these: adprivacyd, amsengagementd, appleaccountd, cloudd, com.apple.geod, diagnostics_agent, findmylocateagent, homed, idleasesetsd, mobileassetd, netbiosd, networkserviceproxy, parsec-fbf, parsecd, promotecontentd, searchpartyuseragent, SecurityAgent, softwareupdated, studentd, syspolicyd, System Information, WiFiAgent, wifivelocityd, rtcreportingd, mdworker_shared, appstoreagent, askpremissiond, weatherd, spotlight, CategoriesServices, CloudTelemetryServices, iCloudNotificationAgent.

You're now free, a macOS that's more private than out of the box Ubuntu.

---

## DONATION (XMR) 
84KPVnCgnroBkLSyfXcrMxZhp2r3sn24TC2C1aaKTUsRD85g1SMSTULJLN9ysp6TnRNZ9ng6aijWFHvCeE9JQyh47gZYpc3
