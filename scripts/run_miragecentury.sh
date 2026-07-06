#!/usr/bin/env bash

source .venv/bin/activate
# shellcheck source=lib/ansible_become_args.sh
source "$(dirname "$0")/lib/ansible_become_args.sh"

ansible_prepare_become

ansible-playbook \
  ansible/miragecentury.yml \
  -u "${USER}" \
  "${ANSIBLE_BECOME_PASSWORD_ARGS[@]}" \
  "${ANSIBLE_BECOME_EXTRA_VARS[@]}" \
  "$@"
