local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.opt.statusline = "%#normal# "
  end,
})

local opt = vim.opt
opt.cmdheight = 0

require "custom.configs.format_onsave"

local lpath = vim.fn.stdpath "config" .. "/lua/custom/my-snippets"
vim.g.vscode_snippets_path = lpath
vim.g.snipmate_snippets_path = lpath

-- autocmd("VimEnter",{
--   pattern="*",
--   command="Nvdash",
-- })

-- autocmd("WinEnter", {
--    pattern = "*",
--    callback = function()
--       if vim.bo.buftype ~= "terminal" then
--          vim.opt.statusline = "%!v:lua.require'ui.statusline'.run()"
--       else
--          vim.opt.statusline = "%#normal# "
--       end
--    end,
-- })
