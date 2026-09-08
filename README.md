# dotfiles-public

My terminal configs — WezTerm, tmux, Neovim, vim, readline — each kept in one
file so they can be dropped onto any machine.

Public on purpose. Shell configs (`.bashrc`, `.bash_profile`, `.gitconfig`) are
deliberately **not** here: they carry API tokens, certificate paths and other
machine-specific state. See [Per-machine tweaks](#per-machine-tweaks) for
anything else that shouldn't be shared.

## Install on a fresh machine

```bash
git clone https://github.com/WillieXia/dotfiles-public.git ~/dotfiles-public

ln -sf ~/dotfiles-public/wezterm.lua ~/.wezterm.lua
ln -sf ~/dotfiles-public/tmux.conf   ~/.tmux.conf
ln -sf ~/dotfiles-public/vimrc       ~/.vimrc
ln -sf ~/dotfiles-public/inputrc     ~/.inputrc
mkdir -p ~/.config/nvim && ln -sf ~/dotfiles-public/nvim/init.lua ~/.config/nvim/init.lua
```

HTTPS on purpose — a fresh machine has no SSH key yet, and the repo is public so
the clone needs no auth. Swap the remote to SSH when you want to push from it:

```bash
git -C ~/dotfiles-public remote set-url origin git@github.com:WillieXia/dotfiles-public.git
```

Because everything is symlinked, editing the live config edits the repo:

```bash
cd ~/dotfiles-public && git commit -am "tweak font size" && git push
```

and `git pull` on the other machine picks it up.

WezTerm needs `brew install --cask wezterm` (or your platform's installer), plus
the font, which is the one loose end: `JetBrains Mono` isn't installed by
default and silently falls back to Menlo/DejaVu.

```bash
brew install --cask font-jetbrains-mono
```

## What's in it

### `wezterm.lua`

| | |
|---|---|
| Theme | Catppuccin Mocha, JetBrains Mono 13pt with fallbacks |
| Tab bar | Hidden until there's a second tab, then bottom-aligned |
| Splits | `d` horizontal, `e` vertical, `w` close, arrows to navigate |
| Modifier | `CMD` on macOS, `CTRL+SHIFT` elsewhere |
| Scrollback | 100k lines, bell off |

WezTerm reloads on save — no restart needed. If it's already running,
`CTRL+SHIFT+R` reloads by hand.

It takes the first of these that exists, so the symlink only loses if you've
made one of the earlier ones yourself:

1. `--config-file` flag
2. `$WEZTERM_CONFIG_FILE`
3. `$XDG_CONFIG_HOME/wezterm/wezterm.lua`
4. `~/.config/wezterm/wezterm.lua`
5. `~/.wezterm.lua` ← this repo

To confirm which file loaded, open the debug overlay with `CTRL+SHIFT+L` and
evaluate `wezterm.config_file`.

### `tmux.conf`

| | |
|---|---|
| Prefix | `C-a`, with `C-a C-a` sending a literal `C-a` through |
| Panes | `C-<arrow>` resizes by 5 cols / 3 rows, repeatable |
| Windows | prefix `<` / `>` swaps the current window left / right |
| Clipboard | `set-clipboard on` + passthrough, so OSC 52 reaches the laptop over SSH |
| Scrollback | 500k lines, vi copy-mode keys |

Reload a running server with `tmux source-file ~/.tmux.conf`.

### `nvim/init.lua`

No plugins. Absolute line numbers, `wrap` off so the number gutter stays in
lockstep with the pane rows, `>`/`<` markers for text cut off horizontally, and
`clipboard=unnamedplus` so yanks travel out through tmux via OSC 52.

### `vimrc`, `inputrc`

`vimrc` is a stub — everything real lives in the Neovim config; it only sources
a site-wide `master.vimrc` when `$LOCAL_ADMIN_SCRIPTS` points at one, and is a
no-op otherwise. `inputrc` is three readline niceties: bracketed paste, coloured
completion prefix, blinking matching paren.

## Per-machine tweaks

Not wired up yet — add it the day one machine actually needs a different font
size, and not before. When that day comes, insert this above the final
`return config` in `wezterm.lua`:

```lua
local ok, overrides = pcall(dofile, wezterm.home_dir .. "/dotfiles-public/local.lua")
if ok and type(overrides) == "table" then
  for k, v in pairs(overrides) do config[k] = v end
end
```

and have `local.lua` return a table, e.g. `return { font_size = 15.0 }`.

Note the explicit path: `require("local")` would *not* work here. WezTerm's
`package.path` covers `~/.config/wezterm` and `~/.wezterm`, neither of which is
where this repo lives when installed via the `~/.wezterm.lua` symlink.

`local.lua` is already in `.gitignore`, so per-machine settings — and anything
you'd rather not publish — stay off GitHub.
