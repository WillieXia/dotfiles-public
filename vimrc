" vimrc — github.com/WillieXia/dotfiles-public
"
"   ln -sf ~/dotfiles-public/vimrc ~/.vimrc
"
" Nearly everything lives in the Neovim config (nvim/init.lua); this file only
" exists so plain `vim` isn't left bare. On a work machine $LOCAL_ADMIN_SCRIPTS
" points at a site-wide master.vimrc worth picking up; the guard keeps this a
" no-op anywhere that variable isn't set, instead of an error on every launch.

if !empty($LOCAL_ADMIN_SCRIPTS) && filereadable($LOCAL_ADMIN_SCRIPTS . '/master.vimrc')
  execute 'source' fnameescape($LOCAL_ADMIN_SCRIPTS . '/master.vimrc')
endif
