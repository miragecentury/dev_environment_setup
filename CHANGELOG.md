# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.5.0] - 2026-07-06

### Added

- secrets_tools role (`sops`, `age`, and `kubeseal` via Homebrew; `age` via apt and GitHub releases on Debian)
- helm in kubernetes role (Homebrew on macOS; get.helm.sh tarball on Debian)

## [1.4.0] - 2026-07-06

### Added

- mirrord role (Homebrew tap on macOS; install script on Debian)
- mongosh role (Homebrew on macOS; MongoDB apt repo on Debian)
- redis_tools role (`redis` via Homebrew; `redis-tools` via apt)
- cilium_tools role (`cilium-cli` via Homebrew; GitHub release on Debian)
- argocd_kargo_tools role (`argocd` and `kargo` via Homebrew; GitHub releases on Debian)
- miragecentury pre-clone playbook and `run_miragecentury.sh` for DeerHide / laelidona GitHub repos
- Touch ID sudo support on macOS via shared `ansible_become_args.sh` helper

### Changed

- SSH config uses a dedicated `Host github.com` block with `IdentitiesOnly`, `github_ssh_identity`, and port 443 via `ssh.github.com`

## [1.3.0] - 2026-07-06

### Added

- Python tooling role for Poetry, uv, and pre-commit (Homebrew on macOS; pipx + uv install script on Debian)
- Rust tooling role for rustup with stable toolchain (rustup install script on macOS and Debian)
- Angular tooling role for global frontend npm tools: Angular CLI, Vite, TypeScript, tsx, ESLint, and Prettier (after Node.js from agent_skills)

## [1.2.0] - 2026-07-06

### Added

- Zinit-based shell setup with a managed Oh My Posh prompt config
- Bash update tasks for macOS and Debian
- Classic CLI tools role (`htop`, `dig`, `nmap`, `jq`, `mtr`, and more)
- DeerHide agent skills install via `npx skills`
- AI tooling role for RTK, CodeGraph, caveman, and ponytail

### Changed

- Replaced Oh My Zsh with Zinit in the managed `.zshrc`
- Switched Oh My Posh from remote theme URL to a local config file

## [1.1.0] - 2026-07-06

### Added

- GitHub CLI (`gh`) installation for macOS and Debian

## [1.0.0] - 2026-07-06

### Added

- Cross-platform Ansible workstation setup for macOS and Debian

[Unreleased]: https://github.com/miragecentury/dev_environment_setup/compare/v1.5.0...HEAD
[1.5.0]: https://github.com/miragecentury/dev_environment_setup/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/miragecentury/dev_environment_setup/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/miragecentury/dev_environment_setup/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/miragecentury/dev_environment_setup/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/miragecentury/dev_environment_setup/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/miragecentury/dev_environment_setup/releases/tag/v1.0.0
