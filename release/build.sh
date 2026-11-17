#!/bin/sh
# Build the RasterBouncingBalls example for the web installer, once per chip:
#   release/build.sh [path to the chipguy_ESP32-CYD-Resistive_display library]
# writes web-install/<chip>/{bootloader,partitions,boot_app0,app}.bin and
# launchpad.toml.  Four parts rather than one merged image, so that flashing
# never touches NVS (0x9000-0xDFFF): touch calibration and the demo's saved
# results survive.  Needs arduino-cli with the esp32 core, LVGL 9 and the
# library installed (the library path defaults to the sketchbook's).
set -e
cd "$(dirname "$0")/.."
LIB=${1:-$(arduino-cli config get directories.user)/libraries/chipguy_ESP32-CYD-Resistive_display}
SKETCH="$LIB/examples/RasterBouncingBalls"
LIBS=$(dirname "$LIB")
CORE=$(arduino-cli config get directories.data)/packages/esp32/hardware/esp32
CORE=$CORE/$(ls "$CORE" | sort -V | tail -1)
build() {   # chip, FQBN
    OUT=$(mktemp -d)
    arduino-cli compile --fqbn "$2" --libraries "$LIBS" --build-path "$OUT" "$SKETCH"
    mkdir -p "web-install/$1"
    cp "$OUT/RasterBouncingBalls.ino.bootloader.bin" "web-install/$1/bootloader.bin"
    cp "$OUT/RasterBouncingBalls.ino.partitions.bin" "web-install/$1/partitions.bin"
    cp "$CORE/tools/partitions/boot_app0.bin"         "web-install/$1/boot_app0.bin"
    cp "$OUT/RasterBouncingBalls.ino.bin"            "web-install/$1/app.bin"
    rm -rf "$OUT"
}
build esp32   esp32:esp32:esp32
build esp32c5 esp32:esp32:esp32c5:PSRAM=enabled
build esp32s3 esp32:esp32:esp32s3:PSRAM=opi,CDCOnBoot=cdc,FlashSize=16M
VERSION=$(sed -n 's/^version=//p' "$LIB/library.properties")
sed "s/@VERSION@/library version $VERSION/" release/launchpad.toml.in > launchpad.toml
ls -lR web-install launchpad.toml
