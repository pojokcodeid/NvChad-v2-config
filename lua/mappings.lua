require "nvchad.mappings"

function _LAZYGIT_TOGGLE()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
  lazygit:toggle()
end

-- add yours here

-- function for close all bufferline
function _CLOSE_ALL_BUFFER()
  local buf_active = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.t.bufs) do
    if buf ~= buf_active then
      require("bufdelete").bufdelete(buf, true)
    end
  end
end

function _CLOSE_BUF_LEFT()
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.t.bufs) do
    if bufnr == current then
      break
    end
    require("bufdelete").bufdelete(bufnr, true)
  end
end

function _CLOSE_BUF_RIGHT()
  local current = vim.api.nvim_get_current_buf()
  local after_current = false
  for _, bufnr in ipairs(vim.t.bufs) do
    if after_current then
      require("bufdelete").bufdelete(bufnr, true)
    end
    if bufnr == current then
      after_current = true
    end
  end
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

-- load lazygit
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
-- delete buffer
map("n", "<leader>d", "<cmd>lua _CLOSE_ALL_BUFFER()<cr>", { desc = "Delete All Buffer" })
map("n", "<leader>k", "<cmd>lua _CLOSE_BUF_LEFT()<cr>", { desc = "Delete Buffer Left" })
map("n", "<leader>K", "<cmd>lua _CLOSE_BUF_RIGHT()<cr>", { desc = "Delete Buffer Right" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
