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

You will be prompted for your sudo password. On macOS, you may also be prompted once per SSH key passphrase to store them in Keychain — after that, keys auto-unlock via the macOS vault.

### 3. Start a new shell

```bash
exec zsh
```

## What gets configured

| Component | macOS | Debian/Ubuntu |
|-----------|-------|-----------------|
| zsh + Oh My Zsh | Homebrew | apt |
| Oh My Posh prompt | Homebrew | official installer |
| GPG agent | pinentry-mac + Keychain | default pinentry |
| SSH agent | Keychain (`UseKeychain`) | keychain tool + OMZ plugins |
| kubectl | Homebrew | binary download |
| talosctl | Homebrew | binary download |
| kctx / kns | krew `ctx` + `ns` plugins | krew `ctx` + `ns` plugins |
| Homebrew + casks | Homebrew, FreeLens, Wave, Cursor CLI | — |
| Terminal font | Meslo Nerd Font cask + set in Cursor & Wave | — |

## Customization

Edit `ansible/group_vars/all.yml`:

```yaml
omp_theme: jandedobbeleer
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

## macOS Keychain notes

- SSH: `ssh_config` sets `UseKeychain yes` / `AddKeysToAgent yes`, so the first `git`/`ssh` connect prompts once and stores the passphrase in Keychain; later runs auto-load it (the playbook also pre-loads cached keys via `ssh-add --apple-load-keychain`).
- GPG: `pinentry-mac` shows a "Save in Keychain" checkbox when unlocking your key — check it once for auto-unlock.
- Keys that don't exist on disk are skipped silently.

## Verify

```bash
oh-my-posh --version
echo $SHELL          # should end in /zsh
kubectl krew list    # should include ctx and ns
talosctl version --client   # should print the talosctl version
ssh-add -l           # macOS: keys listed without passphrase prompt after Keychain setup
fc-list | grep -i meslo   # macOS: confirms the Nerd Font is installed
```

After the run, restart Cursor and Wave so they pick up the new terminal font.
