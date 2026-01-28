local root_files = {
  ".luarc.json",
  ".luarc.jsonc",
  ".luacheckrc",
  ".stylua.toml",
  "stylua.toml",
  "selene.toml",
  "selene.yml",
  ".git",
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    "mfussenegger/nvim-jdtls",
    "mfussenegger/nvim-dap",
  },
  opts = {
    ---@class PluginLspOpts
    servers = {
      -- configuration for all lsp servers
      ["*"] = {
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- stylua: ignore
        keys = {
          -- { "gd",         vim.lsp.buf.definition,                             desc = "Goto Definition",            has = "definition" },
          -- { "gr",         vim.lsp.buf.references,                             desc = "References",                 nowait = true },
          { "gI",         vim.lsp.buf.implementation,                         desc = "Goto Implementation" },
          { "gy",         vim.lsp.buf.type_definition,                        desc = "Goto T[y]pe Definition" },
          { "gD",         vim.lsp.buf.declaration,                            desc = "Goto Declaration" },
          { "K",          function() return vim.lsp.buf.hover() end,          desc = "Hover" },
          { "gK",         function() return vim.lsp.buf.signature_help() end, desc = "Signature Help",             has = "signatureHelp" },
          { "<c-k>",      function() return vim.lsp.buf.signature_help() end, mode = "i",                          desc = "Signature Help", has = "signatureHelp" },
          { "<leader>ca", vim.lsp.buf.code_action,                            desc = "Code Action",                mode = { "n", "x" },     has = "codeAction" },
          { "<leader>cc", vim.lsp.codelens.run,                               desc = "Run Codelens",               mode = { "n", "x" },     has = "codeLens" },
          { "<leader>cC", vim.lsp.codelens.refresh,                           desc = "Refresh & Display Codelens", mode = { "n" },          has = "codeLens" },
          { "<leader>cr", vim.lsp.buf.rename,                                 desc = "Rename",                     has = "rename" },
        },
      },
    }
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        java = { "google-java-format" },
      },
      formatters = {
        ["google-java-format"] = {
          args = { "--skip-sorting-imports", "-" },
        },
      },
      log_level = vim.log.levels.DEBUG,
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )
    local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    -- Setup Testing and Debugging
    local bundles = {}
    local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
    vim.list_extend(
      bundles,
      vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n")
    )
    vim.list_extend(
      bundles,
      vim.split(
        vim.fn.glob(
          mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
        ),
        "\n"
      )
    )

    vim.lsp.config("jdtls", {
      cmd = {
        "/Users/mikeroberts/.local/share/nvim/mason/packages/jdtls/bin/jdtls",
        "--jvm-arg=-javaagent:/Users/mikeroberts/.local/share/nvim/mason/packages/jdtls/lombok.jar",
      },
      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
      capabilities = capabilities,
      settings = {
        java = {
          autobuild = { enabled = false },
          implementationsCodeLens = {
            enabled = true,
          },
          maven = {
            downloadSources = true,
          },
          eclipse = {
            downloadSources = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          inlayHints = {
            parameterNames = {
              enabled = "all",
            },
          },
          format = {
            enabled = true,
            settings = {
              url = "/Users/mikeroberts/.config/nvim/google-format.xml",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          completion = {
            -- When using an unimported static method, how should the LSP rank possible places to import the static method from
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            -- Try not to suggest imports from these packages in the code action window
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
            -- Set the order in which the language server should organize imports
            importOrder = {
              "java",
              "javax",
              "org",
              "com",
            },
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = "/Users/mikeroberts/.sdkman/candidates/java/21.0.6-zulu/",
                default = true,
              },
            },
          },
        },
        signatureHelp = {
          enabled = true,
        },
        extendedClientCapabilities = extendedClientCapabilities,
      },
      init_options = {
        bundles = bundles,
      },
    })
    vim.lsp.enable("jdtls")

    vim.lsp.config("lua_ls", {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
              path ~= vim.fn.stdpath("config")
              and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths
              -- here.
              -- '${3rd}/luv/library'
              -- '${3rd}/busted/library'
            },
            -- Or pull in all of 'runtimepath'.
            -- NOTE: this is a lot slower and will cause issues when working on
            -- your own configuration.
            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = {
            --   vim.api.nvim_get_runtime_file('', true),
            -- }
          },
        })
      end,
      settings = {
        Lua = {},
      },
    })

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        -- "gopls",
        "tailwindcss",
        "ts_ls"
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                format = {
                  enable = true,
                  -- Put format options here
                  -- NOTE: the value should be STRING!!
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                  },
                },
              },
            },
          })
        end,
        ["tailwindcss"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            filetypes = {
              "html",
              "css",
              "scss",
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "svelte",
              "heex",
            },
          })
        end,
      },
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
      }, {
        { name = "buffer" },
      }),
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      virtual_lines = true,
      underline = false,
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
}
