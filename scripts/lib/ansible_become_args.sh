#!/usr/bin/env bash
# macOS Touch ID sudo: sudo -v in the shell (Touch ID works), then ansible with
# become_flags=-H so become reuses the cached timestamp (default -H -S -n does not).

ansible_sudo_touchid_wanted() {
  local group_vars="${1:-ansible/group_vars/all.yml}"

  [[ "$(uname -s)" == "Darwin" ]] \
    && { [[ -f /usr/lib/pam/pam_tid.so ]] || [[ -f /usr/lib/pam/pam_tid.so.2 ]]; } \
    && ! grep -qE '^\s*sudo_touchid:\s*false' "$group_vars" 2>/dev/null
}

# Sets ANSIBLE_BECOME_PASSWORD_ARGS and ANSIBLE_BECOME_EXTRA_VARS for ansible-playbook.
ansible_prepare_become() {
  local group_vars="${1:-ansible/group_vars/all.yml}"

  ANSIBLE_BECOME_PASSWORD_ARGS=()
  ANSIBLE_BECOME_EXTRA_VARS=()

  if ! ansible_sudo_touchid_wanted "$group_vars"; then
    ANSIBLE_BECOME_PASSWORD_ARGS=(--ask-become-pass)
    return 0
  fi

  echo "Authenticate sudo (Touch ID or password) for this playbook run..."
  sudo -v || exit 1
  # ponytail: default become_flags (-H -S -n) ignores a fresh sudo timestamp on macOS
  ANSIBLE_BECOME_EXTRA_VARS=(-e ansible_become_flags=-H)
}
