#!/bin/bash

scriptPath="$(pwd)/bash-drop.sh"
plistPath="$HOME/Library/LaunchAgents/LoginScripts.BashDrop.plist"
logPath="$(pwd)/log.txt"
configPath="$(pwd)/config.txt"
plist="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
    <key>EnvironmentVariables</key>
    <dict>
        <key>BASHDROP_CONFIG</key>
        <string>$configPath</string>
    </dict>
    <key>Label</key>
    <string>LoginScripts.BashDrop.sh</string>
    <key>ProgramArguments</key>
    <array>
        <string>$scriptPath</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>$(pwd)/out.txt</string>
    <key>StandardErrorPath</key>
    <string>$logPath</string>
</dict>
</plist>" 

touch $plistPath
echo "$plist" > "$plistPath"

launchctl unload -w $plistPath
launchctl load -w $plistPath