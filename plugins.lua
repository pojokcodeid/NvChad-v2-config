local overrides = require "custom.configs.overrides"
-- initial active plugins optional
local active_debug = false
local active_visualmulti = false
local active_lspinstaller = false
local active_smartsplit = false
local active_liveserver = false
local active_dressing = false
local active_cmdline = false
local active_coderunner = true
local active_winbar = true
-- default variable
local debug = {}
local liveserver = {}
local visualmulti = {}
local coderunner = {}
local lspinstaller = {}
local smartsplit = {}
local dressing = {}
local winbar = {}
local cmdline = {}
-- activation
if active_cmdline then
  cmdline = {
    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      event = "BufWinEnter",
      opts = {
        messages = {
          enabled = false,
        },
        notify = {
          enabled = true,
        },
        lsp = {
          progress = {
            enabled = true,
          },
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
        },
      },
      keys = {
        {
          "<S-Enter>",
          function()
            require("noice").redirect(vim.fn.getcmdline())
          end,
          mode = "c",
          desc = "Redirect Cmdline",
        },
        {
          "<leader>snl",
          function()
            require("noice").cmd "last"
          end,
          desc = "Noice Last Message",
        },
        {
          "<leader>snh",
          function()
            require("noice").cmd "history"
          end,
          desc = "Noice History",
        },
        {
          "<leader>sna",
          function()
            require("noice").cmd "all"
          end,
          desc = "Noice All",
        },
        {
          "<c-f>",
          function()
            if not require("noice.lsp").scroll(4) then
              return "<c-f>"
            end
          end,
          silent = true,
          expr = true,
          desc = "Scroll forward",
          mode = { "i", "n", "s" },
        },
        {
          "<c-b>",
          function()
            if not require("noice.lsp").scroll(-4) then
              return "<c-b>"
            end
          end,
          silent = true,
          expr = true,
          desc = "Scroll backward",
          mode = { "i", "n", "s" },
        },
      },
    },
    {
      "hrsh7th/cmp-cmdline",
      event = "VeryLazy",
      config = function()
        local cmp = require "cmp"
        local mapping = {
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        }

        -- Use buffer source for `/`.
        cmp.setup.cmdline("/", {
          preselect = "none",
          completion = {
            completeopt = "menu,preview,menuone,noselect",
          },
          mapping = mapping,
          sources = {
            { name = "buffer" },
          },
          experimental = {
            ghost_text = true,
            native_menu = false,
          },
        })

        -- Use cmdline & path source for ':'.
        cmp.setup.cmdline(":", {
          preselect = "none",
          completion = {
            completeopt = "menu,preview,menuone,noselect",
          },
          mapping = mapping,
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
          experimental = {
            ghost_text = true,
            native_menu = false,
          },
        })
      end,
    },
  }
end
-- for winbar
if active_winbar then
  winbar = {
    {
      "SmiteshP/nvim-navic",
      dependencies = "neovim/nvim-lspconfig",
      event = "BufRead",
      config = function()
        require "custom.configs.breadcrumb"
        require "custom.configs.winbar"
      end,
    },
  }
end
-- for dressing
if active_dressing then
  dressing = {
    {
      "stevearc/dressing.nvim",
      lazy = true,
      init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
          require("lazy").load { plugins = { "dressing.nvim" } }
          return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load { plugins = { "dressing.nvim" } }
          return vim.ui.input(...)
        end
      end,
    },
  }
end
-- for smart split
if active_smartsplit then
  smartsplit = {
    {
      "mrjones2014/smart-splits.nvim",
      event = "VeryLazy",
      config = function()
        require "custom.configs.smartsplit"
      end,
    },
  }
end
-- for lspinstaller
if active_lspinstaller then
  lspinstaller = {
    { "williamboman/nvim-lsp-installer", event = "VeryLazy", lazy = true },
  }
end
-- for coderunner
if active_coderunner then
  coderunner = {
    {
      "CRAG666/code_runner.nvim",
      event = "BufRead",
      -- dependencies = "nvim-lua/plenary.nvim",
      cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
      config = function()
        require "custom.configs.coderunner"
      end,
    },
  }
end
-- for visualmulti
if active_visualmulti then
  visualmulti = {
    { "mg979/vim-visual-multi", event = "BufRead" },
  }
end
-- for liveserver
if active_liveserver then
  liveserver = {
    {
      "manzeloth/live-server",
      cmd = { "LiveServer" },
      event = "BufRead",
      build = "npm install -g live-server",
    },
  }
end
-- for debuging
if active_debug then
  debug = {
    {
      "rcarriga/nvim-dap-ui",
      event = "BufRead",
      dependencies = "mfussenegger/nvim-dap",
      enabled = vim.fn.has "win32" == 0,
      config = function()
        require "custom.configs.dapui"
      end,
    },
    {
      "jayp0521/mason-nvim-dap.nvim",
      event = "BufRead",
      dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
      enabled = vim.fn.has "win32" == 0,
      init = function()
        require "custom.configs.mason_dap"
      end,
    },
  }
end
---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
  -- custom by pojok code
  {
    "goolord/alpha-nvim",
    enabled = false,
    event = "BufWinEnter",
    config = function()
      require "custom.configs.alpha"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "BufRead",
    config = function()
      require "custom.configs.lualine"
    end,
  },
  { "hrsh7th/cmp-nvim-lsp", event = "BufRead" },
  { "hrsh7th/cmp-buffer", event = "BufRead" },
  { "hrsh7th/cmp-path", event = "BufRead" },
  { "saadparwaiz1/cmp_luasnip", event = "BufRead" },
  { "hrsh7th/cmp-nvim-lua", event = "BufRead" },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    opts = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "nvim_lua" },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s", require("custom.icons")["kind"][vim_item.kind])
            vim_item.menu = ({
              nvim_lsp = "(LSP)",
              luasnip = "(Snippet)",
              buffer = "(Buffer)",
              path = "(Path)",
            })[entry.source.name]
            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = true,
          native_menu = false,
        },
      }
    end,
  },
  -- for auto close tag
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- key mapping
  {
    "folke/which-key.nvim",
    event = "BufRead",
    config = function()
      dofile(vim.g.base46_cache .. "whichkey")
      require "custom.configs.whichkey"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require "custom.configs.lsp"
    end,
  },
  -- for formater linter
  {
    "jayp0521/mason-null-ls.nvim",
    lazy = true,
    dependencies = "jose-elias-alvarez/null-ls.nvim",
    event = "BufRead",
    opts = function()
      require "custom.configs.mason-null-ls"
    end,
  },
  -- for live server html,css,js
  liveserver,
  -- for multi cursor select
  visualmulti,
  -- for auto detection file and run code
  coderunner,
  -- override lsp
  -- for install lsp tidak support mason
  lspinstaller,
  -- for popup input
  dressing,
  -- for resize split (CTRL + arrow)
  smartsplit,
  -- for winbar icon
  winbar,
  -- for debuging
  debug,
  -- for cmd line popup
  cmdline,
}

return plugins
