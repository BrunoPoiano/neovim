return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
       -- null_ls.builtins.diagnostics.stylua,
       --: null_ls.builtins.completion.stylua,

        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,

        --require("none-ls.formatting.biome"),
        --require("none-ls.diagnostics.biome"),
        --require("none-ls.completion.biome"),
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}