# Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Plugins
# POWERLEVEL10K
zinit ice depth=1 atload"!source ~/.p10k.zsh"
zinit light romkatv/powerlevel10k

export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# FZF
_zsh_fzf_find_parent_dir() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf --reverse --height=20% --prompt=">")
  if [[ -z "${DIR}" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line
  BUFFER="builtin cd -- ${DIR}"
  zle accept-line
  local ret=$?
  zle reset-prompt
  return $ret
}

__fzf_atload() {
    export FZF_DEFAULT_OPTS=" \
        --color=bg+:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,gutter:-1 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

    export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --hidden --no-ignore-vcs --type=d --max-depth 3 --exclude='**/.git/**'"

    zle -N _zsh_fzf_find_parent_dir
    bindkey -M vicmd '\eg' _zsh_fzf_find_parent_dir
    bindkey -M viins '\eg' _zsh_fzf_find_parent_dir

}
zinit ice lucid wait'0b' from"gh-r" atinit"__fzf_atload" as"program"
zinit light junegunn/fzf
# FZF BYNARY AND TMUX HELPER SCRIPT
zinit ice lucid wait'0c' as"command" pick"bin/fzf-tmux"
zinit light junegunn/fzf
# BIND MULTIPLE WIDGETS USING FZF
zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf

# FZF-TAB
__fzf_tab_atload() {
    # set fzf-bindings
    zstyle ':fzf-tab:*' fzf-bindings 'tab:toggle+select,btab:deselect,ctrl-d:preview-page-down,ctrl-u:preview-page-up'
    zstyle ':fzf-tab:*' fzf-flags --height 95%
    zstyle ':fzf-tab:*' switch-group ',' '.'
    zstyle ':fzf-tab:*' prefix ''
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:complete:*:options' sort false
    zstyle ':completion:*:git-*:*' sort false
    zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git show --color=always $word'
    zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word'
    zstyle ':fzf-tab:complete:git-stash-(apply|pop|show):*' fzf-preview 'git stash show --color -p $word'
    zstyle ':fzf-tab:complete:(cd|ls|exa|bat|cat|vim|nvim):*' fzf-preview 'ls -1 --color=always $realpath'
}
zinit ice wait"1" lucid atload'__fzf_tab_atload' atinit"zicompinit;zicdreplay"
zinit light Aloxaf/fzf-tab

# ZSH-SYNTAX-HIGHLIGHTING
zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# FNM - Fast Node Manager
zinit wait lucid for \
    as'completion' \
    atclone"./fnm completions --shell zsh > _fnm.zsh" \
    atload'eval $(fnm env --shell zsh)' \
    atpull'%atclone' \
    blockf \
    from'gh-r' \
    nocompile \
    sbin'fnm' \
  @Schniz/fnm

alias mux=tmuxinator
alias vim=nvim
alias nvm=fnm

export EDITOR=nvim
export PATH=${PATH}:$HOME/bin
