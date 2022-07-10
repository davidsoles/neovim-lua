return require('packer').startup(function(use)
    -- Dependencies
    use 'nvim-lua/plenary.nvim'
    
    -- Colorscheme
    use 'matsuuu/pinkmare'
    use 'lunarvim/onedarker.nvim'
    use 'gruvbox-community/gruvbox'
    use 'Mofiqul/vscode.nvim'
    
    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'
    
    -- Packer
    use 'wbthomason/packer.nvim'
    
    -- Telescope
    use 'nvim-telescope/telescope.nvim' 

    -- File Explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Checkstyle
    use 'vim-syntastic/syntastic'

    -- Neovim LSP
    use 'neovim/nvim-lspconfig'

    -- Debug Adapter Protocol (DAP)
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- Java
    use 'mfussenegger/nvim-jdtls'

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'

    -- Snippets
    use 'L3MON4D3/LuaSnip'
end)
