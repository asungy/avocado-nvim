local M = {}

M.example = function()
  -- Open a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set the lines for the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {"Hello", "World"})

  -- Open a new window and set its buffer
  local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = 10,
      height = 2,
      row = 1,
      col = 1
  })
end

return M
