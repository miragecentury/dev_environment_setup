# dev_environment_setup

Cross-platform workstation auto-setup for macOS and Debian/Ubuntu using Ansible.

Installs and configures:

- **zsh** with Zinit (plugin manager, self-bootstrapping) and Oh My Posh (prompt)
- **GPG + SSH agents** with macOS Keychain auto-unlock when available
- **kubectl** with krew plugins `ctx` and `ns` (aliases `kctx` / `kns`)
- **Classic CLI tools** (`htop`, `dig`, `nmap`, `jq`, `mtr`, …)
- **DeerHide agent skills** — all skills from [DeerHide/agent_skills](https://github.com/DeerHide/agent_skills) via `npx skills`
- **AI tooling** — [RTK](https://github.com/rtk-ai/rtk), [CodeGraph](https://github.com/colbymchenry/codegraph), [caveman](https://github.com/JuliusBrussee/caveman), [ponytail](https://github.com/dietrichgebert/ponytail) skills
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

- Oh My Posh config path (`omp_config`); the prompt itself lives in `ansible/roles/zsh/files/oh-my-posh.omp.toml`
- SSH key paths (`ssh_identities`)
- Optional GPG key id (`gpg_key_id`)
- CLI tool packages (`debian_cli_packages`, `homebrew_cli_packages`)
- DeerHide agent skills repo (`agent_skills_repo`)
- AI tooling repos and scripts (`caveman_skills_repo`, `ponytail_skills_repo`, `rtk_init_global`)
- macOS Homebrew casks (`homebrew_casks`)

## Supported platforms

| Platform | Package manager |
|----------|-----------------|
| macOS    | Homebrew        |
| Debian/Ubuntu | apt        |
