require "nvchad.options"

vim.opt.autoread = true -- reload buffers changed on disk so LSPs stay in sync with external edits

vim.filetype.add({
  filename = {
    ["Tiltfile"] = "starlark",
  },
  pattern = {
    ["Tiltfile.*"] = "starlark",
  },
})
