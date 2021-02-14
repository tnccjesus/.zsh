# Changelog - ~/.zsh

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- Considering use in macOS and Linux, consideration not to break the design concept of the OS distribution
- Considering not to put dynamic files in the repository (Shell state saving for Apple_Terminal is disabled)
- Assuming use of [zinit](https://zdharma.org/zinit/wiki/)
- Assuming use of [Homebrew](https://brew.sh/)
- Assuming use of [syndbg/goenv](https://github.com/syndbg/goenv), [nodenv/nodenv](https://github.com/nodenv/nodenv), [phpenv/phpenv](https://github.com/phpenv/phpenv), [pyenv/pyenv](https://github.com/pyenv/pyenv), [rbenv/rbenv](https://github.com/rbenv/rbenv), [kylef/swiftenv](https://github.com/kylef/swiftenv)
- Dynamically set ZDOTDIR based on the relative relationship between home directory and ZDOTDIR
- Compliant with XDG Base Directory Specification
