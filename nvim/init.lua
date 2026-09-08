-- nvim/init.lua — github.com/WillieXia/dotfiles-public
--
-- Symlinked into place, so editing the live config edits this repo:
--   mkdir -p ~/.config/nvim
--   ln -sf ~/dotfiles-public/nvim/init.lua ~/.config/nvim/init.lua

vim.opt.number = true

-- One buffer line == one pane row, so the number gutter stays in lockstep with
-- the rows tmux is drawing. With 'wrap' on, a line longer than the pane spills
-- onto continuation rows that carry no number and the two counts drift apart.
-- Long lines now scroll horizontally instead; '>' and '<' in the last/first
-- column mark text cut off to the right/left.
vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 8

-- The extends/precedes markers only render with 'list' on, so it has to be
-- enabled. The two-char 'tab' entry draws a tab as a blank padded to the next
-- tabstop, keeping tab width intact, and omitting eol/trail/nbsp keeps the
-- rest of the buffer looking exactly as it does with 'list' off.
vim.opt.list = true
vim.opt.listchars = { tab = '  ', extends = '>', precedes = '<' }

-- Yank to the system clipboard. Inside tmux, Nvim selects the tmux provider
-- (`tmux load-buffer -w -`); the -w forwards the buffer to the outer terminal
-- via OSC 52, so yanks reach the laptop clipboard across SSH.
vim.opt.clipboard = 'unnamedplus'
