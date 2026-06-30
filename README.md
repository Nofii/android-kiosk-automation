# Android Kiosk Auto-Provisioning Script 📱⚙️

## 📖 Project Overview
This script was created to automate and significantly speed up the configuration process of Android devices for "Kiosk Mode" (infokiosks in a retail environment). The main PowerShell script, combined with Windows Batch files, replaces tedious manual setup, minimizing the risk of human error and saving valuable time for IT technicians.

## 🚀 Key Features
* On-the-fly editing of XML configuration files (modifying JSON values within XML).
* Automated installation and uninstallation of required `.apk` packages (via ADB).
* Configuration of Wi-Fi network profiles on target devices.
* Installation validation based on application version readout (using Dumpsys).

## 🛠 Technologies & Tools
* **PowerShell** - the main language of the control script.
* **ADB (Android Debug Bridge)** - for communication with the Android devices.
* **Windows Batch (.bat)** - for executing sequential system commands.

## ⚙️ Prerequisites
To run this script, ensure you have the following:
1. Windows OS with PowerShell.
2. Android SDK Platform-Tools (ADB) available in the script directory or added to the system's PATH environment variables.
3. An Android device connected via USB cable (with USB debugging enabled).

## 🏃‍♂️ How to Run
1. Clone this repository:
   ```bash
   git clone [https://github.com/nofii/android-kiosk-automation.git](https://github.com/YourUsername/android-kiosk-automation.git)
