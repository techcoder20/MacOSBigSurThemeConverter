# Cardputer Zero / Debian 13 (experimental)

This optional integration targets the M5Stack Cardputer Zero running Debian 13
(Trixie) ARM64 with Raspberry Pi Desktop `labwc`, `wf-panel-pi` and
`pcmanfm-pi`. It leaves the original LXDE converter unchanged.

## Reported hardware baseline (not independently reproduced)

- Raspberry Pi Compute Module 0 Rev 1.0; Debian 13.7 aarch64
- `labwc-pi` selects `WLR_RENDERER=pixman` when the GPU MMU check fails
- Mesa exposes a Broadcom VC4 V3D 2.1 EGL / OpenGL ES 2.0 renderer
- HDMI uses `vc4-drm`; internal SPI screen uses `panel-mipi-dbi-spi`
- The existing `wf-panel-pi` includes Wi-Fi, Bluetooth, battery and audio widgets
- Approximately 352 MiB available to Linux, with ~105 MiB available at the reported snapshot

Keep the stock renderer default. Hardware EGL availability does not prove
that labwc GLES2 will work reliably across both displays. Do not enable
always-on blur, animations, background search indexes or extra daemons by default.

## Install prototype

From the root of the repository:

```sh
sudo apt install git sassc libglib2.0-dev-bin libxml2-utils
bash cardputer-zero/theme.sh install
```

The command checks architecture, OS and labwc, then downloads the upstream
WhiteSur GTK and icon sources into the current user's cache. **It does not
run any downloaded scripts.** Review the upstream scripts and run the printed
install commands before attempting theme switching.

In the logged-in graphical user's D-Bus session:

```sh
bash cardputer-zero/theme.sh light
bash cardputer-zero/theme.sh dark
bash cardputer-zero/theme.sh status
bash cardputer-zero/theme.sh restore
```

Over SSH, ensure the commands target the running graphical user's D-Bus
session; a plain SSH shell may not have the required environment.

The first theme switch records the original GTK/icon settings under
`~/.local/state/macosbigsur-cardputer/`. Restore reapplies those
preferences but does not uninstall downloaded assets.

## Current limitations / roadmap

This is **not** a complete desktop conversion, nor a validated on-device
release. The script currently manages GTK/icon preferences only, after the
user reviews and installs the WhiteSur assets separately.

Remaining work includes:

- Wayland-native dock, Launchpad-like launcher and on-demand search
- Wallpaper and accent/preset switching
- labwc-compatible window decoration styling
- Responsive wf-panel-pi integration without removing native hardware widgets
- Dual-display testing, UI validation, resource benchmarks and recovery testing

Raspberry Pi Desktop's `/usr/bin/labwc-pi` removes
`~/.config/gtk-3.0/gtk.css` on session start, so the integration does
not depend on that file. LightDM is used instead of GDM, and GNOME Shell
extensions do not apply to labwc. Do not force `WLR_RENDERER=gles2`.

## Safety

No privileged system files, network settings, display configuration or
system services are modified by `theme.sh`. GPU memory allocation,
keyboard layout, the original installer and existing hardware widgets
remain untouched. Test and retain a known-good recovery path before
running any upstream third-party theme installer.

Sources: https://github.com/vinceliuice/WhiteSur-gtk-theme and
https://github.com/vinceliuice/WhiteSur-icon-theme
