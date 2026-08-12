vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt
local config_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

opt.history = 500
opt.autoread = true
opt.scrolloff = 7
opt.wildmenu = true
opt.wildignore = { "*.o", "*~", "*.pyc", "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.DS_Store" }
opt.ruler = true
opt.cmdheight = 1
opt.hidden = true
opt.backspace = { "eol", "start", "indent" }
opt.whichwrap:append("<,>,h,l")
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.lazyredraw = true
opt.magic = true
opt.showmatch = true
opt.matchtime = 2
opt.errorbells = false
opt.visualbell = false
opt.foldcolumn = "1"
opt.signcolumn = "yes:2"
opt.background = "dark"
opt.encoding = "utf-8"
opt.fileformats = { "unix", "dos", "mac" }
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.linebreak = true
opt.textwidth = 500
opt.autoindent = true
opt.smartindent = true
opt.wrap = true
opt.laststatus = 2
opt.switchbuf = { "useopen", "usetab", "newtab" }
opt.showtabline = 2
opt.statusline = " %{v:lua.StatusPaste()}%F%m%r%h %w  CWD: %r%{getcwd()}%h   Line: %l  Column: %c"

vim.g.python3_host_prog = "/home/shaofeiw/miniconda3/bin/python3"

vim.cmd.syntax("enable")
pcall(vim.cmd.colorscheme, "desert")
vim.cmd.filetype("plugin indent on")

function _G.StatusPaste()
  return vim.o.paste and "PASTE MODE  " or ""
end

vim.api.nvim_create_user_command("W", "w !sudo tee % > /dev/null | edit!", {})

vim.api.nvim_create_user_command("Bclose", function()
  local current = vim.api.nvim_get_current_buf()
  local alternate = vim.fn.bufnr("#")

  if alternate > 0 and vim.fn.buflisted(alternate) == 1 then
    vim.cmd.buffer(alternate)
  else
    vim.cmd.bnext()
  end

  if vim.api.nvim_get_current_buf() == current then
    vim.cmd.new()
  end

  if vim.fn.buflisted(current) == 1 then
    vim.cmd.bdelete({ args = tostring(current), bang = true })
  end
end, {})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 1 and mark[1] <= line_count then
      pcall(vim.cmd.normal, { args = { "g`\"" }, bang = true })
    end
  end,
})

vim.api.nvim_create_autocmd("TabLeave", {
  callback = function()
    vim.g.lasttab = vim.fn.tabpagenr()
  end,
})

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>w", "<cmd>w!<cr>")
map("n", "<leader><cr>", "<cmd>nohlsearch<cr>")
map("n", "<Space>", "/")
map("n", "<C-Space>", "?")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<leader>bd", "<cmd>Bclose<cr><cmd>tabclose<cr>gT")
map("n", "<leader>ba", "<cmd>bufdo bd<cr>")
map("n", "<leader>l", "<cmd>bnext<cr>")
map("n", "<leader>tn", "<cmd>tabnew<cr>")
map("n", "<leader>to", "<cmd>tabonly<cr>")
map("n", "<leader>tc", "<cmd>tabclose<cr>")
map("n", "<leader>tm", ":tabmove ")
map("n", "<leader>t<leader>", "<cmd>tabnext<cr>")
map("n", "<leader>tl", function()
  vim.cmd("tabnext " .. tostring(vim.g.lasttab or 1))
end)
map("n", "<leader>te", ':tabedit <C-r>=expand("%:p:h")<cr>/', { silent = false })
map("n", "<leader>cd", "<cmd>cd %:p:h<cr><cmd>pwd<cr>")
map("n", "0", "^")
map("n", "<M-j>", "mz:m+<cr>`z")
map("n", "<M-k>", "mz:m-2<cr>`z")
map("v", "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z")
map("v", "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z")
map("n", "<leader>ss", "<cmd>setlocal spell!<cr>")
map("n", "<leader>sn", "]s")
map("n", "<leader>sp", "[s")
map("n", "<leader>sa", "zg")
map("n", "<leader>s?", "z=")
map("n", "<leader>q", "<cmd>edit ~/buffer<cr>")
map("n", "<leader>x", "<cmd>edit ~/buffer.md<cr>")
map("n", "<leader>pp", "<cmd>setlocal paste!<cr>")
map("n", "<leader>m", "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm")

