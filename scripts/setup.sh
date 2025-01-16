#!/usr/bin/env bash

# Install the minimal set of packages required to run the application
sudo apt-get install -y python3 python3-pip python3-venv

# Install the required packages for the system
pip3 install --user pre-commit

# Create a virtual environment
if [[ -d .venv ]]; then
    echo "Removing existing virtual environment..."
    rm -rf .venv
fi
python3 -m venv .venv

# Activate the virtual environment
source .venv/bin/activate

# Install the required packages
pip install ansible ansible-dev-tools pre-commit

# Install the pre-commit hooks
pre-commit install
