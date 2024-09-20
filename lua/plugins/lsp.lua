return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({ capabilities = capabilities, })
      lspconfig.biome.setup({ capabilities = capabilities, })
      lspconfig.jsonls.setup({ capabilities = capabilities, })
      lspconfig.eslint.setup({ capabilities = capabilities, })
      lspconfig.html.setup({ capabilities = capabilities, })
      lspconfig.lwc_ls.setup({ capabilities = capabilities, })
      lspconfig.ast_grep.setup({ capabilities = capabilities, })
      lspconfig.cssls.setup({ capabilities = capabilities, })
      lspconfig.css_variables.setup({ capabilities = capabilities })
      lspconfig.cssmodules_ls.setup({ capabilities = capabilities })
      lspconfig.tailwindcss.setup({ capabilities = capabilities })
      lspconfig.unocss.setup({ capabilities = capabilities })
      lspconfig.intelephense.setup({ capabilities = capabilities })
      lspconfig.psalm.setup({ capabilities = capabilities })
      lspconfig.emmet_language_server.setup({ capabilities = capabilities })
      lspconfig.rnix.setup({ capabilities = capabilities })
      lspconfig.volar.setup({ capabilities = capabilities })

      -- golang
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          -- You can customize any specific settings for gopls here
          vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              underline = true,
              virtual_text = false,
              update_in_insert = true,
            }
          )
        end,
      })

      --Typescript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          -- Disable formatting to avoid conflicts with prettier or eslint
          vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              underline = true,
              virtual_text = false,
              update_in_insert = true,
            }
          )
        end,
      })

      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, {})
      vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, {})
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, {})
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, {})
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
      vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
      end, {})
    end,
  },
}
