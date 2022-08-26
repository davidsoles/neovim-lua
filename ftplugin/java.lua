local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local config = {
    cmd = {
        os.getenv('HOME') .. '/.sdkman/candidates/java/17.0.4-tem/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', os.getenv('HOME') .. '/.config/nvim/java/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', os.getenv('HOME') .. '/.config/nvim/java/config_linux',
        '-data', os.getenv('HOME') .. '/.cache/jdtls-workspace/' .. workspace_dir
    },
    root_dir = require('jdtls.setup').find_root({'.git'}),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            saveActions = {
                organizeImports = true,
            },
            format = {
                enabled = true,
                settings = {
                    url = 'https://gist.githubusercontent.com/DavidSoles/d3c3343330a8dc7f6177464351aa9acb/raw/d6603c1ae516a88b0cf93b34c798a1d6385a26fb/EclipseCustomProfile.xml'
                }
            },
            completion = {
                importOrder = {
                    'java', 'javax', 'org', 'com', '', '#'
                }
            },
            configuration = {
                runtimes = {
                    {
                        name = 'JavaSE-1.8',
                        path = os.getenv('HOME') .. '/.sdkman/candidates/java/8.0.345-tem'
                    },
                    {
                        name = 'JavaSE-11',
                        path = os.getenv('HOME') .. '/.sdkman/candidates/java/11.0.16-tem',
                        default = true
                    },
                    {
                        name = 'JavaSE-17',
                        path = os.getenv('HOME') .. '/.sdkman/candidates/java/17.0.4-tem'
                    }
                }
            }
        }
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {
            vim.fn.glob(os.getenv('HOME') .. "/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
        },
        extendedClientCapabilities = require('jdtls').extendedClientCapabilities
    },
    capabilities = capabilities,
    on_attach = require('jdtls').setup_dap({ hotcodereplace = 'auto' }),
    add_commands = require('jdtls.setup').add_commands()
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
vim.api.nvim_set_keymap('n', 'crv', "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
vim.api.nvim_set_keymap('v', 'crv', "<esc><cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
vim.api.nvim_set_keymap('n', 'crc', "<cmd>lua require('jdtls').extract_constant()<CR>", opts)
vim.api.nvim_set_keymap('v', 'crc', "<esc><cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
vim.api.nvim_set_keymap('v', 'crm', "<esc><cmd>lua require('jdtls').extract_method(true)<CR>", opts)

-- Debugger
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F6>", "<cmd>lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F7>", "<cmd>lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F8>", "<cmd>lua require'dap'.continue()<CR>", opts)

