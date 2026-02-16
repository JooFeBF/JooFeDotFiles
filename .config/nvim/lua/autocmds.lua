
-- ESLint fix on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.js", "*.ts", "*.jsx", "*.tsx"},
  callback = function()
    if vim.fn.exists(":EslintFixAll") > 0 then
      vim.cmd("EslintFixAll")
    end
  end,
})

-- Fix render-markdown checkbox highlight
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "RenderMarkdownChecked", { fg = "#a6e3a1", bg = "NONE" })
  end,
})

