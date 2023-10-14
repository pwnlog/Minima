# Minima

The minimal version of Daku without AwesomeWM.

WM:
- BSPWM / SXHKD

Themes:
- Colorful
- Light 
- Dark 

Bars:
- Daku
- Dakura
- Karafuru
- Shisuru

Terminal:
- Alacritty
- Tmux

Launcher:
- Rofi

Editors:
- Neovim

# Install

```sh
./install.sh
```

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

Install treesitter parser for elixir:

```sh
TSInstall elixir
```