# dev_environment_setup

Cross-platform workstation auto-setup for macOS and Debian/Ubuntu using Ansible.

Installs and configures:

- **zsh** with Oh My Zsh (plugins) and Oh My Posh (prompt)
- **GPG + SSH agents** with macOS Keychain auto-unlock when available
- **kubectl** with krew plugins `ctx` and `ns` (aliases `kctx` / `kns`)
- **GitHub CLI** (`gh`)
- **Homebrew** (macOS) with casks FreeLens and Wave

## Quick start

```bash
# 1. Bootstrap Python, Ansible, and dependencies
./scripts/setup.sh

# 2. Run the workstation setup (will prompt for sudo password)
./scripts/run_ansible.sh
```

See [docs/setup.md](docs/setup.md) for details.

## Customization

Edit [ansible/group_vars/all.yml](ansible/group_vars/all.yml) to change:

- Oh My Posh theme (`omp_theme`)
- SSH key paths (`ssh_identities`)
- Optional GPG key id (`gpg_key_id`)
- macOS Homebrew casks (`homebrew_casks`)

## Supported platforms

| Platform | Package manager |
|----------|-----------------|
| macOS    | Homebrew        |
| Debian/Ubuntu | apt        |
