# LinuxDotfiles

Personal environment configuration files managed with SwayFX, Kitty, and Xfce4-Panel.
It is focused on being fast, simple, and lightweight. No special distracting effects, no mouse usage.

## System Overview

- **Window Manager:** [SwayFX](https://github.com/WillPower33/swayfx) (Sway fork with few tweaks)
- **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
- **App Launcher:** [Fuzzel](https://codeberg.org/dnkl/fuzzel)
- **Panel:** [Xfce4-Panel](https://docs.xfce.org/xfce/xfce4-panel/start)
- **Lockscreen:** [Swaylock](https://github.com/swaywm/swaylock)
- **Notifications:** [Mako](https://github.com/emersion/mako)


## Directory Structure

```text
.
├── install.sh
├── kitty/
│   ├── current-theme.conf
│   ├── dark-theme.auto.conf
│   └── kitty.conf
├── sway/
│   ├── config
│   ├── outputs
│   ├── portals.conf
│   ├── scripts/
│   └── workspaces
├── xfce_panel/
│   └── xfce_panel_config.tar.bz2
└── README.md
```


## Key Dependencies

Ensure the following packages are installed on your system before deploying:

| Category | Packages |
| --- | --- |
| **Desktop Environment** | `swayfx`, `xfce4-panel`, `xfce4-panel-profiles`, `mako`, `fuzzel`, `swaylock` |
| **Utilities** | `kitty`, `grim`, `slurp`, `wl-clipboard`, `brightnessctl`, `playerctl`, `btop` |
| **Services & Auth** | `polkit-gnome`, `gnome-keyring`, `dbus` |
| **Fonts** | `ttf-jetbrains-mono` |


## Installation

1. **Clone the repository:**

```bash
git clone https://github.com/arno/LinuxDotfiles.git 
cd LinuxDotfiles
```

2. **Make the install script executable (if not):**

```bash
chmod +x install.sh
```

3. **Run the installer:**

```bash
./install.sh
```


## Keybindings Reference

### Window Management & System

- `Mod` + `Return` — Launch App Launcher (`fuzzel`)
- `Mod` + `t` — Open Terminal (`kitty`)
- `Mod` + `w` — Close focused window
- `Mod` + `f` — Toggle Fullscreen
- `Mod` + `Shift` + `Space` — Toggle Floating mode
- `Mod` + `r` — Enter Window Resize mode (`Escape` or `Enter` to exit)
- `Mod` + `Shift` + `c` — Reload Sway configuration
- `Mod` + `l` — Lock screen (`swaylock`)
- `Mod` + `\` — Open Power Menu script

### Scratchpads

- `Mod` + `Shift` + `Return` — Toggle dropdown Terminal
- `Mod` + `Shift` + `t` — Toggle dropdown `btop`
- `Mod` + `Shift` + `-` — Move active container to scratchpad
- `Mod` + `-` — Cycle scratchpad windows

### Screenshots & Media

- `Print` — Interactive area screenshot (copied to clipboard via `grim` + `slurp`)
- `XF86AudioMute` / `Raise` / `Lower` — System volume control (`pactl`)
- `XF86MonBrightnessUp` / `Down` — Screen brightness control (`brightnessctl`)
