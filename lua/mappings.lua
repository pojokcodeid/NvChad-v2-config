require "nvchad.mappings"
function _NEXT_BUF()
  require("nvchad.tabufline").next()
end

function _PREV_BUF()
  require("nvchad.tabufline").prev()
end

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

-- save insert mode
map("i", "<C-s>", "<esc><cmd>w<cr>i")

-- navigate tabufline left and right
map("n", "<S-h>", "<cmd>lua _PREV_BUF()<cr>")
map("n", "<S-l>", "<cmd>lua _NEXT_BUF()<cr>")

-- load lazygit
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
