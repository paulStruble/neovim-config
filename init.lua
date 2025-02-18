vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Lazy.nvim
require("config.lazy")

-- Mason.nvim
require("mason").setup()
require('mason-lspconfig').setup {
    ensure_installed = { 'pyright' },
}

-- onedark theme
require('onedark').setup {
    style = 'deep',
    term_colors = true,
    code_style = {
        comments = 'italic',
    }
}

-- nvim-web-devicons
require('nvim-web-devicons').setup {
    default = true
}

-- nvim-tree (filetree gui)
require('nvim-tree').setup {
    view = {
        adaptive_size = true,
        -- width = 35,
        side = "left",
        relativenumber = true,
    },
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
            },
        },
        highlight_git = true,
    },
    git = {
        enable = true,
        ignore = false,
    },
}

-- nvim-tree window toggle
local function toggle_nvim_tree()
    local view = require("nvim-tree.view")
    if view.is_visible() then
        vim.cmd("wincmd p") -- go to previous window
    else
        vim.cmd("NvimTreeFocus")
    end
end

-- lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = ''},
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_c = {'filename'},
        lualine_x = {'location'},
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                mode = 4,
                symbols = {
                    modified = ' ●',
                    alternate_file = '#',
                    directory = ''
                },
            }
        },
    },
    extensions = { 'nvim-tree' }
}

-- treesiter (syntax highlighting)
require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    highlight = { enable = true },
    indent = { enable = true },
}

-- cmp (automcompletion)
local cmp = require('cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
    },
}

-- lspconfig (neovim built-in LSP support)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- pyright (Python LSP)
lspconfig.pyright.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true }

        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    end,
}

-- VSCode-style snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- telescope (fuzzy search)
require("telescope").setup({
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> ",
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = { width = 0.8, height = 0.8 },
    },
    -- Enable `fd` as the file finder
    file_ignore_patterns = {"node_modules", ".git"},
    find_command = {"fd", "--type", "f", "--hidden", "--exclude", ".git"},
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- Enables fuzzy matching
      override_generic_sorter = true, -- Use fzf for sorting
      override_file_sorter = true,    -- Use fzf for file sorting
    },
  },
})

-- use fzf (fuzzy find) for telescope
require("telescope").load_extension("fzf")

require('nvim-ts-autotag').setup({
  opts = {
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
})

require('neoscroll').setup()

-- Function to show diagnostics in a floating window
vim.api.nvim_set_keymap(
  'n',
  '<leader>d',
  '<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>',
  { noremap = true, silent = true }
)

vim.keymap.set('n', '<leader>e', toggle_nvim_tree, { noremap = true, silent = true, desc = "Toggle NvimTree / Edit Window"})
vim.keymap.set('n', '<leader><leader>e', ':NvimTreeClose<CR>', { silent = true, desc = "Close NvimTree" })

-- Keybindings for Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Keybindings for buffer switching
vim.keymap.set('n', '<leader>]', ':bnext<CR>', { desc = 'Go to next buffer' } )
vim.keymap.set('n', '<leader>[', ':bprevious<CR>', { desc = 'Go to previous buffer' } )
vim.keymap.set('n', '<leader>\\', ':bdelete<CR>', { desc = 'Close current buffer' } )

vim.keymap.set('n', '<leader>0', ':noh<CR>', { desc = 'Hide active highlights'} )

vim.keymap.set('n', '<leader>a', '<C-a>', { noremap = true, silent = true } )
vim.keymap.set('n', '<leader>x', '<C-x>', { noremap = true, silent = true } )

vim.o.termguicolors = true
-- vim.cmd[[colorscheme onedark]]
vim.cmd[[colorscheme gruvbox-material]]

vim.o.relativenumber = true
vim.o.number = true

vim.cmd[[syntax enable]]

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.laststatus = 2
vim.o.ruler = true
vim.o.showcmd = true

vim.cmd[[filetype plugin indent on]]

vim.o.tabstop = 2
vim.o.softtabstop = -1
vim.o.shiftwidth = 0
vim.o.expandtab = true

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.clipboard = "unnamedplus"

vim.o.wrap = false

vim.o.mouse = ''
