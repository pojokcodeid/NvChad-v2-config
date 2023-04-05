local overrides = require("custom.configs.overrides")

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
    opts = overrides.mason
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
     event="BufWinEnter",
     config=function ()
      require "custom.configs.alpha"
     end
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
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
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
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "nvim_lua" },
				}),
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
  -- for live server html,css,js
	{
		"manzeloth/live-server",
		cmd = { "LiveServer" },
		event = "BufRead",
		build = "npm install -g live-server",
	},
  -- for multi cursor select
	{ "mg979/vim-visual-multi", event = "BufRead" },
  -- for auto close tag
	{
		"windwp/nvim-ts-autotag",
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
  -- for auto detection file and run code
	{
		"CRAG666/code_runner.nvim",
		event = "BufRead",
		-- dependencies = "nvim-lua/plenary.nvim",
		cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
		config = function()
			require("custom.configs.coderunner")
		end,
	},
  -- key mapping
	{
		"folke/which-key.nvim",
		event = "BufRead",
		config = function()
      dofile(vim.g.base46_cache .. "whichkey")
			require("custom.configs.whichkey")
		end,
	},
}

return plugins
