#!/bin/bash
# Based on Ansible docs: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#selecting-an-ansible-package-and-version-to-install
apt update
apt -y install pipx
pipx ensurepath
pipx install --include-deps ansible
