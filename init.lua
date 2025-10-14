-- [[ SETTINGS ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("dre.set")

-- [[ KEYMAPS ]]
require("dre.remap") 
-- [[ LAZY.NVIM BOOTSTRAP ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- [[ PLUGINS ]]
--  lazy load all files in lua/plugins/
require("lazy").setup("plugins")

