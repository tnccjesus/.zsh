() {
    [[ -f ${HOME}/.zlogin && ${HOME}/.zlogin != ${ZDOTDIR:-${HOME}}/.zlogin ]] && . "${HOME}/.zlogin"
}
