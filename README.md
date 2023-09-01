# Playbook

## Clone
To clone and fetch submodules
```bash
git clone --recurse-submodules https://github.com/Nauticus/nauticus-playbook.git
```

After the task are done make note to update remotes to `git@github.com:Nauticus/nauticus-playbook.git`:
```bash
git remote set-url origin git@github.com:Nauticus/nauticus-playbook.git
```
Same applies to the `roles/neovim/files`

Update submodules
```bash
git submodule update --init
```

To run playbook
```bash
ansible-playbook -e ansible_user=$(whoami) local.yaml --ask-become-pass --ask-vault-pass
```

To run particular tag:
```bash
ansible-playbook -e ansible_user=$(whoami) local.yaml --ask-become-pass --ask-vault-pass --tags=*
```
