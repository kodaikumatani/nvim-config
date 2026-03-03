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
      local term = require("toggleterm.terminal").Terminal:new({
        direction = "vertical",
        dir = vim.fn.getcwd(),
      })
      -- If a terminal already exists, just toggle it on the left
      require("toggleterm").toggle(1, nil, nil, "vertical")
      -- Move the terminal window to the far left
      vim.cmd("wincmd H")
    end, { desc = "Toggle terminal (left)" })

    vim.keymap.set("n", "<leader>tt", function()
      require("toggleterm").toggle(2, nil, nil, "tab")
    end, { desc = "Toggle terminal (tab)" })
  end,
}
