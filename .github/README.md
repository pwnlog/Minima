# Minima

A minimalistic pentesting setup.

<div>

<table align=left><tr><td>
<b>- Window Manager: </b><br />
<b>- Bar: </b><br />
<b>- Application Launcher: </b><br />
<b>- Compositor: </b><br />
<b>- Terminal: </b><br />
<b>- Shell: </b><br />
<b>- Editor: </b><br />
<b>- Wallpaper: </b><br />
</table>

<table><tr><td>
<a href="https://github.com/baskerville/bspwm">BSPWM</a><br />
<a href="https://github.com/polybar/polybar">Polybar</a><br />
<a href="https://github.com/davatorium/rofi">Rofi</a><br />
<a href="https://github.com/yshui/picom">Picom</a><br />
<a href="https://alacritty.org/">Alacritty</a><br />
<a href="https://www.zsh.org">Zsh</a><br />
<a href="https://nvchad.com/">Neovim</a><br />
<a href="https://github.com/derf/feh">Feh</a><br />
</table>
</div>

# Table of Contents

- [Documentation](#documentation)
- [Themes](#themes)
- [Gallery](#gallery)
- [Install](#install)

# Documentation

Read the documentation at the [wiki](https://github.com/pwnlog/Minima/wiki) site to learn how to use this configuration.

# Themes

<div align="center">
<b>Colorful Theme / Wallpapers Colors</b>

<img src="assets/img/colorful-theme.png" width="500px" alt="colorful preview"></a>
</div>

<div align="center">
<b>Light Theme</b>

<img src="assets/img/light-theme.png" width="500px" alt="colorful preview"></a>
</div>

<div align="center">
<b>Dark Theme</b>

<img src="assets/img/dark-theme.png" width="500px" alt="colorful preview"></a>
</div>

# Gallery

<div align="center">
<b>Colorful Preview</b>

<img src="assets/gifs/change-colors.gif" width="500px" alt="colorful preview"></a>
</div>
> [!NOTE]
> The **colorful theme** applies the colors of the wallpaper to the system UI

<div align="center">
<b>Animated Wallpapers</b>

<img src="assets/gifs/video.gif" width="500px" alt="colorful preview"></a>

</div>

<div align="center">
<b>Multiple Bars</b>

<img src="assets/gifs/default-polybar.gif" width="500px" alt="colorful preview"></a>

</div>

> [!NOTE]
> The **bars** can be moved to the `top` or `bottom` of the screen.

<div align="center">
<b>Bar Themes</b>

> [!NOTE]
> If the **colorful theme** is enabled then the bars will use the colors of the wallpaper.

Light Daku bar:

<img src="assets/img/light-theme-daku.png" width="500px" alt="light theme daku"></a>

Light Dakura bar:

<img src="assets/img/light-theme-dakura.png" width="500px" alt="light theme dakura"></a>

Light Karafuru bar:

<img src="assets/img/light-theme-karafuru.png" width="500px" alt="light theme karafuru"></a>

Light Shisuru bar:

<img src="assets/img/light-theme.png" width="500px" alt="light theme karafuru"></a>

Dark Daku bar:

<img src="assets/img/dark-theme-daku.png" width="500px" alt="light theme daku"></a>

Dark Dakura bar:

<img src="assets/img/dark-theme-dakura.png" width="500px" alt="light theme dakura"></a>

Dark Karafuru bar:

<img src="assets/img/dark-theme-karafuru.png" width="500px" alt="light theme karafuru"></a>

Dark Shisuru bar:

<img src="assets/img/dark-theme.png" width="500px" alt="light theme karafuru"></a>

</div>

<div align="center">
<b>Change Corners</b>

<img src="assets/gifs/change-corners.gif" width="500px" alt="colorful preview"></a>

</div>

<div align="center">
<b>Change Wallpapers</b>

<img src="assets/gifs/change-wallpaper.gif" width="500px" alt="colorful preview"></a>

</div>

<div align="center">
<b>Wallpapers Selector</b>

<img src="assets/gifs/wallpaper-selector.gif" width="500px" alt="colorful preview"></a>

</div>

> [!NOTE]
> Additional information about themes can be found in the [features page](https://github.com/pwnlog/Minima/wiki/Features) of the wiki site. Information about wallpapers can be found at the installation page in the [wallpapers section](https://github.com/pwnlog/Minima/wiki/Installation#Wallpapers).

# Install

Install the configuration in your host:

```sh
./install.sh
```

> [!NOTE]
> Do NOT run this script with root or sudo; please read the [wiki installation page](https://github.com/pwnlog/Minima/wiki/Installation) for more information.

## Neovim 

Install the language servers:

```sh
MasonInstallAll
```

Install treesitter parser for syntax highlighting:

```sh
TSInstall all
```

> [!WARNING]
> This can be slow and may crash neovim.

Install treesitter parser for some languages:

```sh
TSInstall elixir bash python rust go lua perl
```