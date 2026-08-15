-- ~/nvim/lua/plugins/mason.lua
return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            -- Explicitly hand off clangd to Neovim's LSP client
            vim.lsp.config("clangd", {})
            vim.lsp.enable("clangd")
        end,
    }
}
