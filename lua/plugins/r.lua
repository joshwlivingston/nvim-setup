return {
    "R-nvim/R.nvim",
    lazy = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "R-nvim/cmp-r",
    },
    config = function()
        require("r").setup({
            R_args = { "--quiet", "--no-save" },
            min_editor_width = 72,
            rconsole_width = 78,
        })
    end,
}
