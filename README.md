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
