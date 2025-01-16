#!/usr/bin/env bash

source .venv/bin/activate

ansible-playbook \
  ansible/playbook.yml \
  -u ${USER} \
  --ask-become-pass
