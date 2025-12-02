local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

    {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"nvim-treesitter/playground"},
	{"theprimeagen/harpoon"},
	{"mbbill/undotree"},
	{"tpope/vim-fugitive"},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
        -- lazy
    {
        "sontungexpt/sttusline",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = { "BufEnter" }
    },
    {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp"
    },
    {'eandrju/cellular-automaton.nvim'},
    {'stevearc/oil.nvim'},
    {
        "jwalton512/vim-blade",
        ft = "blade"
    },
    {"RRethy/nvim-treesitter-endwise"},
    {"abecodes/tabout.nvim"},
    {
    'altermo/ultimate-autopair.nvim',
    event={'InsertEnter','CmdlineEnter'},
    branch='v0.6', --recommended as each new version will have breaking changes
    config=true
},
    {"kylechui/nvim-surround"},
    {"windwp/nvim-ts-autotag"},
    



})
