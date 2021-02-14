SHELL := zsh

ZSHENV := .zshenv
ZPROFILE := .zprofile
ZSHRC := .zshrc
ZLOGIN := .zlogin
ZLOGOUT := .zlogout

.PHONY: all install uninstall clean

all: ${ZSHENV}.zwc ${ZPROFILE}.zwc ${ZSHRC}.zwc ${ZLOGIN}.zwc ${ZLOGOUT}.zwc

install: all
	echo -ne '[[ -n $${ZDOTDIR} ]] || export ZDOTDIR="$(subst ${HOME},$${HOME},${PWD})"\n[[ -f $${ZDOTDIR}/.zshenv ]] && . "$${ZDOTDIR}/.zshenv"' > ${HOME}/${ZSHENV}
	$(SHELL) -cf 'zcompile ${HOME}/${ZSHENV}'
	touch ${HOME}/${ZPROFILE}
	$(SHELL) -cf 'zcompile ${HOME}/${ZPROFILE}'
	touch ${HOME}/${ZSHRC}
	$(SHELL) -cf 'zcompile ${HOME}/${ZSHRC}'
	touch ${HOME}/${ZLOGIN}
	$(SHELL) -cf 'zcompile ${HOME}/${ZLOGIN}'
	touch ${HOME}/${ZLOGOUT}
	$(SHELL) -cf 'zcompile ${HOME}/${ZLOGOUT}'

uninstall:
	-$(RM) ${HOME}/${ZLOGOUT}.zwc ${HOME}/${ZLOGOUT}
	-$(RM) ${HOME}/${ZLOGIN}.zwc ${HOME}/${ZLOGIN}
	-$(RM) ${HOME}/${ZSHRC}.zwc ${HOME}/${ZSHRC}
	-$(RM) ${HOME}/${ZPROFILE}.zwc ${HOME}/${ZPROFILE}
	-$(RM) ${HOME}/${ZSHENV}.zwc ${HOME}/${ZSHENV}

clean:
	-$(RM) ${ZSHENV}.zwc ${ZPROFILE}.zwc ${ZSHRC}.zwc ${ZLOGIN}.zwc ${ZLOGOUT}.zwc

${ZSHENV}.zwc: ${ZSHENV}
	$(SHELL) -cf 'zcompile ${<}'

${ZPROFILE}.zwc: ${ZPROFILE}
	$(SHELL) -cf 'zcompile ${<}'

${ZSHRC}.zwc: ${ZSHRC}
	$(SHELL) -cf 'zcompile ${<}'

${ZLOGIN}.zwc: ${ZLOGIN}
	$(SHELL) -cf 'zcompile ${<}'

${ZLOGOUT}.zwc: ${ZLOGOUT}
	$(SHELL) -cf 'zcompile ${<}'
