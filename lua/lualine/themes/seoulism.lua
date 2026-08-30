local colors = {
  bg = '#111116',
  bg_faint = '#121318',
  bg_int = '#2b2e36',
  fg = '#efeeea',
  fg_faint = '#d7d6d2',
  red = '#e05a55',
  green = '#35a06f',
  yellow = '#e5c15a',
  blue = '#3f6bd9',
}

local theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.red, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_int },
    c = { fg = colors.fg_faint, bg = colors.bg_faint },
  },
  insert = {
    a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_int },
    c = { fg = colors.fg_faint, bg = colors.bg_faint },
  },
  visual = {
    a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_int },
    c = { fg = colors.fg_faint, bg = colors.bg_faint },
  },
  replace = {
    a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_int },
    c = { fg = colors.fg_faint, bg = colors.bg_faint },
  },
  command = {
    a = { fg = colors.bg, bg = colors.fg, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg_int },
    c = { fg = colors.fg_faint, bg = colors.bg_faint },
  },
  inactive = {
    a = { fg = colors.fg_faint, bg = colors.bg_faint },
    b = { fg = colors.fg_faint, bg = colors.bg_faint },
    c = { fg = colors.fg_faint, bg = colors.bg_faint },
  },
}

theme.terminal = theme.command

return theme
