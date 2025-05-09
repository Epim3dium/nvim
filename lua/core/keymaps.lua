vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<leader>src", function() vim.cmd("luafile %") end, { desc = "sourcing neovim setup" })

-- keymap.set("t", "<ESC>", "<C-\\><C-n>")
-- keymap.set("t", "<C-]>", "<C-\\><C-n>:bnext<CR>")
-- keymap.set("t", "<C-[>", "<C-\\><C-n>:bprev<CR>")

keymap.set("n", "<leader>nh", function() vim.cmd("nohl") end, { desc = "hide active highlights" })

keymap.set({ "v", "o", "n" }, "x", '"_x', { desc = "x no longer adds to registers" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "add one to numeric value" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "sub one to numeric value" })

-- keymap.set({ "v", "o", "n" }, "<leader>c", '"*', { desc = "access clipboard register" })
keymap.set({ "v", "n" }, "<leader>y", '"+y', { desc = "yank to clipboard" })
keymap.set({ "v", "n" }, "<leader>p", '"+p', { desc = "paste from clipboard" })
--premage keymaps for 2 registers
keymap.set("v", "<leader>z", '"zy', { desc = "yank into z register" })
keymap.set("v", "<leader>Z", '"Zy', { desc = "yank into Z register" })
keymap.set("n", "<leader>z", '"zp', { desc = "paste from z register" })
keymap.set("v", "<leader>x", '"xy', { desc = "yank into x register" })
keymap.set("v", "<leader>X", '"Xy', { desc = "yank into X register" })
keymap.set("n", "<leader>x", '"xp', { desc = "paste from x register" })

-- keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })
-- keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" })
-- keymap.set("n", "<leader>se", "<C-w>=", { desc = "make split windows equal width & height" })
-- keymap.set("n", "<leader>sx", "<C-w>c", { desc = "close current split window" })
-- keymap.set("n", "<leader>so", "<C-w>o", { desc = "close current split window" })
-- keymap.set("n", "<leader>s_", "<C-w>_", { desc = "max the height of split" })
-- keymap.set("n", "<leader>s|", "<C-w>|", { desc = "max the width of split" })

-- Navigate buffers
keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "switch to next buffer" })
keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "switch to prev buffer" })
--delete buffers
keymap.set("n", "_", function() vim.cmd("bp|bd #") end, { desc = "delete buffer and switch to prev" })
keymap.set("n", "<C-_>", function() vim.cmd("bp|bd! #") end, { desc = "delete buffer and switch to prev" })

-- Stay in indent mode
keymap.set("v", "<", "<gv", { desc = "shift text left" })
keymap.set("v", ">", ">gv", { desc = "shift text right" })

--move lines
keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "move line down" })
keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line up" })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move line down" })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move line up" })

keymap.set("n", "<leader>o", "o<Esc>k", {desc = "insert line below without exiting normal mode"});

--=====================
--nvim lsp
--=====================
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap.set('n', '<leader>e',  vim.diagnostic.open_float, { desc = "opens diagnostic floating window" } )
keymap.set('n', '<leader>od', vim.diagnostic.open_float, { desc = "opens diagnostic floating window" })
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "goes to prev diagnostic" })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "goest to next diagnostic" })
keymap.set('n', '<leader>ld', vim.diagnostic.setqflist, { desc = "lists diagnosic locations" })
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current bufferf
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        --vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        --fix cmp for commands
        keymap.set('c', '<tab>', '<C-z>', { silent = false }) -- to fix cmp

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "goto declaration" })
        keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "goto definition" })
        keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "hover" })
        keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "implementation" })
        -- keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "signature_help" })
        keymap.set('n', '<leader>fa', vim.lsp.buf.add_workspace_folder,
            { buffer = ev.buf, desc = "add_workspace_folder" })
        keymap.set('n', '<leader>fr', vim.lsp.buf.remove_workspace_folder,
            { buffer = ev.buf, desc = "remove_workspace_folder" })
        keymap.set('n', '<leader>fl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = ev.buf, desc = "lists workspace folders" })
        keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "goto type definition" })
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
        keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
        keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "goto references" })
        keymap.set('n', '<leader>fo', function()
            vim.lsp.buf.format { async = true }
        end, { buffer = ev.buf, desc = "format current buffer" })
        local range_formatting = function()
            local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
            local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
            vim.lsp.buf.format({
                range = {
                    ["start"] = { start_row, 0 },
                    ["end"] = { end_row, 0 },
                },
                async = true,
            })
        end

        keymap.set("v", "<leader>fo", range_formatting, { buffer = ev.buf, desc = "format selected range" })
    end,
})
--==========
--nvim dap
--==========
--alt as the 'debug key'
local dapsetup, dap = pcall(require, 'dap')
local dapuisetup, dapui = pcall(require, 'dapui')

if dapsetup then
    keymap.set('n', '<A-c>', function() dap.run_to_cursor() end)
    keymap.set('n', '<A-CR>', function() dap.continue() end)
    keymap.set('n', '<A-down>', function() dap.step_over() end)
    keymap.set('n', '<A-right>', function() dap.step_into() end)
    keymap.set('n', '<A-left>', function() dap.step_out() end)

    keymap.set('n', '<A-t>', function() dap.terminate() end)
    keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = "sets a breakpoint" })
    keymap.set('n', '<leader>B', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        { desc = "sets a logging breakpint" })
    keymap.set('n', '<A-e>', function() dapui.eval() end)
    keymap.set('n', '<leader>du', function() dapui.toggle() end, { desc = "toggle dapui gui" })
