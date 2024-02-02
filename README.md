# Custom vim configuration for Python/C++ development
## Prerequisite 
1. Vim 9.0749 or above
2. [node.js](https://nodejs.org/en/download)
3. [ripgrep](https://github.com/BurntSushi/ripgrep)
4. (Optional) [clangd](https://clangd.llvm.org/installation.html) (for C++ development)
5. (Optional) For C++ development)

## Installation
1. Copy `.vimrc` and `.vim` to your home directory.
2. Start Vim and invoke `:PlugInstall` to install plugins.
3. (Optional) Invoke `:Copilot setup` to setup [GitHub Copilot](https://github.com/features/copilot). You need to have a subscription in order to enable it.
4. (Optional) Under your Python environment, install LSP, linter, and code formatter:
```bash
pip install python-lsp-server flake8 black black-macchiato
```
5. (Optional) Install C++ LSP of your choice. [clangd](https://clangd.llvm.org/installation.html) is recommended.

## Know Issues
1. `clang++` is broken with default Ubuntu 22 installation. This affects usage of `clangd` with various IDEs. To fix it, try the following:
```bash
sudo apt install g++-12
```

## Acknowledgement
Line 1-384 of `.vimrc` are copied from [basic.vim](https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim) by [Amir Salihefendic](https://github.com/amix)
