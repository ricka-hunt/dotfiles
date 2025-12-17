vim = vim
vim.pack.add({ "https://codeberg.org/trickyni/desert-witch.nvim" })
vim.cmd.colorscheme("desert-witch")
-- vim.api.nvim_set_hl(0, "@lsp.type.operator.qml", { fg = "#e86045" })
-- OPTION  ----------------------------------------------------
--stylua: ignore start
vim.g.mapleader      = " " -- leader key (spacebar)
vim.opt.shortmess:append("Swl")
vim.g.have_nerd_font = true
vim.o.number         = true -- number column
vim.o.relativenumber = true -- relative number column
vim.o.ignorecase     = true -- search ignores case
vim.o.smartcase      = true -- search ignores case unless uppercase letter exists
vim.opt.grepprg      = "rg --vimgrep" -- external grep
vim.o.wrap           = true
vim.o.textwidth      = 80
vim.opt.linebreak    = true
vim.o.tabstop        = 2 -- tab width
vim.o.shiftwidth     = 2 -- indentation width
vim.o.expandtab      = true -- turns tabs into spaces
vim.o.showmode       = false -- hides mode indicator, since we have a status line
vim.o.cursorline     = true -- highlights cursor line
vim.o.scrolloff      = 10 -- keeps 10 lines above/below the cursor when scrolling
vim.o.breakindent    = true
vim.o.signcolumn     = "yes:1" -- gutter to the left of the number column
vim.o.inccommand     = "nosplit" -- shows find/replace results live
vim.opt.backspace    = { "start", "eol", "indent" }
vim.o.list           = true -- whow trailing whitespaces and tab characters
vim.opt.listchars    = {tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.timeoutlen   = 300 --timeout on keys with followups
vim.o.winborder      = "rounded" --border for floating windows

-- KEYMAPS ----------------------------------------------------
-- move line up/down
vim.keymap.set("n", "<S-up>"  , ":m-2<CR>")
vim.keymap.set("n", "<S-down>", ":m+1<CR>")
vim.keymap.set("v", "<S-up>"  , ":'<, '>m '<-2<CR>gv")
vim.keymap.set("v", "<S-down>", ":'<  , '>m '>+1<CR>gv")

-- indent/unindent
vim.keymap.set("n", "<S-right>", ">>")
vim.keymap.set("n", "<S-left>" , "<<")
vim.keymap.set("v", "<S-left>" , "<gv")
vim.keymap.set("v", "<S-right>", ">gv")
--stylua: ignore end

-- creates new buffer
vim.keymap.set("n", "<C-n>", ":enew<CR>")

-- next/prev buffer
vim.keymap.set("n", "<C-]>", ":bn<CR>")
vim.keymap.set("n", "<C-[>", ":bp<CR>")

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Zen Mode
vim.keymap.set("n", "zm", ":ZenMode<CR>")

-- Yazi
vim.keymap.set({ "n", "v" }, "<Bslash>", "<cmd>Yazi<CR>")

-- Rip-substitute
vim.keymap.set({ "n", "x" }, "<leader>s", "<Cmd>RipSubstitute<CR>", { desc = " rip substitutdde" })

-- Diagnostics
vim.keymap.set("n", "<leader>d", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })

-- snacks picker projects
vim.keymap.set("n", "<leader>p", "<cmd>lua Snacks.picker.projects()<CR>", { desc = "Projects" })

-- snacks picker recent files
vim.keymap.set("n", "<leader>r", "<cmd>lua Snacks.picker.recent()<CR>", { desc = "Recent Files" })

-- snacks picker zoxide
vim.keymap.set("n", "<leader>z", "<cmd>lua Snacks.picker.zoxide()<CR>", { desc = "Zoxide" })

-- snacks picker highlights
vim.keymap.set("n", "<leader>h", "<cmd>lua Snacks.picker.highlights()<CR>", { desc = "highlights" })
-- Behaviors --------------------------------------------------
-- defines markers to determine a project's root dir
local project_markers = { ".git", ".root", "cargo.toml", "selene.toml", "stylua.toml", "package.json" }
-- Finds a project's root directory
vim.api.nvim_create_user_command("Root", function()
  print(vim.fs.root(0, project_markers))
end, {})

-- automatically stay on root directory
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
  callback = function()
    vim.cmd.lcd(vim.fs.root(0, project_markers))
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- sync OS/nvim clipboards
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Diagnostic configs ----------------------------
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  update_in_insert = true,
  inlay_hints = true,
})

----------------------------