map("v", "*", function()
  local saved = vim.fn.getreg('"')
  vim.cmd.normal({ args = { "gvy" }, bang = true })
  local pattern = vim.fn.escape(vim.fn.getreg('"'):gsub("\n$", ""), [[\/.*'$^~[]])
  vim.fn.setreg("/", pattern)
  vim.fn.setreg('"', saved)
  vim.cmd("/" .. pattern)
end)

map("v", "#", function()
  local saved = vim.fn.getreg('"')
  vim.cmd.normal({ args = { "gvy" }, bang = true })
  local pattern = vim.fn.escape(vim.fn.getreg('"'):gsub("\n$", ""), [[\/.*'$^~[]])
  vim.fn.setreg("/", pattern)
  vim.fn.setreg('"', saved)
  vim.cmd("?" .. pattern)
end)

local function toggle_diagnostic_signs()
  local config = vim.diagnostic.config()
  vim.diagnostic.config({ signs = not config.signs })
  print(config.signs and "LSP diagnostic signs disabled" or "LSP diagnostic signs enabled")
end

map("n", "<leader>ld", toggle_diagnostic_signs, { desc = "Toggle LSP diagnostic signs" })

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

require("lazy").setup({
  {
    "junegunn/fzf",
    build = "./install --bin",
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
  },
  {
    "dense-analysis/ale",
    init = function()
      vim.g.ale_sign_error = "E"
      vim.g.ale_sign_warning = "W"
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
    end,
  },
  {
    "puremourning/vimspector",
    init = function()
      vim.g.vimspector_install_gadgets = { "debugpy", "vscode-cpptools", "CodeLLDB" }
      vim.g.vimspector_enable_mappings = "HUMAN"
    end,
  },
  {
    "preservim/nerdtree",
  },
  {
    "nvim-mini/mini.diff",
    config = function()
      local minidiff = require("mini.diff")
      minidiff.setup({
        view = {
          style = "sign",
          signs = { add = "+", change = "~", delete = "-" },
        },
        mappings = {
          apply = "",
          reset = "",
          textobject = "ih",
          goto_first = "",
          goto_prev = "[c",
          goto_next = "]c",
          goto_last = "",
        },
      })

      local function set_minidiff_highlights()
        local highlights = {
          MiniDiffSignAdd = { fg = "#5faf5f", ctermfg = 71 },
          MiniDiffSignChange = { fg = "#ffaf00", ctermfg = 214 },
          MiniDiffSignDelete = { fg = "#ff5f5f", ctermfg = 203 },
          MiniDiffOverAdd = { fg = "#ffffff", bg = "#005f00", ctermfg = 231, ctermbg = 22 },
          MiniDiffOverChange = { fg = "#ffffff", bg = "#870000", ctermfg = 231, ctermbg = 88 },
          MiniDiffOverChangeBuf = { fg = "#ffffff", bg = "#005f00", ctermfg = 231, ctermbg = 22 },
          MiniDiffOverContext = { fg = "#ffffff", bg = "#5f0000", ctermfg = 231, ctermbg = 52 },
          MiniDiffOverContextBuf = {},
          MiniDiffOverDelete = { fg = "#ffffff", bg = "#5f0000", ctermfg = 231, ctermbg = 52 },
        }

        for group, opts in pairs(highlights) do
          vim.api.nvim_set_hl(0, group, opts)
        end
      end

      set_minidiff_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_minidiff_highlights,
        desc = "Restore clear mini.diff add/change/delete colors",
      })

      -- Diff current buffer against an arbitrary git ref (branch/commit/tag).
      -- pi.nvim hunk commands read MiniDiff.get_buf_data(), so they keep
      -- working with this reference text.
      local function git_base_source(base)
        local name = "git-base:" .. base
        return {
          name = name,
          attach = function(buf_id)
            local buf_name = vim.api.nvim_buf_get_name(buf_id)
            if buf_name == "" then
              return minidiff.fail_attach(buf_id)
            end
            local path = vim.uv.fs_realpath(buf_name) or vim.fn.fnamemodify(buf_name, ":p")
            local cwd = vim.fn.fnamemodify(path, ":h")
            local obj = base .. ":./" .. vim.fn.fnamemodify(path, ":t")
            -- Ignore results if the buffer switched source while git ran
            local function is_active()
              if not vim.api.nvim_buf_is_valid(buf_id) then
                return false
              end
              local data = minidiff.get_buf_data(buf_id)
              local source = data and data.config.source
              return source ~= nil and source.name == name
            end
            -- Validate the ref first (also fails outside a git repo) so that
            -- a failed `git show` unambiguously means the path has no blob
            -- at the ref, i.e. a new file relative to it.
            vim.system({ "git", "rev-parse", "--verify", "--quiet", base }, { cwd = cwd }, function(ver)
              vim.schedule(function()
                if not is_active() then
                  return
                end
                if ver.code ~= 0 then
                  return minidiff.fail_attach(buf_id)
                end
                vim.system({ "git", "show", obj }, { cwd = cwd }, function(out)
                  vim.schedule(function()
                    if not is_active() then
                      return
                    end
                    if out.code ~= 0 then
                      return minidiff.set_ref_text(buf_id, "")
                    end
                    minidiff.set_ref_text(buf_id, out.stdout:gsub("\r\n", "\n"))
                  end)
                end)
              end)
            end)
          end,
          detach = function() end,
        }
      end

      vim.api.nvim_create_user_command("DiffBase", function(opts)
        local bufnr = vim.api.nvim_get_current_buf()
        if opts.args == "" then
          vim.b[bufnr].minidiff_config = nil
        else
          vim.b[bufnr].minidiff_config = { source = git_base_source(opts.args) }
        end
        minidiff.disable(bufnr)
        minidiff.enable(bufnr)
      end, {
        nargs = "?",
        desc = "Diff buffer against a git ref; no argument restores diff against the index",
      })
    end,
  },
  {
    dir = "/home/shaofeiw/Tools/pi-nvim",
    name = "pi.nvim",
    lazy = false,
  },
}, {
  lockfile = config_dir .. "/lazy-lock.json",
  change_detection = { notify = false },
})

map({ "n", "x", "o" }, "<leader><tab>", function()
  local mode = vim.fn.mode()
  if mode == "n" then
    return "<plug>(fzf-maps-n)"
  elseif mode == "v" or mode == "V" or mode == "\22" then
    return "<plug>(fzf-maps-x)"
  end
  return "<plug>(fzf-maps-o)"
end, { expr = true })

map("i", "<C-x><C-k>", "<plug>(fzf-complete-word)")
map("i", "<C-x><C-f>", "<plug>(fzf-complete-path)")
map("i", "<C-x><C-l>", "<plug>(fzf-complete-line)")
map("n", "<leader>f", "<cmd>ALEFix<cr>")
map("n", "<leader>h", "<cmd>ALEHover<cr>")
map("n", "<leader>d", "<cmd>ALEGoToDefinition<cr>")
map("n", "<leader>dt", "<cmd>ALEGoToDefinition -tab<cr>")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    map("v", "<leader>f", ":!black-macchiato<cr>", { buffer = true })
  end,
})
