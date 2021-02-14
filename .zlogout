() {
    [[ -f ${HOME}/.zlogout && ${HOME}/.zlogout != ${ZDOTDIR:-${HOME}}/.zlogout ]] && . "${HOME}/.zlogout"
}
