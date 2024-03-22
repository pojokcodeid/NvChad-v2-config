return {
  {
    "folke/which-key.nvim",
    config = function()
      function _LAZYGIT_TOGGLE()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
        lazygit:toggle()
      end

      -- add yours here

      -- function for close all bufferline
      function _CLOSE_ALL_BUFFER()
        -- local buf_active = vim.api.nvim_get_current_buf()
        -- for _, buf in ipairs(vim.t.bufs) do
        --   if buf ~= buf_active then
        --     require("bufdelete").bufdelete(buf, true)
        --   end
        -- end
        require("nvchad.tabufline").closeOtherBufs()
      end

      function _CLOSE_BUF_LEFT()
        -- local current = vim.api.nvim_get_current_buf()
        -- for _, bufnr in ipairs(vim.t.bufs) do
        --   if bufnr == current then
        --     break
        --   end
        --   require("bufdelete").bufdelete(bufnr, true)
        -- end
        require("nvchad.tabufline").closeBufs_at_direction "left"
      end

      function _CLOSE_BUF_RIGHT()
        -- local current = vim.api.nvim_get_current_buf()
        -- local after_current = false
        -- for _, bufnr in ipairs(vim.t.bufs) do
        --   if after_current then
        --     require("bufdelete").bufdelete(bufnr, true)
        --   end
        --   if bufnr == current then
        --     after_current = true
        --   end
        -- end
        require("nvchad.tabufline").closeBufs_at_direction "right"
      end

      dofile(vim.g.base46_cache .. "whichkey")
      local status_ok, which_key = pcall(require, "which-key")
      if not status_ok then
        return
      end

      local opts = {
        mode = "n",     -- NORMAL mode
        prefix = "<leader>",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,  -- use `nowait` when creating keymaps
      }

      local setup = {
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "  ", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },

        popup_mappings = {
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>",   -- binding to scroll up inside the popup
        },

        window = {
          border = "rounded",       -- none, single, double, shadow
          -- border = "none", -- none, single, double, shadow
          position = "bottom",      -- bottom, top
          margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3,                    -- spacing between columns
          align = "left",                 -- align columns left, center or right
        },
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          i = { "j", "k" },
          v = { "j", "k" },
        },
      }
      which_key.setup(setup)
      local mappings = {
        b = {
          name = "Buffers",
          b = { "<cmd>enew<CR>", "Buffer New" },
          c = { "<cmd>lua  require('nvchad.tabufline').close_buffer()<cr>", "Close current buffer" },
          d = { "<cmd>lua _CLOSE_ALL_BUFFER()<cr>", "Close All Buffers" },
          k = { "<cmd>lua _CLOSE_BUF_LEFT()<cr>", "Delete Buffer Left" },
          K = { "<cmd>lua _CLOSE_BUF_RIGHT()<cr>", "Delete Buffer Right" },
        },
      }
      which_key.register(mappings, opts)
    end,
  },
}
