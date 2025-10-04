-- File: lua/plugins/jdtls.lua

return {
  "mfussenegger/nvim-jdtls",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
  },
  ft = { "java" },
  config = function()
    -- Determine the OS for the jdtls configuration path
    local jdtls_config_path
    if vim.fn.has "mac" == 1 then
      jdtls_config_path = "config_mac"
    else
      jdtls_config_path = "config_linux"
    end

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration", vim.fn.stdpath "data" .. "/mason/packages/jdtls/" .. jdtls_config_path,
        "-data", vim.fn.stdpath "data" .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
      },
      root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew" },
    }
    require("jdtls").start_or_attach(config)
  end,
}
