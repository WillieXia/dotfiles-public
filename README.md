# dotfiles-public

My WezTerm config, kept in one file so it can be dropped onto any machine.

Public on purpose — nothing machine-specific or private lives here. See
[Per-machine tweaks](#per-machine-tweaks) for anything that shouldn't be shared.

## Install on a fresh machine

```bash
brew install --cask wezterm                 # or your platform's installer
git clone https://github.com/WillieXia/dotfiles-public.git ~/dotfiles-public
ln -sf ~/dotfiles-public/wezterm.lua ~/.wezterm.lua
```

HTTPS on purpose — a fresh machine has no SSH key yet, and the repo is public so
the clone needs no auth. Swap the remote to SSH when you want to push from it:

```bash
git -C ~/dotfiles-public remote set-url origin git@github.com:WillieXia/dotfiles-public.git
```

Then just launch WezTerm. A fresh install writes no config of its own — it falls
back to built-in defaults — so `~/.wezterm.lua` is unclaimed and gets picked up
on first start. If WezTerm is already running, `CTRL+SHIFT+R` reloads.

WezTerm takes the first of these that exists, so the symlink only loses if you've
made one of the earlier ones yourself:

1. `--config-file` flag
2. `$WEZTERM_CONFIG_FILE`
3. `$XDG_CONFIG_HOME/wezterm/wezterm.lua`
4. `~/.config/wezterm/wezterm.lua`
5. `~/.wezterm.lua` ← this repo

To confirm which file loaded, open the debug overlay with `CTRL+SHIFT+L` and
evaluate `wezterm.config_file`.

The font is the one loose end: `JetBrains Mono` isn't installed by default and
silently falls back to Menlo/DejaVu. To get the real thing:

```bash
brew install --cask font-jetbrains-mono
```

## Day-to-day

Because it's a symlink, editing `~/.wezterm.lua` edits the repo:

```bash
cd ~/dotfiles-public && git commit -am "tweak font size" && git push
```

and `git pull` on the other machine picks it up. WezTerm reloads on save — no
restart needed.

## What's in it

| | |
|---|---|
| Theme | Catppuccin Mocha, JetBrains Mono 13pt with fallbacks |
| Tab bar | Hidden until there's a second tab, then bottom-aligned |
| Splits | `d` horizontal, `e` vertical, `w` close, arrows to navigate |
| Modifier | `CMD` on macOS, `CTRL+SHIFT` elsewhere |
| Scrollback | 100k lines, bell off |

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
