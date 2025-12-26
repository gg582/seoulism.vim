# Seoulism

A Vim and Neovim colorscheme inspired by Korean color tradition and modern Seoul light.

Best with:

* `set termguicolors`

## A Korean palette, made readable

Seoulism takes Korean color sources and translates them into a clean dark UI palette with strong contrast.

### What inspired the colors

- The traditional Korean five-color system  
  A classic framework built around five symbolic colors: blue, red, yellow, white, and black.  
  Seoulism uses this as a guide for balanced accents and clear visual hierarchy.

- Indigo dyeing  
  Deep blues shaped by the look of dyed fabric rather than flat digital blue.

- Metallic pigments  
  Bold highlights inspired by mineral and metal-like pigments seen in traditional decorative work.

- Safflower red dye  
  Reds tuned to feel warm and vivid, closer to natural dye than “error-only” red.

## Install

### Vundle

```vim
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'gg582/seoulism.vim'

call vundle#end()
filetype plugin indent on

set termguicolors
colorscheme Seoulism
````

Run:

* `:PluginInstall`

### Manual

* Vim: `~/.vim/colors/Seoulism.vim`
* Neovim: `~/.config/nvim/colors/Seoulism.vim`

```vim
set termguicolors
colorscheme Seoulism
```

## Palette

[Color Palette](./preview.png)
[Code Example](./code_example.png)
