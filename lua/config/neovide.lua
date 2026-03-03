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

  -- ターミナルモードで Ctrl+[ でnormalモードへ
  vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "ターミナルからnormalモードへ" })

  -- Cmd+Shift+N で新しいウィンドウを開く
  vim.keymap.set("n", "<D-N>", function()
    vim.fn.jobstart("open -n -a Neovide", { detach = true })
  end, { noremap = true, silent = true, desc = "新しいNeovideウィンドウを開く" })
end
