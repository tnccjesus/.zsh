() {
    [[ -f ${HOME}/.zprofile && ${HOME}/.zprofile != ${ZDOTDIR:-${HOME}}/.zprofile ]] && . "${HOME}/.zprofile"
}
