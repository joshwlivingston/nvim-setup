-- ~/nvim/lua/plugins/multiple-cursors.lua

return {
  "brenton-leighton/multiple-cursors.nvim",
  event = "VeryLazy", -- Load late to not slow down startup
  config = function()
    require("multiple-cursors").setup({
      -- Customize keymaps here
      keys = {
        -- Keep Alt-n for "Add all matches" (less likely to conflict with core Vim/Neovim)
        ["<A-n>"] = "MultipleCursorsAddAllMatches",

        -- Keep Alt-LeftMouse for individual cursor placement (common in modern editors)
        ["<M-LeftMouse>"] = "MultipleCursorsMouseAddDelete",

        -- Use leader-prefixed keymaps for actions that commonly use <C-...>
        -- to avoid conflicts with window navigation or other personal mappings.
        ["<leader>mn"] = "MultipleCursorsAddNextMatch",   -- Add cursor to next match
        ["<leader>mp"] = "MultipleCursorsAddPrevMatch",   -- Add cursor to previous match
        ["<leader>mj"] = "MultipleCursorsAddDown",        -- Add cursor down
        ["<leader>mk"] = "MultipleCursorsAddUp",          -- Add cursor up

        -- <C-v> is default Visual Block mode, so moving "AddVisualArea" to leader is safer.
        ["<leader>mv"] = "MultipleCursorsAddVisualArea",  -- Add cursors to visual area
      },
      -- If you want to strictly control all keymaps and disable *all* plugin defaults,
      -- uncomment the line below. Otherwise, the plugin's other safe defaults might remain.
      -- disable_default_keymaps = true,

      -- You can also configure other aspects if needed, e.g.:
      -- show_hints = true,
      -- ignore_leading_whitespace = true,
    })
  end,
}
