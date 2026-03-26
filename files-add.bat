@echo off
:: [ANONYMIZED] Pushing configuration files to the Android device
echo Pushing custom settings to device storage...
adb push "mrm\files\shared_prefs\custom_settings.xml" "/sdcard/Android/data/com.company.kioskapp/files/"
echo Files successfully pushed.