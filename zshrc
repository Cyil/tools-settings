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
# 3. NVM（推荐方案）
# =====================================================================

export NVM_DIR="$HOME/.nvm"

# ----------------------------------------------------------
# 把当前最高版本 Node 的 bin 提前加入 PATH
#
# 作用：
#   node
#   npm
#   npx
#   codex
#   claude
#   vite
#   tsx
#   wrangler
#   ...
#
# 全部立即可用，不需要加载 nvm
# ----------------------------------------------------------

if [ -d "$NVM_DIR/versions/node" ]; then
    LATEST_NODE="$(ls -d "$NVM_DIR"/versions/node/* 2>/dev/null | sort -V | tail -n 1)"

    if [ -n "$LATEST_NODE" ]; then
        export PATH="$LATEST_NODE/bin:$PATH"
    fi
fi


# ----------------------------------------------------------
# nvm 懒加载
#
# 只有真正执行：
#
#     nvm install
#     nvm use
#     nvm ls
#
# 才加载 nvm.sh
# ----------------------------------------------------------

nvm() {
    unset -f nvm

    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

    [ -s "$NVM_DIR/bash_completion" ] && \
        source "$NVM_DIR/bash_completion"

    nvm "$@"
}

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
alias mconda='mv /home/jiy/workspace/miniconda3 /home/jiy/workspace/temp/miniconda3'
alias bconda='mv /home/jiy/workspace/temp/miniconda3 /home/jiy/workspace/miniconda3'

# 如果有独立的别名文件则加载
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# =====================================================================
# 6. 终端美化灵魂 (Starship 提示符)
# =====================================================================
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# OpenClaw Completion
[ -f "/home/jiy/.openclaw/completions/openclaw.zsh" ] && source "/home/jiy/.openclaw/completions/openclaw.zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jiy/workspace/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jiy/workspace/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jiy/workspace/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jiy/workspace/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export DEEPSEEK_API_KEY=sk-placeholder

# pnpm
export PNPM_HOME="/home/jiy/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
