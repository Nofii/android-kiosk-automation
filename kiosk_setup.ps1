# === Infokiosk Auto-Configurator ===
$xmlPath = "mrm\files\shared_prefs\custom_settings.xml"

# 1. Check if the XML file exists
if (-Not (Test-Path $xmlPath)) {
    Write-Host "❌ Error: Cannot find $xmlPath" -ForegroundColor Red
    Write-Host "Please ensure you are running this script from the correct root folder." -ForegroundColor Yellow
    Pause
    exit
}

# 2. Ask the user for input
$kioskName = Read-Host "👉 Enter the Infokiosk Name (e.g., Kiosk_01_Main)"
$kioskColor = Read-Host "👉 Enter the style color (e.g., blue, red)"

# 3. Read the XML file content
$content = Get-Content -Path $xmlPath -Raw -Encoding UTF8

# 4. Extract and parse the JSON list from the XML
if ($content -match '(?s)<string name="mrm_rooms_list">(.*?)</string>') {
    $jsonString = $matches[1]
    
    try {
        $roomsList = $jsonString | ConvertFrom-Json
    } catch {
        Write-Host "❌ Error parsing the JSON inside the XML!" -ForegroundColor Red
        Pause
        exit
    }
} else {
    Write-Host "❌ Error: Could not find 'mrm_rooms_list' in the XML." -ForegroundColor Red
    Pause
    exit
}

# 5. Look up the corresponding email
$kioskEmail = $null
foreach ($room in $roomsList) {
    if ($room.name -eq $kioskName.Trim()) {
        $kioskEmail = $room.email
        break
    }
}

if (-not $kioskEmail) {
    Write-Host "`n❌ Error: Could not find '$kioskName' in the room list." -ForegroundColor Red
    Write-Host "Make sure you typed the name exactly as it appears in the list." -ForegroundColor Yellow
    Pause
    exit
}

Write-Host "✅ Found matching email: $kioskEmail" -ForegroundColor Green

# 6. Update the XML values securely
$content = $content -replace '<string name="style_name">.*?</string>', "<string name=`"style_name`">$kioskColor</string>"
$content = $content -replace '<string name="sp_room_label">.*?</string>', "<string name=`"sp_room_label`">$kioskName</string>"
$content = $content -replace '<string name="mrm_room_mail_address">.*?</string>', "<string name=`"mrm_room_mail_address`">$kioskEmail</string>"

# Save the updated XML without breaking the Android encoding
[System.IO.File]::WriteAllText("$PWD\$xmlPath", $content, [System.Text.Encoding]::UTF8)

Write-Host "✅ XML configuration updated successfully!`n" -ForegroundColor Green

# 7. Install the Launcher directly via ADB
Write-Host "📦 Installing App_Launcher_v5.3.apk..." -ForegroundColor Cyan
.\adb.exe install -r "App_Launcher_v5.3.apk"

# 8. Run the Batch Scripts sequentially
$batFiles = @(
    "apk-uninstall.bat",
    "apk-install.bat",
    "files-add.bat",
    "wpa-push.bat",
    "apk-open.bat"
)

Write-Host "`n=== Running Device Configuration Scripts ===" -ForegroundColor Cyan
foreach ($bat in $batFiles) {
    if (Test-Path $bat) {
        Write-Host "⏳ Executing $bat..." -ForegroundColor Yellow
        cmd.exe /c $bat
    } else {
        Write-Host "⚠️ Warning: $bat not found in the current folder, skipping." -ForegroundColor DarkYellow
    }
}

# 9. Completion and Version Check
Write-Host "`n🎉 Infokiosk setup completed successfully!" -ForegroundColor Green

# Ask ADB for the version name and clean up the output (ANONYMIZED PACKAGE NAME)
$versionOutput = .\adb.exe shell "dumpsys package com.company.kioskapp | grep versionName"

if ($versionOutput) {
    # This removes the "versionName=" text and any blank spaces so it just prints "5.3"
    $cleanVersion = $versionOutput.Trim() -replace "versionName=", ""
    Write-Host "🚀 Current launcher version: $cleanVersion" -ForegroundColor Cyan
} else {
    Write-Host "⚠️ Could not retrieve the launcher version. Make sure the app installed correctly." -ForegroundColor DarkYellow
}

Write-Host "`nPress any key to exit..."
Pause