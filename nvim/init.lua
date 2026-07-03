vim.g.mapleader = ","
vim.g.maplocalleader = ","

local python3_host = "/home/shaofeiw/miniconda3/bin/python3"
if vim.fn.executable(python3_host) == 1 then
  vim.g.python3_host_prog = python3_host
end

vim.opt.history = 500
vim.opt.autoread = true
vim.opt.scrolloff = 7
vim.opt.wildmenu = true
vim.opt.wildignore = {
  "*.o",
  "*~",
  "*.pyc",
  "*/.git/*",
  "*/.hg/*",
  "*/.svn/*",
  "*/.DS_Store",
}
vim.opt.ruler = true
vim.opt.cmdheight = 1
vim.opt.hidden = true
vim.opt.backspace = { "eol", "start", "indent" }
vim.opt.whichwrap:append({ ["<"] = true, [">"] = true, h = true, l = true })
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.magic = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.foldcolumn = "1"
vim.opt.background = "dark"
vim.opt.encoding = "utf-8"
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.linebreak = true
vim.opt.textwidth = 500
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.laststatus = 2
vim.opt.statusline = [[\ %{&paste?'PASTE MODE  ':''}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c]]
vim.opt.omnifunc = "ale#completion#OmniFunc"

vim.cmd.colorscheme("desert")
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.ale_sign_error = "●"
vim.g.ale_sign_warning = "."
vim.g.ale_linters = {
  python = { "pylsp" },
  cpp = { "clangd" },
  cuda = { "nvcc", "clangd" },
}
vim.g.ale_fixers = {
  ["*"] = {},
  python = { "black" },
}
vim.g.ale_completion_enabled = 1
vim.g.ale_hover_to_floating_preview = 1
vim.g.ale_set_echo = 0
vim.g.ale_virtualtext_cursor = 0
vim.g.vimspector_install_gadgets = { "debugpy", "vscode-cpptools", "CodeLLDB" }
vim.g.vimspector_enable_mappings = "HUMAN"

require("lazy").setup({
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  { "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
  { "dense-analysis/ale" },
  { "puremourning/vimspector" },
  { "preservim/nerdtree" },
}, {
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
})

vim.keymap.set("n", "<leader>w", ":w!<CR>")
vim.api.nvim_create_user_command("W", "w !sudo tee % > /dev/null | edit!", {})
vim.keymap.set("n", "<Space>", "/", { remap = true })
vim.keymap.set("n", "<C-Space>", "?", { remap = true })
vim.keymap.set("n", "<leader><CR>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-W>j", { remap = true })
vim.keymap.set("n", "<C-k>", "<C-W>k", { remap = true })
vim.keymap.set("n", "<C-h>", "<C-W>h", { remap = true })
vim.keymap.set("n", "<C-l>", "<C-W>l", { remap = true })
vim.keymap.set("n", "<leader>bd", ":Bclose<CR>:tabclose<CR>gT", { remap = true })
vim.keymap.set("n", "<leader>ba", ":bufdo bd<CR>", { remap = true })
vim.keymap.set("n", "<leader>l", ":bnext<CR>", { remap = true })
vim.keymap.set("n", "<leader>h", ":bprevious<CR>", { remap = true })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { remap = true })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { remap = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { remap = true })
vim.keymap.set("n", "<leader>tm", ":tabmove ", { remap = true })
vim.keymap.set("n", "<leader>t<leader>", ":tabnext<CR>", { remap = true })
vim.keymap.set("n", "<leader>te", ':tabedit <C-r>=expand("%:p:h")<CR>/', { remap = true })
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { remap = true })
vim.keymap.set("n", "0", "^", { remap = true })
vim.keymap.set("n", "<M-j>", "mz:m+<CR>`z", { remap = true })
vim.keymap.set("n", "<M-k>", "mz:m-2<CR>`z", { remap = true })
vim.keymap.set("v", "<M-j>", ":m'>+<CR>`<my`>mzgv`yo`z", { remap = true })
vim.keymap.set("v", "<M-k>", ":m'<-2<CR>`>my`<mzgv`yo`z", { remap = true })
vim.keymap.set("n", "<leader>ss", ":setlocal spell!<CR>", { remap = true })
vim.keymap.set("n", "<leader>sn", "]s", { remap = true })
vim.keymap.set("n", "<leader>sp", "[s", { remap = true })
vim.keymap.set("n", "<leader>sa", "zg", { remap = true })
vim.keymap.set("n", "<leader>s?", "z=", { remap = true })
vim.keymap.set("n", "<leader>q", ":e ~/buffer<CR>", { remap = true })
vim.keymap.set("n", "<leader>x", ":e ~/buffer.md<CR>", { remap = true })
vim.keymap.set("n", "<leader>pp", ":setlocal paste!<CR>", { remap = true })

vim.keymap.set("n", "<leader><tab>", "<plug>(fzf-maps-n)", { remap = true })
vim.keymap.set("x", "<leader><tab>", "<plug>(fzf-maps-x)", { remap = true })
vim.keymap.set("o", "<leader><tab>", "<plug>(fzf-maps-o)", { remap = true })
vim.keymap.set("n", "<leader>f", ":<C-u>ALEFix<CR>")
vim.keymap.set("n", "<leader>h", ":ALEHover<CR>")
vim.keymap.set("n", "<leader>d", ":ALEGoToDefinition<CR>")
vim.keymap.set("n", "<leader>dt", ":ALEGoToDefinition -tab<CR>")
vim.keymap.set("i", "<C-x><C-k>", "<plug>(fzf-complete-word)", { remap = true })
vim.keymap.set("i", "<C-x><C-f>", "<plug>(fzf-complete-path)", { remap = true })
vim.keymap.set("i", "<C-x><C-l>", "<plug>(fzf-complete-line)", { remap = true })

local lasttab = 1
vim.keymap.set("n", "<leader>tl", function()
  vim.cmd("tabn " .. lasttab)
end)
vim.api.nvim_create_autocmd("TabLeave", {
  callback = function()
    lasttab = vim.fn.tabpagenr()
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.fn.line([['"]])
    if mark > 1 and mark <= vim.fn.line("$") then
      vim.cmd([[normal! g'"]])
    end
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.txt", "*.js", "*.py", "*.wiki", "*.sh", "*.coffee" },
  callback = function()
    local cursor = vim.fn.getpos(".")
    local search = vim.fn.getreg("/")
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.setpos(".", cursor)
    vim.fn.setreg("/", search)
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(event)
    vim.keymap.set("v", "<leader>f", ":!black-macchiato<CR>", { buffer = event.buf })
  end,
})

vim.api.nvim_create_user_command("Bclose", function()
  local current = vim.fn.bufnr("%")
  local alternate = vim.fn.bufnr("#")
  if vim.fn.buflisted(alternate) == 1 then
    vim.cmd("buffer #")
  else
    vim.cmd("bnext")
  end
  if vim.fn.bufnr("%") == current then
    vim.cmd("new")
  end
  if vim.fn.buflisted(current) == 1 then
    vim.cmd("bdelete! " .. current)
  end
end, {})
