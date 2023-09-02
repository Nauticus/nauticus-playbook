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
zinit ice depth=1 atload"!source ~/.p10k.zsh"; zinit light romkatv/powerlevel10k
export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Load zsh-autosuggestions
_zsh_autosuggest_atload() {
    _zsh_autosuggest_start
    bindkey -M viins "^y" autosuggest-accept
}

# FZF
zinit ice lucid wait'0b' from"gh-r" as"program"
zinit light junegunn/fzf
# FZF BYNARY AND TMUX HELPER SCRIPT
zinit ice lucid wait'0c' as"command" pick"bin/fzf-tmux"
zinit light junegunn/fzf
# BIND MULTIPLE WIDGETS USING FZF
zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf
# FZF-TAB
zinit ice wait"1" lucid atinit"zicompinit;zicdreplay"
zinit light Aloxaf/fzf-tab

# ZSH-SYNTAX-HIGHLIGHTING
zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload'_zsh_autosuggest_atload' \
    atinit"ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=\"fg=8\"" \
        zsh-users/zsh-autosuggestions \
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

export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --hidden --no-ignore-vcs --type=d --exclude='**/.git/**'"
