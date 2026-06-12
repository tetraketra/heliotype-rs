set dotenv-load := true

# Android Studio ENV
export NDK_VERSION := env_var_or_default("NDK_VERSION", "30.0.14904198")
export ANDROID_HOME := env_var("HOME") + "/Android/Sdk"
export ANDROID_NDK_ROOT := ANDROID_HOME + "/ndk/" + NDK_VERSION
export PATH := env_var("PATH") + ":" + ANDROID_HOME + "/platform-tools:" + ANDROID_HOME + "/emulator"

APK := "target/debug/apk/heliotype-rs.apk"
AVD := env_var_or_default("AVD", "Medium_Phone_API_36.1")
PKG := `adb shell pm list packages | grep heliotype | head -n 1 | cut -d: -f2 | tr -d '\r'`

# Emulation
start-emulator:
    sh -c 'if adb get-state 1>/dev/null 2>&1; then exit 0; fi; \
    emulator -avd {{AVD}} -no-boot-anim > .emu.log 2>&1 & echo $! > .emu.pid'
stop-emulator:
    sh -c 'if [ -f .emu.pid ]; then kill $(cat .emu.pid) || true; rm -f .emu.pid; fi'
wait-device:
    adb wait-for-device
    adb shell 'while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 1; done'
    adb shell input keyevent 82

# Pieces
build:
    cargo apk build --target aarch64-linux-android --lib
install: build
    adb install -r {{APK}}
launch:
    adb shell monkey -p {{PKG}} -c android.intent.category.LAUNCHER 1

# Run
run-debug: start-emulator wait-device install launch