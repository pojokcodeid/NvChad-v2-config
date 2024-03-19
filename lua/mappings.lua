require "nvchad.mappings"

function _LAZYGIT_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
  lazygit:toggle()
end

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "q", "<cmd>q<cr>")
-- for comment string mapp CTRL + /
map("n", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("n", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("v", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i")
map("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i")
map("n", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i")
map("n", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i")

-- diplicate line SHIFT + UP/Down
-- Move line ALT + UP/Down
map("n", "<S-Down>", "<cmd>t.<cr>")
map("i", "<S-Down>", "<cmd>t.<cr>")
map("n", "<S-Up>", "<cmd>t -1<cr>")
map("i", "<S-Up>", "<cmd>t -1<cr>")
map("n", "<M-Down>", "<cmd>m+<cr>")
map("i", "<M-Down>", "<cmd>m+<cr>")
map("n", "<M-Up>", "<cmd>m-2<cr>")
map("i", "<M-Up>", "<cmd>m-2<cr>")
map("x", "<S-Down>", ":'<,'>t'><cr>")

-- load lazygit
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
