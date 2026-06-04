# =====================================================================
# 1. Oh My Zsh 核心框架配置
# =====================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# =====================================================================
# 2. 核心环境变量
# =====================================================================
export NVM_DIR="$HOME/.nvm"

# CUDA 12.8 路径
export PATH=/usr/local/cuda-12.8/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH

# Neovim 路径
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# Zoxide 优化
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# 本地环境与 Cargo 环境
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# =====================================================================
# 3. NVM 【全自动、无感懒加载方案】
# =====================================================================
if [ -s "$NVM_DIR/nvm.sh" ]; then
    local current_bin
    current_bin=$(node -e "console.log(process.execPath)" 2>/dev/null | sed 's/\/node$//')
    
    if [ -z "$current_bin" ] && [ -d "$NVM_DIR/versions/node" ]; then
        current_bin=$(ls -d $NVM_DIR/versions/node/* 2>/dev/null | tail -n 1)/bin
    fi

    _load_nvm() {
        for cmd in nvm node npm npx yarn claude hexo pm2 pnpm ${_nvm_auto_cmds[@]}; do
            unset -f "$cmd" 2>/dev/null
        done
        . "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    }

    local -a _nvm_auto_cmds
    _nvm_auto_cmds=(nvm node npm npx yarn claude)

    if [ -d "$current_bin" ]; then
        for binary in $(ls "$current_bin"); do
            _nvm_auto_cmds+=("$binary")
        done
    fi

    for cmd in ${(u)_nvm_auto_cmds}; do
        eval "$cmd() { _load_nvm; \$0 \"\$@\"; }"
    done
fi

# =====================================================================
# 4. 开发工具链与其他优化
# =====================================================================
brew() {
    unset -f brew
    if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    brew "$@"
}

# =====================================================================
# 5. 别名系统
# =====================================================================
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'
alias clz='clear'
alias py='python' 

alias update='sudo apt update && sudo apt upgrade'
alias y='yazi'
alias c='code .'
alias t='trae-cn .'
alias api='apifox'

# 如果有独立的别名文件则加载
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# =====================================================================
# 6. 灵魂
# =====================================================================
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi
