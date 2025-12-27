# Seoulism

A Vim and Neovim colorscheme inspired by Korean color tradition and modern Seoul light.

![Preview](./preview.png)

Seoulism translates Korean color sources into a clean dark UI palette with strong contrast—quiet enough for deep work, sharp enough for structure.

Best with:

- `set termguicolors` (requires a truecolor-capable terminal)

---

## Quick Start

### Vim / Neovim (after installing the plugin)

```vim
set termguicolors
colorscheme seoulism
```

---

## A Korean palette, made readable

Seoulism takes Korean color sources and translates them into a modern UI palette designed for clarity and hierarchy.

### A Gentle Chain of Colors: Five Directional Color Model

**Eastern aesthetics are more than a "Zen" cliché; they represent a centuries-old cognitive system.**

I have spent time developing **Seoulism**, a Vim theme that approaches Eastern aesthetics from a systemic and structural perspective. The goal is to move away from purely mystical or exotic interpretations.

While the "Five Directional Colors" (오방색, 五方色) originated in broader East Asian philosophy (commonly linked to Zou Yan and early Chinese cosmology), its real value lies in how it was localized and reconfigured into a rigorous system of order within Korean culture. By stripping away mystical layers, I focused on the structural core: color as a cognitive system for organizing hierarchy and meaning.

#### Beyond the "Zen" cliché

This theme is not about "oriental minimalism." It treats color as functional UI logic: accents are not decoration, but tools for categorizing structure.

#### The Principle of "Scene First, Emotion Later" (선경후정, 先景後情)

In this hierarchy, code is the "Scene"—the functional reality—and is rendered with maximum clarity. Comments (human annotation) are intentionally receded so that sentiment never competes with structure.

#### Pine Ink Black

Korean visual preference often leans toward matte black with a faint blue cast rather than flat pure black. This tone softens the canvas while keeping edges crisp, designed to support flow without getting in your way.

#### A living legacy

This is not presented as a museum relic. The system lives on as an implicit logic of order—visible today in modern Korean visual culture and engineering sensibilities.

If neon-saturated themes feel too loud for long sessions, Seoulism aims to stay grounded, readable, and calm.

---

## A Chain of Colors

![Visualizer](./visualizer.png)
![Pentagon](./pentagon_cycle.png)

These diagrams illustrate the cognitive transformation from ancestral elemental anchors to modern UI tokens.

---

## What inspired the colors

* **Traditional Korean five-color system (오방색)**
  A framework around five symbolic colors: blue, red, yellow, white, and black.
  Seoulism uses this as a guide for balanced accents and clear hierarchy.

* **Indigo dyeing**
  Deep blues shaped by fabric dye texture rather than flat digital blue.

* **Metallic pigments**
  Highlights inspired by mineral/metal-like pigments seen in traditional decorative work.

* **Safflower red dye**
  Reds tuned to feel warm and vivid—more like natural dye than “error-only” red.

* **Pine ash black**
  Matte black tuned with a subtle blue glint.

* **Reflective selection**
  Visual selection turns into a bright reflective white, like a spotlight on a paper-like canvas.

---

## Install

### Vim-plug (Vim / Neovim)

```vim
call plug#begin()
Plug 'gg582/seoulism.vim'
call plug#end()

set termguicolors
colorscheme seoulism
```

### Vundle (Vim)

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
colorscheme seoulism
```

Then run:

* `:PluginInstall`

### Native package install (Vim 8+)

```sh
git clone https://github.com/gg582/seoulism.vim.git ~/.vim/pack/seoulism/start/seoulism
```

Then in your vimrc:

```vim
set termguicolors
colorscheme seoulism
```

### Manual

* Vim: `~/.vim/colors/seoulism.vim`
* Neovim: `~/.config/nvim/colors/seoulism.vim`

```vim
set termguicolors
colorscheme seoulism
```

---

## Code Tendency Checker

Seoulism provides an optional "tendency checker" inspired by the five-color system.
It reads your code as a structural mix and reports a dominant tendency profile.

### Commands

```vim
:wopp                 " turn on the tendency checker
:noopp                " turn off the tendency checker
:warncfg <0-100>      " set the sensitivity (percent)
```

### How `:warncfg` works

* `:warncfg {0-100}` sets the minimum strength (in percent) required for a tendency to be reported.
* **Higher values suppress more output** (stricter filter; less sensitive).
* **Lower values show more output** (looser filter; more sensitive).
* If your file mixes multiple roles heavily, weaker signals may be filtered out depending on this setting.

A practical starting point:

* `:warncfg 10`  show more (loose)
* `:warncfg 30`  balanced
* `:warncfg 60`  show less (strict)

---

### Code Tendency Mapping

| Dominance        | Core Tendency           | Structural Context                                                               |
| ---------------- | ----------------------- | -------------------------------------------------------------------------------- |
| **WOOD** (Jade)  | **Declarative Birth**   | **Header files**, interface contracts, function prototypes, and API definitions  |
| **FIRE** (Red)   | **Operational Heat**    | **Control flow**, main loops, exception handling, and dynamic execution          |
| **EARTH** (Gold) | **Stable Root**         | **Config tables**, constant mappings, hardcoded literals, and resource datasets  |
| **METAL** (Base) | **Structural Rigidity** | **Type definitions**, static schemas, system boilerplate, and memory allocations |
| **WATER** (Void) | **Implicit Space**      | **Documentation blocks**, extensive comments, delimiters, and metadata           |

---

### Dynamic Balance Tendency

| Dominant Interaction | Code Personality                                                                 |
| -------------------- | -------------------------------------------------------------------------------- |
| **WOOD ➔ EARTH**     | **Pure Abstraction**: Focuses on defining high-level interfaces over raw data    |
| **EARTH ➔ WATER**    | **Data Concentration**: Optimized for dense storage and literal-heavy structure  |
| **WATER ➔ FIRE**     | **Contextual Clarity**: Prioritizes documentation and human-readable explanation |
| **FIRE ➔ METAL**     | **Logic Agility**: Prioritizes branching execution and dynamic algorithmic flow  |
| **METAL ➔ WOOD**     | **Architectural Integrity**: Focuses on type safety and rigid system boundaries  |

---

## Palette

![Code Example](./code_example.png)

---

## Notes

* A truecolor terminal is strongly recommended.
* If your terminal does not support truecolor, the palette may flatten and reduce contrast.

---

## License

See `LICENSE` (or the repository license file).
