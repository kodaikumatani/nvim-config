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

  -- 左半分ターミナルトグル機能
  local terminal_buf = nil
  local terminal_win = nil

  local function toggle_terminal()
    -- ターミナルウィンドウが開いているか確認
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
      vim.api.nvim_win_close(terminal_win, true)
      terminal_win = nil
      return
    end

    -- ターミナルバッファが存在するか確認
    if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
      -- 既存のターミナルバッファを開く
      vim.cmd("leftabove vsplit")
      terminal_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(terminal_win, terminal_buf)
      vim.cmd("startinsert")
    else
      -- 新しいターミナルを作成
      vim.cmd("leftabove vsplit | terminal")
      terminal_win = vim.api.nvim_get_current_win()
      terminal_buf = vim.api.nvim_get_current_buf()
      vim.cmd("startinsert")
    end
  end

  -- Cmd+J でターミナルをトグル
  vim.keymap.set("n", "<D-j>", toggle_terminal, { noremap = true, silent = true, desc = "ターミナルをトグル" })
  vim.keymap.set("t", "<D-j>", function()
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
      vim.api.nvim_win_hide(terminal_win)
      terminal_win = nil
    end
  end, { noremap = true, silent = true, desc = "ターミナルを閉じる" })

  -- Cmd+Shift+N で新しいウィンドウを開く
  vim.keymap.set("n", "<D-N>", function()
    vim.fn.jobstart("open -n -a Neovide", { detach = true })
  end, { noremap = true, silent = true, desc = "新しいNeovideウィンドウを開く" })
end
