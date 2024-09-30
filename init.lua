local plugins_setup, _ = require("plugins_setup")

require("core.options")
require("core.keymaps")
require("core.colorscheme")

if plugins_setup then
require("plugins.bufferline")
require("plugins.lualine")
require("plugins.telescope")
require("plugins.mason")
require("plugins.nvim-dap")
require("plugins.lsp")
require("plugins.tree-sitter")
require("plugins.cmp")
require("plugins.luasnip")
require("plugins.tmux")
require("plugins.oil")
require("plugins.mini")
require("plugins.comment")
require("plugins.obsidian")
-- require("plugins.leetcode")
-- require("plugins.hardtime")
end
