-- Keep signcolumn visible to avoid layout shift
vim.opt.signcolumn = 'yes'

-- ==============================
-- LSP default capabilities (with nvim-cmp)
-- ==============================
local default_capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

-- ==============================
-- Keymaps only when LSP attaches
-- ==============================
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP keybindings',
  callback = function(event)
    local opts = { buffer = event.buf }
    local map = vim.keymap.set
    map('n', 'K',         vim.lsp.buf.hover, opts)
    map('n', 'gd',        vim.lsp.buf.definition, opts)
    map('n', 'gD',        vim.lsp.buf.declaration, opts)
    map('n', 'gi',        vim.lsp.buf.implementation, opts)
    map('n', 'go',        vim.lsp.buf.type_definition, opts)
    map('n', 'gr',        vim.lsp.buf.references, opts)
    map('n', 'gs',        vim.lsp.buf.signature_help, opts)
    map('n', '<F2>',      vim.lsp.buf.rename, opts)
    map({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
    map('n', '<F4>',      vim.lsp.buf.code_action, opts)
  end,
})

-- ==============================
-- Mason setup
-- ==============================
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { "lua_ls" },
})

-- ==============================
-- LSP server configuration (new API)
-- ==============================
vim.lsp.config["lua_ls"] = {
  cmd = { "lua-language-server" },
  capabilities = default_capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

-- Start the LSP server automatically when applicable
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.lsp.start(vim.lsp.config["lua_ls"])
  end,
})

-- ==============================
-- nvim-cmp setup
-- ==============================
local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
    ['<CR>']  = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})

