# dotfiles-public

My WezTerm config, kept in one file so it can be dropped onto any machine.

Public on purpose — nothing machine-specific or private lives here. See
[Per-machine tweaks](#per-machine-tweaks) for anything that shouldn't be shared.

## Install

```bash
git clone git@github.com:WillieXia/dotfiles-public.git ~/dotfiles-public
ln -sf ~/dotfiles-public/wezterm.lua ~/.wezterm.lua
```

WezTerm reads `~/.wezterm.lua` as long as `~/.config/wezterm/` doesn't exist, so
that's the whole setup. Because it's a symlink, editing `~/.wezterm.lua` edits
the repo:

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
size, and not before. When that day comes, append to `wezterm.lua`:

```lua
pcall(function() require("local") end)
```

then drop a `local.lua` next to it that mutates `config`. It's already in
`.gitignore`, so per-machine settings (and anything you'd rather not publish)
stay off GitHub.
