local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = true,
	sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.completion.luasnip,
    diagnostics.credo,
    diagnostics.cspell,
    diagnostics.erb_lint,
    diagnostics.eslint,
    diagnostics.hadolint, -- Docker
    diagnostics.jsonlint,
    diagnostics.luacheck,
    diagnostics.revive, -- Go
    diagnostics.rubocop,
    diagnostics.staticcheck, -- Go
    diagnostics.tidy, -- HTML, XML
    diagnostics.tsc,
    diagnostics.tsc,
    formatting.clang_format,
    formatting.cmake_format,
    formatting.erb_lint,
    formatting.erlfmt,
    formatting.eslint,
    formatting.gofmt,
    formatting.goimports,
    formatting.json_tool,
    -- formatting.rubocop,
    formatting.rustfmt,
    formatting.tidy,
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
  },

  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
            augroup LspFormatting
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
    end
  end,
})
