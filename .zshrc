() {
    local dir
    for dir in "${XDG_CACHE_HOME:-${HOME}/.cache}" "${XDG_CONFIG_HOME:-${HOME}/.config}" "${XDG_DATA_HOME:-${HOME}/.local/share}"
    do
        [[ -d ${dir} ]] || mkdir -p "${dir}"
    done
}

() {
    ZINIT_HOME="${HOME}/.zinit"
    if [[ -f ${ZINIT_HOME:-${HOME}/.zinit}/bin/zinit.zsh ]] ; then
        . "${ZINIT_HOME:-${HOME}/.zinit}/bin/zinit.zsh"
    fi
    if [[ ${+functions[zinit]} == 1 ]] ; then
        export ZINIT_HOME
        autoload -U _zinit
        (( ${+_comps} )) && _comps[zinit]=_zinit
        zinit light-mode for zinit-zsh/z-a-patch-dl zinit-zsh/z-a-as-monitor zinit-zsh/z-a-bin-gem-node
        zinit ice blockf
        zinit ice wait'!0'; zinit light zsh-users/zsh-completions
    else
        unset ZINIT_HOME
    fi
}

() {
    autoload -Uz add-zsh-hook
}

() {
    setopt correct
    setopt ignoreeof
    setopt printeightbit
    unsetopt clobber
    unsetopt flowcontrol
    unsetopt notify
    bindkey -e
}

() {
    autoload -Uz colors; colors
}

() {
    autoload -Uz compinit
    compinit -u -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zcompdump"
    zstyle ':compinstall' filename "${ZDOTDIR:-${HOME}}/.zshrc"
    zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
    zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-${HOME}/.cache}/zcompcache"
    zstyle ':completion:*' ignore-parents parent pwd
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
    zstyle ':completion:*' use-cache on
    fignore=( .class .elc .o .pyc .zwc )
}

() {
    setopt autopushd
    setopt pushdignoredups
    DIRSTACKSIZE=128
}

() {
    HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zhistory"
    HISTSIZE=1024
    SAVEHIST=1048576
    setopt appendhistory
    setopt histignorealldups
    setopt histignoredups
    setopt histnostore
    setopt histreduceblanks
    setopt histverify
    setopt sharehistory
}

() {
    autoload -Uz promptinit
    if [[ ${+functions[promptinit]} == 1 ]] ; then
        promptinit
        prompt restore
    fi
    autoload -Uz vcs_info
    if [[ ${+functions[vcs_info]} == 1 ]] ; then
        add-zsh-hook precmd vcs_info
        setopt promptsubst
        zstyle ':vcs_info:*' actionformats '[%b|%a]'
        zstyle ':vcs_info:*' formats '[%b]'
        RPROMPT='${vcs_info_msg_0_:+${vcs_info_msg_0_}}'
        vcs_info
    fi
}

() {
    local -A x=(uid "$(id -u)" gid "$(id -g)" user "$(id -un)" group "$(id -gn)") 
    [[ ${x[uid]} != 0 && ${x[uid]} == ${x[gid]} && ${x[user]} == ${x[group]} ]] && umask 002 || umask 022
}

