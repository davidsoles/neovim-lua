local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move between splits using arrow keys
keymap("n", "<C-Up>", "<C-w><C-K>", opts)
keymap("n", "<C-Down>", "<C-w><C-J>", opts)
keymap("n", "<C-Left>", "<C-w><C-H>", opts)
keymap("n", "<C-Right>", "<C-w><C-L>", opts)

-- Move to the next buffer
keymap("n", "<C-]>", ":bn<CR>", opts)

-- Move one line up/down in normal mode
keymap("n", "<C-j>", ":m .+1<CR>==", opts)
keymap("n", "<C-k>", ":m .-2<CR>==", opts)

-- Move block of lines up/down in visual mode
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown previewer=false<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers theme=dropdown previewer=false<CR>", opts)

-- File explorer
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Debugger
keymap("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<F6>", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F7>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F8>", "<cmd>lua require'dap'.continue()<CR>", opts)

-- Bufferline
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<leader>q", ":bdelete<CR>", opts)
keymap("n", "<leader>Q", ":bdelete!<CR>", opts)

-- Terminal
keymap("n", "<leader>t", ":ToggleTerm<CR>", opts)
keymap("t", "<leader><esc>", "<C-\\><C-n>", opts)

-- Terminal with Lazygit
local Terminal  = require('toggleterm.terminal').Terminal

function _lazygit_toggle()
  lazygit:toggle()
end

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("Closing terminal")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
