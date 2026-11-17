# CYD Raster FPS Stress Test

A demo for "Cheap Yellow Display" boards (CYDs) that you can install from your web
browser in a minute — no Arduino IDE, no code.

It finds out what your board's screen can really do, explains each result on the
screen, and then runs a bouncing-balls animation as fast as your screen allows,
without "tearing" (a line where an old frame meets a new one).

## Install it from the web

In **Chrome** or **Edge** on a computer:

1. Plug the CYD into the computer with a USB cable that carries data (some cables
   only charge).
2. Open **[the CYD Raster FPS Stress Test installer](https://chipguyhere.github.io/esp-launchpad/minimal-launchpad/?flashConfigURL=https://raw.githubusercontent.com/chipguyhere/CYD-Raster-FPS-Stress-Test/main/launchpad.toml)**.
3. Click **Connect**. It asks before it writes anything; then pick your board's port.
4. It works out which chip your board has and installs the right version. When it's
   done, the board restarts into the demo.

Your board's saved settings are kept, including its touch calibration.

## Which boards

The boards supported by the
[ESP32-CYD-Resistive_display](https://github.com/chipguyhere/ESP32-CYD-Resistive_display)
library, which this demo is built from. It recognizes them by itself:

- **Classic ESP32 CYDs**: ESP32-2432S028, ESP32-32E (2.8", 3.2", 3.5", 4.0"),
  ESP32-024, ESP32-035, ESP32-2432S032 / -C, ESP32-2432S024C, Guition JC2432W328,
  ESP32-3248S035C.
- **ESP32-C5**: NM-CYD-C5.
- **ESP32-S3**: the black 2.8" ES3C28P / ES3N28P.

## What you'll see

Press **Next** on the screen — or the board's **BOOT** button — to move on.

1. **Speed.** Can your screen take double speed (80 MHz)? If your board hasn't been
   tested, it runs a 20-second test. The screen shows flickering static and the LED
   flashes: that's the test, not a fault.
2. **Sync.** Can your screen say which line it's drawing? If it can, the balls can be
   timed to it.
3. **Refresh.** How many times a second your screen refreshes.
4. **Sending a frame.** How long one frame of balls takes to send.
5. **A slower refresh**, sometimes. If a slower refresh would stop the tearing, it says
   so and lets you see test patterns at that speed before you decide. Slower can
   flicker, so it's up to you.
6. **The verdict**, then the balls. The sliders at the bottom set the number of balls
   and their speed.

Every board is different, even two of the same kind, so your results may not match a
friend's.

## If touch doesn't work well

Use the **BOOT** button to move through the screens. To calibrate a resistive touch
screen, install the library's **TouchCalibrate** example once (Arduino IDE); this demo
then picks up the calibration.

## The code

This is the **RasterBouncingBalls** example from the
[ESP32-CYD-Resistive_display](https://github.com/chipguyhere/ESP32-CYD-Resistive_display)
library: open it in the Arduino IDE under **File ▸ Examples ▸
chipguy_ESP32-CYD-Resistive_display**. How it works is written up in the library's
README-engineering.md, under "Beam chasing".

`release/build.sh` rebuilds the three versions in `web-install/` from the library.

## No warranty

This comes with no warranty whatsoever. On a board it wasn't made for it does nothing
useful, and installing it replaces whatever program the board was running.