(){
    local dir prefix python
    unset HOMEBREW_SHELLENV_PREFIX
    export INFOPATH="/usr/share/info"
    export MANPATH="/usr/share/man"
    export PATH="/usr/bin:/usr/sbin:/bin:/sbin"
    prefix=/usr/local
    if [[ -x ${prefix}/bin/brew ]] ; then
        eval "$(${prefix}/bin/brew shellenv)"
    else
        if [[ -d ${prefix} ]] ; then
            export INFOPATH="${prefix}/share/info${INFOPATH:+:${INFOPATH}}"
            export MANPATH="${prefix}/share/man${MANPATH:+:${MANPATH}}"
            export PATH="${prefix}/bin:${prefix}/sbin${PATH:+:${PATH}}"
        fi
        if [[ ${+commands[brew]} == 0 ]] ; then
            case "${OSTYPE}" in
                darwin*)
                    if [[ ${CPUTYPE} == arm64 ]] ; then
                        dir=/opt/homebrew
                        [[ -x ${dir}/bin/brew ]] && commands[brew]="${dir}/bin/brew"
                    fi
                    ;;
                linux*)
                    for dir in /home/linuxbrew/.linuxbrew "${HOME}/.linuxbrew"
                    do
                        [[ -x ${dir}/bin/brew ]] && commands[brew]="${dir}/bin/brew" && break
                    done
                    ;;
            esac
        fi
        [[ ${+commands[brew]} == 1 ]] && eval "$(${commands[brew]} shellenv)"
    fi
    prefix="${HOME}/.local"
    if [[ -d ${prefix} ]] ; then
        export INFOPATH="${prefix}/share/info${INFOPATH:+:${INFOPATH}}"
        export MANPATH="${prefix}/share/man${MANPATH:+:${MANPATH}}"
        export PATH="${prefix}/bin${PATH:+:${PATH}}"
    fi
    if [[ ${+commands[go]} == 1 ]] ; then
        unset GOROOT GOPATH
        prefix="$(go env GOPATH 2> /dev/null)"
        [[ -n ${prefix} && ${PATH} != *${prefix}/bin* ]] && export PATH="${prefix}/bin${PATH:+:${PATH}}"
    fi
    for python in python2 python3
    do
        if [[ ${+commands[${python}]} == 1 ]] ; then
            prefix="$(${python} -m site --user-base 2> /dev/null)"
            [[ -n ${prefix} && ${PATH} != *${prefix}/bin* ]] && export PATH="${prefix}/bin${PATH:+:${PATH}}"
        fi
    done
    prefix="${HOMEBREW_PREFIX}"
    [[ -n ${prefix} && -d ${prefix}/opt/ruby/bin ]] && export PATH="${prefix}/opt/ruby/bin${PATH:+:${PATH}}"
    if [[ ${+commands[ruby]} == 1 && ${+commands[gem]} == 1 ]] ; then
        for dir in $(ruby -r rubygems -e 'puts Gem.default_dir; puts Gem.user_dir' 2> /dev/null)
        do
            [[ -n ${dir} && ${PATH} != *${dir}/bin* ]] && export PATH="${dir}/bin${PATH:+:${PATH}}"
        done
    fi
    [[ ${+commands[direnv]} == 1 ]] && eval "$(direnv hook zsh)"
    if [[ ${+commands[goenv]} == 1 ]] ; then
        prefix="$([[ ${+commands[go]} == 1 ]] && go env GOPATH 2> /dev/null)"
        [[ -n ${prefix} ]] && export GOENV_GOPATH_PREFIX="${prefix}"
        for dir in "${HOME}/.goenv" "${${HOMEBREW_PREFIX%%/homebrew}:-/usr/local}/goenv"
        do
            [[ -d ${dir} ]] && export GOENV_ROOT="${dir}" && break
        done
        [[ -d ${GOENV_ROOT}/shims && ${PATH} != *${GOENV_ROOT}/shims* ]] && export PATH="${GOENV_ROOT}/shims${PATH:+:${PATH}}"
        function goenv() { unfunction ${0}; . <(${0} init -); ${0} "${@}" }
    fi
    if [[ ${+commands[nodenv]} == 1 ]] ; then
        for dir in "${HOME}/.nodenv" "${${HOMEBREW_PREFIX%%/homebrew}:-/usr/local}/nodenv"
        do
            [[ -d ${dir} ]] && export NODENV_ROOT="${dir}" && break
        done
        [[ -d ${NODENV_ROOT}/shims && ${PATH} != *${NODENV_ROOT}/shims* ]] && export PATH="${NODENV_ROOT}/shims${PATH:+:${PATH}}"
        function nodenv() { unfunction ${0}; . <(${0} init -); ${0} "${@}" }
    fi
    if [[ ${+commands[phpenv]} == 1 ]] ; then
        for dir in "${HOME}/.phpenv" "${${HOMEBREW_PREFIX%%/homebrew}:-/usr/local}/phpenv"
        do
            [[ -d ${dir} ]] && export PHPENV_ROOT="${dir}" && break
        done
        [[ -d ${PHPENV_ROOT}/shims && ${PATH} != *${PHPENV_ROOT}/shims* ]] && export PATH="${PHPENV_ROOT}/shims${PATH:+:${PATH}}"
        function phpenv() { unfunction ${0}; . <(${0} init -); ${0} "${@}" }
    fi
    if [[ ${+commands[pyenv]} == 1 ]] ; then
        for dir in "${HOME}/.pyenv" "${${HOMEBREW_PREFIX%%/homebrew}:-/usr/local}/pyenv"
        do
            [[ -d ${dir} ]] && export PYENV_ROOT="${dir}" && break
        done
        [[ -d ${PYENV_ROOT}/shims && ${PATH} != *${PYENV_ROOT}/shims* ]] && export PATH="${PYENV_ROOT}/shims${PATH:+:${PATH}}"
        function pyenv() { unfunction ${0}; . <(${0} init -); ${0} "${@}" }
    fi
    if [[ ${+commands[rbenv]} == 1 ]] ; then
        for dir in "${HOME}/.rbenv" "${${HOMEBREW_PREFIX%%/homebrew}:-/usr/local}/rbenv"
        do
            [[ -d ${dir} ]] && export RBENV_ROOT="${dir}" && break
        done
        [[ -d ${RBENV_ROOT}/shims && ${PATH} != *${RBENV_ROOT}/shims* ]] && export PATH="${RBENV_ROOT}/shims${PATH:+:${PATH}}"
        function rbenv() { unfunction ${0}; . <(${0} init -); ${0} "${@}" }
    fi
    if [[ ${+commands[swiftenv]} == 1 ]] ; then
        for dir in "${HOME}/.swiftenv" "${${HOMEBREW_PREFIX%%/homebrew}:-/usr/local}/swiftenv"
        do
            [[ -d ${dir} ]] && export SWIFTENV_ROOT="${dir}" && break
        done
        function swiftenv() { unfunction ${0}; . <(${0} init -); ${0} "${@}" }
    fi
    for dir in "${HOME}/.local/google-cloud-sdk" "${HOME}/google-cloud-sdk" "${${HOMEBREW_PREFIX%%/homebrew}:-/usr/local}/google-cloud-sdk" "${HOMEBREW_PREFIX:-/usr/local}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
    do
        [[ -f ${dir}/path.zsh.inc ]] && . "${dir}/path.zsh.inc" && break
    done
    for dir in "${HOME}/.local/google-cloud-sdk" "${HOME}/google-cloud-sdk" "${${HOMEBREW_PREFIX%%/homebrew}:-/usr/local}/google-cloud-sdk" "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" /usr/share/google-cloud-sdk "${HOME}/snap/google-cloud-sdk/current" /snap/google-cloud-sdk/current
    do
        [[ -f ${dir}/completion.zsh.inc ]] && . "${dir}/completion.zsh.inc" && break
    done
    if [[ ${+commands[gcloud]} == 1  ]] ; then
        function _cloudsdk_precmd_hook() {
            local command=python
            if [[ ${+commands[pyenv]} == 0 || $(pyenv version-name) == system ]] ; then
                if [[ ${+commands[python3]} == 1 ]] ; then
                    command=python3
                elif [[ ${+commands[python2]} == 1 ]] ; then
                    command=python2
                fi
            fi
            export CLOUDSDK_PYTHON="${command}"
        }
        add-zsh-hook precmd _cloudsdk_precmd_hook
    fi
    for dir in "${HOME}/.local" /usr/local
    do
        if [[ -d ${dir} && -d ${dir}/depot_tools ]] ; then
            export PATH="${dir}/depot_tools${PATH:+:${PATH}}"
            fpath=("${dir}/depot_tools/zsh-goodies" $fpath)
            autoload -Uz _gclient
            break
        fi
    done
}

() {
    function restart() {
        [[ $options[login] == on ]] && exec "${SHELL}" -l || exec "${SHELL}"
    }
}

() {
    [[ -d ${XDG_CONFIG_HOME:-${HOME}/.config}/dict ]] || mkdir -p "${XDG_CONFIG_HOME:-${HOME}/.config}/dict"
    alias dict="dict -c ${XDG_CONFIG_HOME:-${HOME}/.config}/dict/dictrc"
    alias mkdir='mkdir -p'
    case "${OSTYPE}" in
        darwin*) alias ls='ls -FG' ;;
        linux*) alias ls='ls -F --color=auto' ;;
    esac
}

() {
    if [[ -f ${HOME}/.zshrc && ${HOME}/.zshrc != ${ZDOTDIR:-${HOME}}/.zshrc ]] ; then
        . "${HOME}/.zshrc"
    fi
}
