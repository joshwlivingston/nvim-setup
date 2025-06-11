-- plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")

		local on_attach_with_format = function(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function ()
					vim.lsp.buf.format()
				end,
			})

        		
		end
    -- R Language Server Setup (existing)
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
            virtual_text = true, signs = true, update_in_insert = false,
            severity_sort = true,
            float = {
                focusable = false, style = "minimal", border = "rounded",
                source = "always", header = "", prefix = "",
            },
        })

      end,
    })
		lspconfig.air.setup({
			on_attach = on_attach_with_format,
		})

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
		lspconfig.kotlin_language_server.setup({
			on_attach = on_attach_with_format,
		})

    -- Global on_attach for common keymaps/autocmds for all LSPs
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(args)
        local bufnr = args.buf
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP Declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Definition" })

        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic', buffer = bufnr })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic', buffer = bufnr })
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic', buffer = bufnr })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list', buffer = bufnr })
      end,
    })
  end,
}
