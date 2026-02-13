return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    window = {
      position = "float",
    },
    -- ターミナルなど特定のウィンドウを除外
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true, -- 隠しファイルを表示
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
        never_show = {
          ".git",
          ".DS_Store",
          "thumbs.db",
        },
      },
    },
    use_popups_for_input = false,
    enable_cursor_hijack = false,
  },
}
