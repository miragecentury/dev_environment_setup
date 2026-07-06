#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

install_python() {
  case "$(uname -s)" in
    Darwin)
      if ! command -v brew >/dev/null 2>&1; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # ponytail: assumes default brew install path; user may need to add brew to PATH once
        if [[ -x /opt/homebrew/bin/brew ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -x /usr/local/bin/brew ]]; then
          eval "$(/usr/local/bin/brew shellenv)"
        fi
      fi
      brew install python3
      ;;
    Linux)
      sudo apt-get update
      sudo apt-get install -y python3 python3-pip python3-venv
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      exit 1
      ;;
  esac
}

install_python

if [[ -d .venv ]]; then
  echo "Removing existing virtual environment..."
  rm -rf .venv
fi
python3 -m venv .venv
source .venv/bin/activate

pip install ansible ansible-dev-tools pre-commit
ansible-galaxy collection install -r ansible/requirements.yml
pre-commit install

echo "Bootstrap complete. Run ./scripts/run_ansible.sh to configure your workstation."
