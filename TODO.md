# Dotfiles TODO

Review findings from 2026-10-24. Goal: simple setup of new MacBooks and keeping
the personal and work machines in sync.

## 1. Machine drift (Mac with hostname `WorkBook`, verified 2026-10-24)

- [x] `~/.ackrc` is a broken symlink → points to `shell/ackrc`, file now lives in `ack/ackrc`
- [x] `~/.ripgreprc` and `~/.gitattributes` are missing
- [x] These are plain copies, not symlinks, so repo edits never reach them:
      `~/.config/{atuin,bat,btop,ghostty}`, `~/.config/starship.toml`,
      `~/.config/zed/settings.json`, `~/.zsh_plugins.txt`
      (old copies saved in `~/.dotfiles-backup/20261024-205813/`)
- [x] `~/.config/ghostty/config` has newer changes than the repo; pulled into the repo
      along with 11 extra shaders. Live Zed `settings.json` pulled in too.
- [x] Installed but missing from `Brewfile`: added `ncdu`, `container`, casks
      `1password-cli`, `ghostty`, `opensuperwhisper`. Ghostty adopted into Homebrew
      (`brew install --cask --adopt`).
      Deliberately left out (`brew bundle cleanup` would offer to remove them):
      `node`, `opencode`, `ralphex` (+ taps `anomalyco/tap`, `umputun/apps`),
      `perl`, `python@3.14`, casks `container`, `thaw`, `ijhttp`, `homebrew-app`
- [ ] Apps installed outside Homebrew aren't tracked: 1Password, Zed, Raycast, Docker,
      Kaleidoscope, Tower, Things, aerospace, Protégé, etc. Do this with the Brewfile split
      in section 4; adopt existing installs with `brew install --cask --adopt`.
- [ ] Run `./setup.sh --check` on the other Mac and fix its drift the same way
      (pull newer live configs into the repo first)
- [x] `~/.ssh/config` is still a local file; now linked, local hosts moved to `~/.ssh/config.d/local`
- [ ] Homebrew warns about a circular dependency between `libtiff` and `webp` (stale keg data);
      fix with `brew uninstall --ignore-dependencies --force libtiff webp && brew install libtiff webp`

## 2. Bugs

### setup.sh
- [x] Runs `rm -f` / `rm -rf ~/.bin` with no backup and no check of what's there.
      Re-running it today would delete the newer Ghostty config. Back up real
      files to `~/.dotfiles-backup/<date>/` instead.
- [x] `BASE_DIR="$(pwd)"` breaks when run from another directory. Use
      `cd "$(dirname "$0")"` or `BASE_DIR="$(cd "$(dirname "$0")" && pwd)"`.
- [x] `ssh/config` is never linked.
- [x] Add a `--check` mode that reports missing, broken or non-symlinked targets.

### Shell
- [x] `~/.ripgreprc` is ignored: set `export RIPGREP_CONFIG_PATH=~/.ripgreprc`
- [x] `export TERM="xterm-256color"` in `zshrc` overrides Ghostty's `xterm-ghostty`; remove it
- [x] (`du` stays real `du -h -d 1`; ncdu flags moved to an `ncdu` alias) `du` is aliased twice (`aliases.zsh` lines 15 and 77), and aliasing it to ncdu breaks `fs()`
- [x] `gz` is both an alias and a function; the alias shadows the function (function renamed to `gzsize`)
- [x] `extract()` still lives in `functions.zsh` and duplicates the OMZ `extract` plugin
      (commit `f3f92f2` only removed `functions/extract`)
- [x] `pubkey` copies `~/.ssh/id_rsa.pub`, which is stale with 1Password + ed25519
- [x] (rewritten as a function without `pcregrep`) `ifactive` needs `pcregrep` (not installed); `du` needs `ncdu` (not in Brewfile)
- [x] `PYTHON_PATH` uses `brew --prefix python`, which isn't in Brewfile (uv is used instead)
- [x] (correction turned off) `setopt CORRECT` conflicts with `ENABLE_CORRECTION='false'`, an oh-my-zsh variable
      that does nothing here; pick one
- [x] History: 10k cap and `SHARE_HISTORY` off while atuin runs. Let atuin own history
      and keep the zsh settings minimal.

### Git
- [x] Remove the `reset = reset --hard HEAD~1` alias (it shadows a built-in command)
- [x] `master` is hard-coded in `branch-diff`, `branch-files`, `plom`, `plum`, `preb`, `pom`;
      make them detect the default branch (`git symbolic-ref refs/remotes/origin/HEAD`)
- [x] `[gpg] program = /opt/homebrew/bin/gpg` is unused with `format = ssh`; GPG comment
      above `gpgsign` is stale
- [x] `git://github.com` URL rewrites are dead (GitHub dropped `git://` in 2022)
- [x] Remove the SourceTree difftool/mergetool sections
- [x] `x` / `unx` aliases ran `git git update-index ...` (found while fixing)

### Misc configs
- [x] `curlrc` / `wgetrc` disguise as IE9 on Windows 7; drop the fake user-agent
- [x] (both back to wget defaults) `wgetrc`: reconsider `robots = off` and `server_response = on` as defaults

## 3. Cleanup

- [x] Remove `iterm/` (Ghostty is the terminal now)
- [x] Remove `shell/screenrc`
- [x] Remove `tap "homebrew/bundle"` from Brewfile (built in now; makes `brew bundle check` fail)
- [x] Fold `brew.sh` into a single bootstrap script (`bootstrap.sh`, `--macos` also runs `macos.sh`)
- [x] Replace repeated `brew --prefix` calls in `zshrc` with `$HOMEBREW_PREFIX`
- [x] Trim `atuin/config.toml` to the 3 settings that are actually set
- [x] `macos.sh` quit "System Preferences", which is "System Settings" since macOS 13 (found while fixing)

