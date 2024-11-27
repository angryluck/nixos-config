require('nvim-treesitter.configs').setup({
  auto_install = false,
  -- highlight {
  --   enable = true,
  highlight = { enable = true, disable = { "latex" }, },
  -- },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- Defaults
      -- init_selection = "gnn",
      -- node_incremental = "grn",
      -- scope_incremental = "grc",
      -- node_decremental = "grm",

      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<m-space>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      -- automatically jump forward to textobj, see targets.vim
      lookahead = true,
      keymaps = {
        -- you can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "[a]round [f]unction" },
        ["if"] = { query = "@function.inner", desc = "[i]nner [f]unction" },
        -- [a/i]p is taken for "paragraph".
        ["aa"] = {
          query = "@parameter.outer",
          desc = "[a]round [a]rgument",
        },
        ["ia"] = { query = "@parameter.inner", desc = "[i]nner [a]rgument" },
        -- fucks up vimtex commands!
        -- ['ac'] = '@class.outer',
        -- ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader><"] = "@parameter.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = "none",
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
  refactor = {
    highlight_definitions = {
      -- enable = true,
      enable = false,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    -- highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
      keymaps = {
        smart_rename = "<leader>rn",
      },
    },
  },
})

-- Tmp solution, while setting "highlight = {enable = true}" above doesn't work
vim.api.nvim_create_autocmd("VimEnter", {
  command = ":TSEnable highlight"
})
