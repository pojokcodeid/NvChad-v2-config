local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("custom.configs.lsp.mason")
require("custom.configs.lsp.config") -- ini hanya untuk windows supaya jdtls jalan, kalau pakai linu x remark saja
require("custom.configs.lsp.handlers").setup()
require("custom.configs.lsp.null-ls")