end
--either show diagnostic message or eval expression if debug session is active
--==========
--Telescope
--==========
local telescopesetup, telescope = pcall(require, 'telescope')
if telescopesetup then
    keymap.set("n", "<leader>u",  function() telescope.extensions.undo.undo({ side_by_side = true }) end) -- list available help tags
end
local telescopebisetup, telescopebi = pcall(require, 'telescope.builtin')


if telescopebisetup then
    keymap.set("n", "<leader>ff", telescopebi.find_files, { desc = "telescope find files" } ) -- find files within current working directory, respects .gitignore
    keymap.set("n", "<leader>fs", telescopebi.live_grep, { desc = "telescope live grep"}) -- find string in current working directory as you type
    keymap.set("n", "<leader>fc", telescopebi.grep_string, { desc = "telescope grep string"}) -- find string under cursor in current working directory
    keymap.set("n", "<leader>fb", telescopebi.buffers, { desc = "telescope find buffers"}) -- list open buffers in current neovim instance
    keymap.set("n", "<leader>fh", telescopebi.help_tags, { desc = "telescope find help tags"}) -- list available help tags
    keymap.set('n', '<leader>fm', telescopebi.keymaps, { desc = "telescope show all keymaps (custom + default)" })
end
--==========
--LuaSnip
--==========
local luasnipsetup, luasnip = pcall(require, 'luasnip')
if luasnipsetup then
    function LeaveSnippet()
        if
            ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
            and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
            and not luasnip.session.jump_active
        then
            luasnip.unlink_current()
        end
    end

    -- stop snippets when you leave to normal mode
    vim.api.nvim_command([[
autocmd ModeChanged * lua LeaveSnippet()
]])

    keymap.set({ "i", "s" }, "<Tab>", function()
        if (luasnip.expand_or_jumpable()) then
            luasnip.expand_or_jump()
        else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
    end, { silent = true })
    keymap.set({ "i", "s" }, "<S-Tab>", function() luasnip.jump(-1) end, { silent = true })

    keymap.set({ "i", "s" }, "<C-E>", function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end, { silent = true })
end
--=====================
--tmux
--=====================
local tmuxsetup, tmux = pcall(require, "tmux")
if tmuxsetup then
    keymap.set("n", "<S-Up>", function() tmux.resize_top() end, { desc = "resize split windows/split tmux windows" })
    keymap.set("n", "<S-Down>", function() tmux.resize_bottom() end, { desc = "resize split windows/split tmux windows" })
    keymap.set("n", "<S-Left>", function() tmux.resize_left() end, { desc = "resize split windows/split tmux windows" })
    keymap.set("n", "<S-Right>", function() tmux.resize_right() end, { desc = "resize split windows/split tmux windows" })
else
    keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
    keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
    keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
    keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

    keymap.set("n", "<S-Up>", "1<C-w>+", { noremap = true, silent = true })
    keymap.set("n", "<S-Down>", "1<C-w>-", { noremap = true, silent = true })
    keymap.set("n", "<S-Left>", "1<C-w><", { noremap = true, silent = true })
    keymap.set("n", "<S-Right>", "1<C-w>>", { noremap = true, silent = true })
end
--=====================
--oil
--=====================
local oilsetup, oil = pcall(require, "oil")

if not oilsetup then
    keymap.set("n", "<leader>oo", function() oil.open(oil.get_current_dir()) end, { desc = "opens oil.nvim" })
else
    keymap.set("n", "<leader>oo", function() vim.cmd("e .") end, { desc = "open file explorer" })
end
--=====================
--better escape
--=====================
local besc, _ = pcall(require, "jdhao/better-escape.vim")
if not besc then
    keymap.set("i", "jk", "<Esc>")
end
--=====================
--Obsidian
--=====================
local obssetup, _ = pcall(require, "obsidian")
if obssetup then
    keymap.set("n", "<leader>no", "<cmd>ObsidianOpen<cr>", { desc = "Open Obsidian" })
    keymap.set("n", "<leader>nn", "<cmd>ObsidianNew<cr>", { desc = "Create a new Obsidian Document" })
    keymap.set("n", "<leader>ns", "<cmd>ObsidianSearch<cr>", { desc = "Search Obsidian" })
    keymap.set("n", "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian Find Files" })
    keymap.set("n", "<leader>np", "<cmd>ObsidianPasteImg<cr>", { desc = "Obsidian Paste Image" })
    keymap.set("n", "<leader>nr", "<cmd>ObsidianRename<cr>", { desc = "Obsidian Rename current note" })
    keymap.set("n", "<leader>nt", "<cmd>ObsidianTemplate<cr>", { desc = "Insert Obsidian Template into file" })
end
local gitsignssetup, _ = pcall(require, "gitsigns")
if gitsignssetup then
    keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { silent=true, desc = "show git hunk diff"} );
    keymap.set("n", "<leader>gb", ":Gitsigns blame<CR>",        { silent=true, desc = "show git blame"} );
    keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>",        { silent=true, desc = "toggle line blame"} );
    keymap.set("n", "<leader>gs", ":Gitsigns toggle_signs<CR>",        { silent=true, desc = "toggle gitsigns"} );
end
--=====================
--CodeCompanion
--=====================
local codecompsetup, _ = pcall(require, "codecompanion")
if codecompsetup then
keymap.set("n", "<leader>cc", ":CodeCompanionChat<CR>", { silent=true, desc = "show git hunk diff"} );
end
