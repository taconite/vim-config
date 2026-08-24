# Vim and NeoVim configuration for Python/C++ development

This repository keeps the legacy Vim configuration and the NeoVim configuration side by side:

- `nvim/` is the primary NeoVim config and uses `lazy.nvim`.
- `vim/` is the legacy Vim config and uses `vim-plug`.

Plugin source directories are intentionally not committed. Both editors install plugins from the official upstream repositories.

## Prerequisites

- NeoVim 0.11 or newer
- Vim for the legacy configuration
- git
- Optional: [ripgrep](https://github.com/BurntSushi/ripgrep) for fzf-backed search
- Optional Python tooling: `python-lsp-server`, `flake8`, `black`, `black-macchiato`
- Optional C++ tooling: [clangd](https://clangd.llvm.org/installation.html)

Install the optional Python tools in the environment you use for development:

```bash
pip install python-lsp-server flake8 black black-macchiato
```

## NeoVim installation

Link the NeoVim config directory:

```bash
ln -s ~/Tools/vim-config/nvim ~/.config/nvim
```

Start NeoVim or run a headless sync:

```bash
nvim --headless "+Lazy! sync" +qa
```

The NeoVim plugin stack is managed by `lazy.nvim` and includes:

- `junegunn/fzf`
- `junegunn/fzf.vim`
- `dense-analysis/ale`
- `puremourning/vimspector`
- `preservim/nerdtree`

The lockfile lives at `nvim/lazy-lock.json` and should be committed after plugin updates.

## Code completion

LLM code completion is provided by [Minuet](https://github.com/milanglacier/minuet-ai.nvim) using its standalone virtual-text (ghost text) frontend, configured in `nvim/init.lua` with DeepSeek's native FIM (fill-in-the-middle) backend (`deepseek-v4-flash` at `https://api.deepseek.com/beta/completions`). It auto-triggers for all filetypes (`auto_trigger_ft = { "*" }`).

Before use, export your API key in the shell that starts nvim (API keys live in the environment and are never committed):

```bash
export DEEPSEEK_API_KEY="sk-..."
```

Keymaps in insert mode: `<A-A>` accept, `<A-a>` accept line, `<A-z>` accept n lines, `<A-]>` next, `<A-[>` prev, `<A-e>` dismiss.

## Vim installation

Link the legacy Vim config:

```bash
ln -s ~/Tools/vim-config/vim ~/.vim
ln -s ~/Tools/vim-config/vim/vimrc ~/.vimrc
```

Start Vim and install plugins:

```vim
:PlugInstall
```

The Vim plugin stack is managed by `vim-plug` from `vim/autoload/plug.vim`.

## Updating plugins

For NeoVim:

```vim
:Lazy update
```

Then commit the updated `nvim/lazy-lock.json`.

For Vim:

```vim
:PlugUpdate
```

## Known issue

`clang++` can be broken with the default Ubuntu 22 installation. This affects `clangd` in multiple editors. One fix is:

```bash
sudo apt install g++-12
```

## Acknowledgement

The first part of `vim/vimrc` is adapted from [basic.vim](https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim) by [Amir Salihefendic](https://github.com/amix).
