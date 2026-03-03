return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-\\>", desc = "Toggle terminal" },
    { "<leader>tt", desc = "Toggle terminal (tab)" },
  },
  opts = {
    direction = "vertical",
    size = function(term)
      if term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
      return 15
    end,
    shade_terminals = false,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    vim.keymap.set({ "n", "t" }, "<C-\\>", function()
      require("toggleterm").toggle(1, nil, vim.fn.getcwd(), "vertical")
      -- Move the terminal window to the far left
      vim.cmd("wincmd H")
    end, { desc = "Toggle terminal (left)" })

    vim.keymap.set({ "n", "t" }, "<leader>tt", function()
      -- ターミナルバッファにいる場合、そのバッファを新しいタブに移動
      if vim.bo.buftype == "terminal" then
        local buf = vim.api.nvim_get_current_buf()
        vim.cmd("close")
        vim.cmd("tabnew")
        vim.api.nvim_set_current_buf(buf)
        vim.cmd("startinsert")
      else
        vim.cmd("tabnew | terminal")
        vim.cmd("startinsert")
      end
    end, { desc = "Toggle terminal (tab)" })
  end,
}
