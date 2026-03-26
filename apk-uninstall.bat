@echo off
:: [ANONYMIZED] Uninstalling previous versions of the kiosk software
echo Uninstalling old kiosk packages...
adb shell pm uninstall com.company.kioskapp
adb shell pm uninstall com.company.kioskapp.updater
echo Uninstallation step finished.