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

# Documentation

Read the documentation at the [wiki](https://github.com/pwnlog/Minima/wiki) site to learn how to use this configuration.

# Install

Install the configuration in your host:

```sh
./install.sh
```

> [!NOTE]
> Do NOT run this script with root or sudo, please read the [wiki installation](https://github.com/pwnlog/Minima/wiki/Installation) page for more information.

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
