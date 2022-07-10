require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
        enable = false,
        icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
        },
    },
    icons = {
        webdev_colors = true,
        git_placement = "before",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
            file = false,
            folder = true,
            folder_arrow = false,
            git = false,
        },
        glyphs = {
            default = "",
            symlink = "",
            folder = {
                arrow_closed = "",
                arrow_open = "",
                default = ">",
                open = "-",
                empty = " ",
                empty_open = " ",
                symlink = " ",
                symlink_open = " ",
            },
            git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
            },
        },
    },
  },
  filters = {
    dotfiles = true,
    custom = { '.mvn', '.settings', '.classpath', '.factorypath', '.project' },
  },
  actions = {
      open_file = {
          quit_on_open = true
      }
  },
})
