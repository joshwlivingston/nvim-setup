-- plugins/lsp.lua

local function set_python_path(path)
    local clients = vim.lsp.get_clients {
        bufnr = vim.api.nvim_get_current_buf(),
        name = 'pyright',
    }
    for _, client in ipairs(clients) do
        if client.settings then
            client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
        else
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings,
                { python = { pythonPath = path } })
        end
        client:notify('workspace/didChangeConfiguration', { settings = nil })
    end
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local on_attach_with_format = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end

        -- kotlin
        lspconfig.kotlin_language_server.setup({
            on_attach = on_attach_with_format,
        })

        -- lua
        lspconfig.lua_ls.setup({
            on_attach = on_attach_with_format,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        -- python
        lspconfig.pyright.setup({
            on_attach = function(client, bufnr)
                -- include auto-formatting, consistent with my other LSP's
                on_attach_with_format(client, bufnr)

                -- include default pyright attach behavior
                vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
                    client:exec_cmd({
                        command = 'pyright.organizeimports',
                        arguments = { vim.uri_from_bufnr(bufnr) },
                    })
                end, {
                    desc = 'Organize Imports',
                })
                vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
                    desc = 'Reconfigure pyright with the provided python path',
                    nargs = 1,
                    complete = 'file',
                })
            end
        })

        -- R
        lspconfig.r_language_server.setup({
            cmd = { "R", "--slave", "-e", "languageserver::run()" },
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false

                vim.api.nvim_create_autocmd("BufWritePost", {
                    buffer = bufnr,
                    callback = function() vim.diagnostic.show() end,
                })
                vim.diagnostic.config({
                    virtual_text = true,
                    signs = true,
                    update_in_insert = false,
                    severity_sort = true,
                    float = {
                        focusable = false,
                        style = "minimal",
                        border = "rounded",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                })
            end,
        })
        lspconfig.air.setup({
            on_attach = on_attach_with_format,
        })

        -- Global on_attach for common keymaps/autocmds for all LSPs
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(args)
                local bufnr = args.buf
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP Declaration" })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Definition" })

                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
                    { desc = 'Go to previous diagnostic', buffer = bufnr })
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic', buffer = bufnr })
                vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
                    { desc = 'Open floating diagnostic', buffer = bufnr })
                vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
                    { desc = 'Open diagnostics list', buffer = bufnr })
            end,
        })
    end,
}