## 4. Two-machine sync (personal + work)

- [ ] Decide on the dotfiles approach (see "Tooling options" below).
      Recommended: option A, hardened symlinks plus include files.
- [ ] Split Brewfile: shared `Brewfile` + `Brewfile.personal` / `Brewfile.work`
- [ ] Add `cask` and `mas` entries; run `brew bundle dump --describe --force` on each Mac
      to capture what's actually installed
- [ ] Git identity per directory:
      `[includeIf "gitdir:~/Projects/Work/"] path = ~/.gitconfig.work`
      (the EPAM email ended up on commit `f3f92f2` in this personal repo)
- [x] SSH: shared `ssh/config` with `Include ~/.ssh/config.d/*` at the top and `Host *` last;
      machine-specific hosts stay in local `config.d/` files
- [ ] Turn on atuin sync between both Macs (`atuin register` / `atuin login`)
- [ ] Track `~/.localrc` template (e.g. `localrc.example`) so a new Mac knows what to fill in

### Tooling options

| Tool | Approach | Work vs personal | Drift | Learning curve |
|---|---|---|---|---|
| Hardened `setup.sh` | Symlinks | Include files (`~/.gitconfig.work`, `~/.ssh/config.d/`, `~/.localrc`, `Brewfile.work`) | Can't happen for linked files; `--check` catches broken/missing links | None |
| GNU Stow | Symlinks, one folder ("package") per tool | Separate packages, e.g. `stow common work` | Same as above | Very low |
| Dotbot | Symlinks described in `install.conf.yaml` | A second config file per machine | Same as above; safe to re-run | Low |
| yadm | `$HOME` is the git working tree | Alternate files (`.gitconfig##class.work`) + templates | `yadm status` | Low (just git) |
| Bare git repo | `git --git-dir=~/.dotfiles --work-tree=~` | None built in | `git status` | Low, no help |
| chezmoi | Copies files out of a source repo | Templates + prompts | `chezmoi diff` | Medium |
| Nix + nix-darwin + home-manager | Declares packages, configs and macOS defaults | Separate config per host | Impossible by design; rollbacks | High |
| Mackup | Syncs GUI app prefs via iCloud | n/a | n/a | Low; symlink mode broken on recent macOS, use copy mode as an add-on only |

Key points:

- **Symlinks vs copies matters more than the tool.** With symlinks, app-side edits
  (Zed, Ghostty) land in the repo immediately. The Ghostty drift only happened because
  those files ended up as copies. Copy-based tools (chezmoi) need `re-add` after app edits.
- **Most work/personal differences don't need templates:** git `includeIf`, ssh `Include`,
  `~/.localrc` and `brew bundle --file` all work with plain symlinks. Templates only win
  when machine-specific parts or secrets (via 1Password) should live in the repo too.
- **yadm** is closest to plain git habits, but the repo stops being a normal folder
  under `~/Projects`.
- **Nix** is the most powerful and the most expensive: a new language and ecosystem,
  overkill for two Macs unless you like the declarative style.

**Option A (recommended): keep it simple.** Hardened `setup.sh` (or Dotbot/Stow) plus include
files for machine-specific parts. Least effort, edits flow back automatically, and you
can still move to chezmoi later.

**Option B: keep everything in the repo, secrets included.** chezmoi. Costs: copy semantics,
`dot_` file naming, templates add indirection, and 1Password `op` must be signed in for
`chezmoi apply`.

### chezmoi migration details (if option B)

- Layout: `.chezmoiroot` containing `home`, managed files under `home/` with chezmoi
  names (`dot_zshrc.tmpl`, `private_dot_ssh/config.tmpl`, `dot_config/ghostty/`, ...).
  Keeps `README.md`, `TODO.md`, `CLAUDE.md` out of `~`.
- `home/.chezmoi.toml.tmpl`: `promptChoiceOnce` for `machine` (personal/work) and
  `promptStringOnce` for git email; `sourceDir = "~/Projects/Personal/dotfiles"` keeps
  the repo where it is.
- Templates only where machines really differ: `dot_gitconfig.tmpl` (email, signing key via
  `onepasswordRead`), `private_dot_ssh/config.tmpl` (machine-specific hosts).
- Scripts: `run_once_before_10-install-homebrew.sh`,
  `run_onchange_after_20-brew-bundle.sh.tmpl` (Brewfile hash in a comment triggers re-runs),
  `run_onchange_after_30-bat-cache.sh.tmpl`, `run_once_after_90-macos.sh`.
- New Mac: `sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mzubok`
  (sign in to 1Password and enable SSH agent + CLI integration first).
- Daily use: `chezmoi edit`, `chezmoi diff`, `chezmoi re-add` (after app edits),
  `chezmoi update` (pull + apply on the other Mac).
- Gotcha: current `~` files are symlinks into the repo, so `chezmoi add` would add symlinks.
  Migrate with `git mv` renames, then `chezmoi diff`, then `chezmoi apply`.
- Steps: fix drift, then `brew install chezmoi`, then `git mv` into `home/` on a branch,
  then write config/templates, convert `brew.sh`/`macos.sh` to `run_` scripts,
  `chezmoi init` + review diff + `apply` on each Mac, then delete `setup.sh`/`brew.sh`
  and update `CLAUDE.md`.

## 5. Safety nets

- [ ] GitHub Action running `shellcheck` on `*.sh` and `functions/*`
- [ ] `gitleaks` pre-commit hook (already in Brewfile)

## Suggested order

1. Make `setup.sh` non-destructive, then pull the live Ghostty config back into the repo
2. Fix the bugs in section 2
3. Split Brewfile and add casks
4. Decide on the tooling (option A vs option B in section 4)
