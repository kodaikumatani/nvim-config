-- mise の PATH を設定（Go、goplsなどのツールを使用可能にする）
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

-- Leader key
vim.g.mapleader = " "

-- 基本設定
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- インサートモードを抜ける時に自動保存
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.filereadable(vim.fn.expand("%")) == 1 then
      vim.cmd("silent! write")
    end
  end,
})

require("config.lazy")
vim.cmd.colorscheme("tokyonight")

-- キーマップ
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true, desc = "Toggle Neo-tree" })
vim.keymap.set("n", "<leader>g", ":Neotree git_status<CR>", { noremap = true, silent = true, desc = "Git変更ファイル" })

-- Neovide設定
if vim.g.neovide then
  -- macOSのCmd key (Command key) を有効化
  vim.g.neovide_input_use_logo = 1

  -- Cmd+C でコピー (visualモード)
  vim.keymap.set("v", "<D-c>", '"+y', { noremap = true, silent = true, desc = "コピー" })

  -- Cmd+V でペースト
  vim.keymap.set("n", "<D-v>", '"+p', { noremap = true, silent = true, desc = "ペースト" })
  vim.keymap.set("v", "<D-v>", '"+p', { noremap = true, silent = true, desc = "ペースト" })
  vim.keymap.set("i", "<D-v>", '<C-r>+', { noremap = true, silent = true, desc = "ペースト" })
  vim.keymap.set("t", "<D-v>", '<C-\\><C-n>"+pi', { noremap = true, silent = true, desc = "ターミナルでペースト" })

  -- Cmd+X でカット (visualモード)
  vim.keymap.set("v", "<D-x>", '"+d', { noremap = true, silent = true, desc = "カット" })

  -- ターミナルトグル機能
  local terminal_buf = nil
  local terminal_win = nil

  local function toggle_terminal()
    -- ターミナルウィンドウが開いているか確認
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
      vim.api.nvim_win_hide(terminal_win)
      terminal_win = nil
      return
    end

    -- ターミナルバッファが存在するか確認
    if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
      -- 既存のターミナルバッファを開く
      vim.cmd("botright split")
      terminal_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(terminal_win, terminal_buf)
      vim.api.nvim_win_set_height(terminal_win, 15)
      vim.cmd("startinsert")
    else
      -- 新しいターミナルを作成
      vim.cmd("botright split | terminal")
      terminal_win = vim.api.nvim_get_current_win()
      terminal_buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_win_set_height(terminal_win, 15)
      vim.cmd("startinsert")
    end
  end

  -- Cmd+J でターミナルをトグル
  vim.keymap.set("n", "<D-j>", toggle_terminal, { noremap = true, silent = true, desc = "ターミナルをトグル" })
  vim.keymap.set("t", "<D-j>", function()
    vim.api.nvim_win_hide(terminal_win)
    terminal_win = nil
  end, { noremap = true, silent = true, desc = "ターミナルを閉じる" })

  -- Cmd+Shift+N で新しいウィンドウを開く
  vim.keymap.set("n", "<D-N>", function()
    vim.fn.jobstart("open -n -a Neovide", { detach = true })
  end, { noremap = true, silent = true, desc = "新しいNeovideウィンドウを開く" })
end

-- ウィンドウ間の移動
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "左のウィンドウへ移動" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "下のウィンドウへ移動" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "上のウィンドウへ移動" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "右のウィンドウへ移動" })

-- Telescope (曖昧検索)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'ファイル検索' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'テキスト検索' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'バッファ検索' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'ヘルプ検索' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '最近開いたファイル' })