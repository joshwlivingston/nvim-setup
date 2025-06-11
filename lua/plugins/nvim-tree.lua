-- plugins/nvim-tree.lua
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({})

        -- Keymaps
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {
            desc = "Toggle file explorer"
        })
    end,
}
