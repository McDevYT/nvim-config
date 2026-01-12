return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "emmet_ls",
                "spyglassmc_language_server",
                "terraformls"
            }
        })
    end
}

