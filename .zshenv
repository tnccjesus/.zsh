() {
    typeset -gU CDPATH cdpath
    typeset -gU FIGNORE fignore
    typeset -gU FPATH fpath
    typeset -gU MAILPATH mailpath
    typeset -gU MANPATH manpath
    typeset -gU MODULE_PATH module_path
    typeset -gU PATH path
}

() {
    typeset -gTU INFOPATH infopath ':'
    typeset -gTU PKG_CONFIG_PATH pkg_config_path ':'
    typeset -gTU SUDO_PATH sudo_path ':'
    typeset -gTU XDG_CONFIG_DIRS xdg_config_dirs ':'
    typeset -gTU XDG_DATA_DIRS xdg_data_dirs ':'
}

() {
    export XDG_CACHE_HOME="${HOME}/.cache"
    export XDG_CONFIG_HOME="${HOME}/.config"
    export XDG_DATA_HOME="${HOME}/.local/share"
    [[ ${TERM_PROGRAM} == Apple_Terminal ]] && export SHELL_SESSIONS_DISABLE=1
}
