@echo off
:: [ANONYMIZED] Launching the Kiosk Application
echo Starting the Main Kiosk App...
adb shell monkey -p com.company.kioskapp -c android.intent.category.LAUNCHER 1
echo App launched.