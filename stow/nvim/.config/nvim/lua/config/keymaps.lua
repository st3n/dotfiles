-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local discipline = require("igor.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Increment, decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

--Delete a word backwords
-- keymap.set("n", "dw", "vb_d")

-- Select all
keymap.set("n", "<C-b>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move Lines
keymap.set("n", "<A-down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<A-up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("i", "<A-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap.set("i", "<A-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<A-down>", ":m '>+1<cr>gv=gv", { desc = "Move dowN" })
keymap.set("v", "<A-up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Move between splits
-- keymap.set("n", "sh", "<C-w>h")
-- keymap.set("n", "sk", "<C-w>k")
-- keymap.set("n", "sj", "<C-w>j")
-- keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- make split windows equal width & height
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- Diagnostik
keymap.set("n", "<C-j>", function()
  vim.diagnostics.goto_next()
end, opts)

keymap.set("n", "<leader>i", function()
  require("igor.lsp").toggleInlayHints()
end)

keymap.set("n", "<leader>r", function()
  require("igor.hsl").replaceHexWithHSL()
end)

keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume previous search" }
)
