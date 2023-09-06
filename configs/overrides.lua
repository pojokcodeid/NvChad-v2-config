local M = {}
local icons = require "custom.icons"

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
  },
}

-- git support in nvimtree
M.nvimtree = {
  -- git = {
  --   enable = true,
  -- },
  git = {
    enable = false, -- false dulu karena muncul error
    ignore = true, -- true dulu karena muncul error
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 200,
  },

  -- renderer = {
  --   highlight_git = true,
  --   icons = {
  --     show = {
  --       git = true,
  --     },
  --   },
  -- },
  renderer = {
    root_folder_modifier = ":t",
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
        default = icons.ui.Text,
        symlink = icons.ui.FileSymlink,
        folder = {
          arrow_open = icons.ui.ChevronShortDown,
          arrow_closed = icons.ui.ChevronShortRight,
          default = icons.ui.Folder,
          empty = icons.ui.EmptyFolder,
          empty_open = icons.ui.EmptyFolderOpen,
          open = icons.ui.FolderOpen,
          symlink = icons.ui.FolderSymlink,
          symlink_open = icons.ui.FolderSymlink,
        },
        git = {
          deleted = icons.git.FileDeleted,
          ignored = icons.git.FileIgnored,
          renamed = icons.git.FileRenamed,
          staged = icons.git.FileStaged,
          unmerged = icons.git.FileUnmerged,
          unstaged = icons.git.FileUnstaged,
          untracked = icons.git.FileUntracked,
        },
      },
    },
  },
}

return M
