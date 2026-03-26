# Android Kiosk Auto-Provisioning Script 📱⚙️

## 📖 Opis projektu
Ten skrypt został stworzony w celu automatyzacji i znacznego przyspieszenia procesu konfiguracji urządzeń z systemem Android do pracy w trybie "Kiosk Mode" (infokioski w środowisku retail). Skrypt główny (PowerShell) w połączeniu z plikami wsadowymi (Batch) zastępuje żmudną, ręczną konfigurację, minimalizując ryzyko błędów ludzkich i oszczędzając czas techników IT.

## 🚀 Główne funkcje
* Błyskawiczna edycja plików konfiguracyjnych XML (podmiana wartości JSON w locie).
* Automatyczne instalowanie i odinstalowywanie wymaganych paczek `.apk` (via ADB).
* Konfiguracja profili sieciowych Wi-Fi na urządzeniach docelowych.
* Walidacja instalacji na podstawie odczytu wersji aplikacji (Dumpsys).

## 🛠 Technologie i Narzędzia
* **PowerShell** - główny język skryptu sterującego.
* **ADB (Android Debug Bridge)** - do komunikacji z urządzeniami.
* **Windows Batch (.bat)** - wykonywanie sekwencyjnych poleceń systemowych.

## ⚙️ Wymagania wstępne
1. System operacyjny Windows z programem PowerShell.
2. Narzędzia platformy Android (ADB) dostępne w folderze ze skryptem lub dodane do zmiennych środowiskowych PATH.
3. Urządzenie z Androidem podłączone kablem USB (z włączonym trybem debugowania USB).

## 🏃‍♂️ Jak uruchomić
1. Sklonuj to repozytorium:
   ```bash
   git clone [https://github.com/TwojWymyslonyNick/android-kiosk-automation.git](https://github.com/TwojWymyslonyNick/android-kiosk-automation.git)