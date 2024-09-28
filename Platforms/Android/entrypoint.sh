#!/bin/bash
emulator -avd EmulatorDevice >/dev/null 2>&1 &

boot_completed=""
while [[ "$boot_completed" != "1" ]]; do
  sleep 5
  boot_completed=$(adb -e shell getprop sys.boot_completed 2>/dev/null)
  echo "Waiting for emulator to boot..."
done

echo "Emulator booted!"

./gradlew installDebug

adb logcat
