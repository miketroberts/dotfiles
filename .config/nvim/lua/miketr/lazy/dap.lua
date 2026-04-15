return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      -- "mxsdev/nvim-dap-vscode-js",
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local telescope = require("telescope")

      local function get_pkg_path(pkg, path)
        pcall(require, 'mason')
        local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
        path = path or ''
        local ret = root .. '/packages/' .. pkg .. '/' .. path
        return ret
      end

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = 'node',
          args = {
            get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
            '${port}',
            '127.0.0.1',
          },
        },
      }

      -- require("dap-vscode-js").setup({
      --   -- Path to the binary installed by Mason
      --   debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      --
      --   -- The command to run the debug server
      --   debugger_cmd = { "js-debug-adapter" },
      --   adapters = { "pwa-node", "node-terminal", "pwa-chrome" },
      -- })

      dapui.setup()
      require("nvim-dap-virtual-text").setup()
      telescope.load_extension("dap")

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      ------------------------------------------------------------------
      -- 🔥 JavaScript / TypeScript config
      ------------------------------------------------------------------
      for _, language in ipairs({ "javascript", "typescript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach web (9229)",
            address = "127.0.0.1",
            port = 9229,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            remoteRoot = "/obsidian",
            localRoot = "${workspaceFolder}",
            skipFiles = {
              "${workspaceFolder}/node_modules/**/*.js",
              "<node_internals>/**/*.js"
            },
            outFiles = {
              "/workspaces/obsidian/apps/*/dist/**/*.js",
              "/workspaces/obsidian/packages/*/dist/**/*.js"
            }
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach test-runner-live (4279)",
            address = "127.0.0.1",
            port = 4079,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            remoteRoot = "/obsidian",
            localRoot = "${workspaceFolder}",
            skipFiles = {
              "${workspaceFolder}/node_modules/**/*.js",
              "<node_internals>/**/*.js"
            },
            outFiles = {
              "/workspaces/obsidian/apps/*/dist/**/*.js",
              "/workspaces/obsidian/packages/*/dist/**/*.js"
            }
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach test-runner (4083)",
            address = "127.0.0.1",
            port = 4083,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            remoteRoot = "/obsidian",
            localRoot = "${workspaceFolder}",
            skipFiles = {
              "${workspaceFolder}/node_modules/**/*.js",
              "<node_internals>/**/*.js"
            },
            outFiles = {
              "/workspaces/obsidian/apps/*/dist/**/*.js",
              "/workspaces/obsidian/packages/*/dist/**/*.js"
            }
          },
        }
      end

      vim.fn.sign_define("DapBreakpoint", { text = "●" })

      -- Keymaps
      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<F10>", dap.step_over)
      vim.keymap.set("n", "<F11>", dap.step_into)
      vim.keymap.set("n", "<F12>", dap.step_out)
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end)

      -- Keymaps (these are the good ones)
      local dap_telescope = require("telescope").extensions.dap

      vim.keymap.set("n", "<leader>dc", dap_telescope.commands)
      vim.keymap.set("n", "<leader>db", dap_telescope.list_breakpoints)
      vim.keymap.set("n", "<leader>dv", dap_telescope.variables)
      vim.keymap.set("n", "<leader>df", dap_telescope.frames)
      vim.keymap.set("n", "<leader>dd", dap_telescope.configurations)
    end,
  },
}