--Plugins----------------------------------
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/sitiom/nvim-numbertoggle" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/preservim/vim-pencil" },
  { src = "https://github.com/bullets-vim/bullets.vim" },
  { src = "https://github.com/folke/zen-mode.nvim" },
  { src = "https://github.com/folke/twilight.nvim" },
  { src = "https://github.com/nvim-mini/mini.comment" },
  { src = "https://github.com/nvim-mini/mini.surround" },
  { src = "https://github.com/nvim-mini/mini.align" },
  { src = "https://github.com/abecodes/tabout.nvim" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.hipatterns" },
  { src = "https://github.com/nvim-mini/mini.tabline" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/karb94/neoscroll.nvim" },
  { src = "https://github.com/chrisgrieser/nvim-rip-substitute" },
  { src = "https://github.com/mikavilpas/yazi.nvim" },
  { src = "https://github.com/smjonas/live-command.nvim" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/OXY2DEV/helpview.nvim" },
})
require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.align").setup()
require("tabout").setup()
require("neoscroll").setup({ easing = "quintic" })
require("which-key").setup({ preset = "helix", plugins = { presets = { motions = false } } })
require("gitsigns").setup({ signs = { delete = "─" } })
require("yazi").setup()
require("ibl").setup({ indent = { char = "▏", highlight = none }, scope = { enabled = false } })
require("trouble").setup({ focus = true, win = { position = "bottom" }, open_no_results = true })
require("live-command").setup({ commands = { Norm = { cmd = "norm" }, G = { cmd = "g" } } })
vim.cmd("cnoreabbrev norm Norm")
vim.cmd("cnoreabbrev g G")

vim.lsp.enable({
  "lua_ls",
  "cssls",
  "ts_ls",
  "bash_ls",
  "qmlls",
  "html",
})
vim.lsp.config("qmlls", { cmd = { "qmlls6" } })
---conform.nvim-------------------------------------------------------
require("conform").setup({
  format_on_save = true,
  --stylua: ignore start
  formatters_by_ft = {
    sh         = { "shfmt" },
    lua        = { "stylua" },
    javascript = { "prettier" },
    markdown   = { "prettier" },
    html       = { "prettier" },
    css        = { "prettier" },
    yaml       = { "prettier" },
    json       = { "prettier" },
    qml       = { "prettier" },
  },
  formatters   = {
    stylua     = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
    shfmt      = { prepend_args = { "-i = 2" } },
    prettier   = { prepend_args = { "--tab-width", "2" ,"--experimental-ternaries","false"} },
  },
  --stylua: ignore end
})
----------------------------------------------------------------------
--blink.cmp----------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/MahanRahmati/blink-nerdfont.nvim" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
})
require("blink.cmp").setup({
  keymap = { preset = "super-tab" },
  fuzzy = { implementation = "prefer_rust", prebuilt_binaries = { force_version = "0.6.0" } },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    documentation = { auto_show = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "nerdfont" },
    providers = {
      nerdfont = {
        module = "blink-nerdfont",
        name = "Nerd Fonts",
        score_offset = 15, -- Tune by preference
        opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
      },
    },
  },
  cmdline = { enabled = true },
  signature = { enabled = false },
})

----treesitter---------------------------------------------------------
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  -- stylua: ignore start
  ensure_installed = {
    "bash", "caddy", "css",  "csv",      "diff",            "dockerfile", "html",  "javascript",
    "jq",   "json",  "lua",  "markdown", "markdown_inline", "qmljs",      "regex", "sql",
    "toml", "typst", "sway", "vimdoc",   "yaml",
  },
})
-- stylua: ignore end
require("treesitter-context").setup()

---RenderMarkdown-----------------------------------------------------
require("render-markdown").setup({
  render_modes = true,
  completions = { lsp = { enabled = true } },
  checkbox = { checked = { scope_highlight = "RenderMarkdownCheckedItem" } },
  wiki = { scope_highlight = "RenderMarkdownWikiLinkText" },
  bullet = { icons = { "󰆧" } },
  pipe_table = {
    preset = "round",
    alignment_indicator = "┈",
  },
  dash = {
    enabled = true,
    render_modes = false,
    icon = "─",
    width = "full",
    left_margin = 0,
  },
  latex = { enabled = false },
})
---
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.treesitter.start(args.buf, "markdown")
  end,
})
----mini.hipatterns----------------------------------------------------
require("mini.hipatterns").setup({
  highlighters = {
    fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
    hack = { pattern = "HACK", group = "MiniHipatternsHack" },
    todo = { pattern = "TODO", group = "MiniHipatternsTodo" }, --TODO
    note = { pattern = "NOTE", group = "MiniHipatternsNote" },
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
  },
})

----mini.tabline------------------------------------------------------
require("mini.tabline").setup({
  format = function(buf_id, label)
    local suffix = vim.bo[buf_id].modified and "+ " or ""
    return MiniTabline.default_format(buf_id, label) .. suffix
  end,
})

----lualine-----------------------------------------------------------
require("lualine").setup({
  sections = {
    lualine_x = { "lsp_status", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "searchcount", "location" },
  },
})

----rainbow-delimeters----------------------------------------------------
vim.g.rainbow_delimiters = {
  highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    -- "RainbowDelimiterGreen",
    -- "RainbowDelimiterViolet",
    -- "RainbowDelimiterCyan",
  },
  blacklist = { "html" },
}

----snacks-----------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim", { load = false } },
})
require("snacks").setup({
  picker = {
    sources = {
      recent = { layout = { preset = "select" } },
      projects = {
        layout = { preset = "select" },
        patterns = { ".git", "package.json", "Makefile", ".root", "stylua.toml" },
        dev = { "~/git", "~/.shells", "~/.config/nvim" },
      },
      zoxide = { layout = { preset = "select" } },
    },
  },
  dashboard = {
    enabled = true,
    width = 40,
    preset = {
      keys = {
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "\\", desc = "File Explorer", action = ":Yazi" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('recent')" },
        {
          icon = " ",
          key = "p",
          desc = "Projects",
          action = ":lua Snacks.picker.projects()",
        },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
      header = {
        [[
  ,-.       _,---._ __  / \
 /  )    .-'       `./ /   \
(  (   ,'            `/    /|
 \  `-"             \'\   / |
  `.              ,  \ \ /  |
   /`.          ,'-`----Y   |
  (            ;        |   '
  |  ,-.    ,-'         |  /
  |  | (   |            | /
  )  |  \  `.___________|/
  `--'   `--']],
      },
    },
    formats = {},
    sections = {
      { section = "header", indent = 5 },
      { title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { section = "keys", indent = 2, padding = 1 },
    },
  },
})
