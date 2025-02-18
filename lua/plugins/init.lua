return {
    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    { 'navarasu/onedark.nvim', priority = 1000 },
    { 'sainnhe/gruvbox-material', priority = 1000 },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }, 

    { 'williamboman/mason.nvim' },

    { 'williamboman/mason-lspconfig.nvim' },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
    },

    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
    },

    {
        'hrsh7th/cmp-nvim-lsp',
    },

    {
        'hrsh7th/nvim-cmp',
        dependendencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',  -- This will compile the extension
    },

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
    },

    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false,
    },

    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },

    {
        'tpope/vim-surround'
    },

    {
        'sindrets/diffview.nvim'
    },

    {
        'windwp/nvim-ts-autotag'
    },

    {
        "lervag/vimtex",
        lazy = false, -- Load immediately
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_compiler_method = "latexmk"
        end
    },

    {
      "karb94/neoscroll.nvim",
    },
}
