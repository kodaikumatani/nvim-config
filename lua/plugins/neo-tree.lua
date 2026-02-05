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
    event_handlers = {
      {
        event = "after_render",
        handler = function(state)
          if not require("neo-tree.sources.common.preview").is_active() then
            state.config = { use_float = true }
            state.commands.toggle_preview(state)
          end
        end,
      },
    },
    use_popups_for_input = false,
    enable_cursor_hijack = false,
  },
}
