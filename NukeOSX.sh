#!/bin/bash

# NukeOSX
# macOS Privacy & Telemetry Hardening Script (2025)
# Run as admin. Best results with SIP disabled first (Recovery Mode: csrutil disable)
# Use disable instead of remove → reversible
# Includes proper pf rules to block local loopback callbacks

echo "============================================================="
echo "WARNING: Some changes require SIP disabled for full effect"
echo "Press Enter to continue or Ctrl+C to cancel..."
read -r

# === 1. Disable services (reversible with launchctl enable) ===
services=(
    "com.apple.analyticsd"
    "com.apple.locationd"
    "com.apple.coreduetd"
    "com.apple.cloudphotodsyncagent"
    "com.apple.siri"
    "com.apple.dvtcodeviewd"
    "com.apple.icloud.fmfd"
    "com.apple.icloud.findmydevice"
    "com.apple.icloud.searchpartyserver"
    "com.apple.telemetry"
    "com.apple.speech.speechsynthesisd"
    "com.apple.spindump"
)

echo "Disabling services..."
for service in "${services[@]}"; do
    sudo launchctl disable system/"$service" 2>/dev/null && echo "  ✓ $service disabled"
done

sudo launchctl disable gui/"$(id -u)"/com.apple.SiriServer 2>/dev/null

# === 2. System-wide privacy tweaks ===
echo "Applying system tweaks..."
sudo pmset -a hibernatemode 0 >/dev/null 2>&1
sudo mdutil -i off / >/dev/null 2>&1
sudo tmutil disable >/dev/null 2>&1
defaults write com.apple.photoanalysisd ImageAnalysisEnabled -bool false
defaults write com.apple.CrashReporter DialogType none
sudo defaults write /Library/Application\ Support/CrashReporter/DiagnosticMessagesHistory.plist AutoSubmit -bool false
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
defaults write com.apple.Siri StatusMenuVisible -bool false
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.knowledge-store deleteOnReboot -bool true
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.airport.preferences ProbingEnabled -bool false
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false
defaults write com.apple.SoftwareUpdate AutomaticDownload -bool false
sudo defaults write /Library/Preferences/Logging/com.apple.system.logging.plist KeepFiles -int 2

# === 3. Block local HTTP/HTTPS loopback callbacks (127.0.0.1) ===
echo "Blocking local loopback callbacks..."
cat << EOF | sudo tee /etc/pf.conf.local >/dev/null
# Block apps phoning home via localhost
block out quick on lo0 proto tcp to any port { 80, 443 }
EOF

sudo pfctl -e -f /etc/pf.conf.local 2>/dev/null && echo "  ✓ Local callbacks blocked"

# === 4. Optional: Aggressive Spotlight kill ===
sudo launchctl remove system/com.apple.metadata.mds.stores 2>/dev/null
sudo launchctl remove system/com.apple.metadata.mds.scan 2>/dev/null

# === 5. History suppression (current session) ===
export HISTFILE=/dev/null
export HISTSIZE=0
export SAVEHIST=0

echo "============================================================="
echo "Done! Most changes applied."
echo "For full effect (especially Spotlight/deep system):"
echo "1. Reboot to Recovery Mode"
echo "2. csrutil disable"
echo "3. Reboot back"
echo "4. Run script again"
echo "5. (Optional) csrutil enable after"

echo ""
echo "Reboot now to apply everything? (y/N)"
read -r resp
if [[ "$resp" =~ ^[Yy]$ ]]; then
    sudo reboot
else
    echo "Reboot manually when ready."
fi
