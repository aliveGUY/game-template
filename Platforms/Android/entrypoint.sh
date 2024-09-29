#!/bin/bash

emulator -avd EmulatorDevice -no-boot-anim >/dev/null 2>&1 &
EMULATOR_PID=$!

boot_completed=""
while [[ "$boot_completed" != "1" ]]; do
  sleep 5
  boot_completed=$(adb -e shell getprop sys.boot_completed 2>/dev/null)
  echo "Waiting for emulator to boot..."

  if ! ps -p $EMULATOR_PID > /dev/null; then
    echo "Emulator has crashed!"
    exit 1
  fi
done

echo "Emulator booted!"

./gradlew installDebug

adb logcat -s *:E
