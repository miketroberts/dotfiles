return {
  'ruifm/gitlinker.nvim',
  opts = {
    mappings = nil
  },
  keys = {
    { '<leader>gy', '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>', mode = { 'n', 'v' }, desc = 'Get github link' }
  }
}
