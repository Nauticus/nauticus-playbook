# Playbook

## Clone
To clone and fetch submodules
```bash
git clone --recurse-submodules git@github.com:Nauticus/nauticus-playbook.git
```

Update submodules
```bash
git submodule update --init
```

To run playbook
```bash
ansible-playbook -e ansible_user=$(whoami) local.yaml --ask-become-pass --ask-vault-pass
```

## Available roles
 - system - system defaults (macos)
 - homebrew - cli utilities and such
 - window_management - yabai and skhd
 - kitty - terminal emulator
 - zsh - setup zinit
 - tmux - tmux and tpm (and probably tmuxinator)
 - neovim - PDE
