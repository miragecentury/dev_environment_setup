# Setup

Cross-platform guide to configure your workstation with zsh, Oh My Posh, GPG/SSH agents, and kubectl tooling.

## Prerequisites

- macOS or Debian/Ubuntu
- Internet access
- sudo access (for system packages)

## Steps

### 1. Bootstrap

Installs Python, Ansible, and the `community.general` collection:

```bash
./scripts/setup.sh
```

On macOS, Homebrew is installed automatically if missing.

### 2. Run Ansible

```bash
./scripts/run_ansible.sh
```

On macOS with Touch ID, `run_ansible.sh` runs `sudo -v` first (Touch ID or password in the terminal), then passes `ansible_become_flags=-H` so Ansible reuses that sudo session. Ansible’s default `-H -S -n` flags ignore the cached timestamp on macOS. On Linux, or when Touch ID is unavailable, you will be prompted for your sudo password up front via `--ask-become-pass`.

### 3. Start a new shell

```bash
exec zsh
```

## What gets configured

| Component | macOS | Debian/Ubuntu |
|-----------|-------|-----------------|
| zsh + Zinit | Homebrew | apt |
| Oh My Posh prompt | Homebrew | official installer |
| GPG agent | pinentry-mac + Keychain | default pinentry |
| SSH agent | Keychain (`UseKeychain`) | keychain tool + Zinit-loaded OMZ plugins |
| kubectl | Homebrew | binary download |
| talosctl | Homebrew | binary download |
| kctx / kns | krew `ctx` + `ns` plugins | krew `ctx` + `ns` plugins |
| mirrord | Homebrew (`metalbear-co/mirrord`) | install script |
| mongosh | Homebrew | MongoDB apt repo |
| Redis (`redis-cli`) | Homebrew (`redis`) | apt (`redis-tools`) |
| Cilium CLI | Homebrew (`cilium-cli`) | GitHub release tarball |
| Argo CD / Kargo CLIs | Homebrew | GitHub release binaries |
| CLI tools (`htop`, `dig`, `nmap`, …) | Homebrew | apt |
| Poetry / uv / pre-commit | Homebrew | pipx + uv install script |
| Rust (`rustc`, `cargo`) | rustup install script | rustup install script |
| Angular CLI / Vite / TypeScript / ESLint / Prettier | npm global (Node via Homebrew) | npm global (Node via apt) |
| DeerHide agent skills | `npx skills add` (Node via Homebrew) | `npx skills add` (Node via apt) |
| RTK / CodeGraph / caveman / ponytail | install scripts + `npx skills add` | install scripts + `npx skills add` |
| GitHub CLI (`gh`) | Homebrew | official apt repo |
| Homebrew + casks | Homebrew, FreeLens, Wave, Cursor CLI | — |
| Terminal font | Meslo Nerd Font cask + set in Cursor & Wave | — |

## Customization

Edit `ansible/group_vars/all.yml`:

```yaml
omp_config: "{{ ansible_env.HOME }}/.config/oh-my-posh/config.toml"
ssh_identities:
  - ~/.ssh/github
  - ~/.ssh/my-other-key
gpg_key_id: ""  # optional
homebrew_casks:
  - freelens
  - wave
  - font-meslo-lg-nerd-font
  - cursor-cli
terminal_font: "MesloLGS Nerd Font Mono"  # applied to Cursor & Wave terminals
```

Re-run `./scripts/run_ansible.sh` after changes.

The `fonts` role installs a Nerd Font and merges `terminal_font` into the Cursor
(`terminal.integrated.fontFamily` / `editor.fontFamily`) and Wave (`term:fontfamily`)
settings, preserving any other settings you already have. To use a different font,
add its cask to `homebrew_casks` and point `terminal_font` at the installed family
name (check with `fc-list | grep -i "<name>"`).

## Pre-clone GitHub repos

After the main setup, pre-clone DeerHide and laelidona repositories:

```bash
./scripts/run_miragecentury.sh
```

Repos are cloned to `~/projects/github/<org>/<repo>`. Edit the repo list in
`ansible/group_vars/miragecentury.yml`. Requires SSH access to GitHub (typically
configured by the main playbook via `ssh_identities`).

## macOS Keychain notes

- sudo: Touch ID is enabled via `/etc/pam.d/sudo_local` when `pam_tid` is present and `sudo_touchid: true` (default). `run_ansible.sh` runs `sudo -v` then sets `ansible_become_flags=-H` so the playbook reuses that session. Set `sudo_touchid: false` in `group_vars/all.yml` to disable.
- SSH: `ssh_config` sets a dedicated `Host github.com` block (`IdentitiesOnly yes`, `IdentityFile` from `github_ssh_identity`, port 443 via `ssh.github.com`) so Git always uses the right key and avoids port-22 timeouts; `Host *` sets `UseKeychain yes` / `AddKeysToAgent yes` for other hosts. The first `git`/`ssh` connect prompts once and stores the passphrase in Keychain; later runs auto-load it (the playbook also pre-loads cached keys via `ssh-add --apple-load-keychain`).
- GPG: `pinentry-mac` shows a "Save in Keychain" checkbox when unlocking your key — check it once for auto-unlock.
- Keys that don't exist on disk are skipped silently.

## Verify

```bash
oh-my-posh --version
echo $SHELL          # should end in /zsh
kubectl krew list    # should include ctx and ns
talosctl version --client   # should print the talosctl version
mirrord --version           # should print the mirrord version
mongosh --version           # should print the mongosh version
redis-cli --version         # should print the redis-cli version
cilium version --client     # should print the cilium CLI version
argocd version --client     # should print the argocd CLI version
kargo version --client      # should print the kargo CLI version
gh --version                # should print the GitHub CLI version
poetry --version            # should print the Poetry version
uv --version                # should print the uv version
pre-commit --version        # should print the pre-commit version
rustc --version             # should print the Rust compiler version
cargo --version             # should print the Cargo version
ng version                  # should print the Angular CLI version
vite --version              # should print the Vite version
tsc --version               # should print the TypeScript compiler version
tsx --version               # should print the tsx version
eslint --version            # should print the ESLint version
prettier --version          # should print the Prettier version
ssh-add -l           # macOS: keys listed without passphrase prompt after Keychain setup
fc-list | grep -i meslo   # macOS: confirms the Nerd Font is installed
```

After the run, restart Cursor and Wave so they pick up the new terminal font.
