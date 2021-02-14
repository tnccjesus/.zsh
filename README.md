# ~/.zsh - A zsh configuration

## Features

- Considering use in macOS and Linux, consideration not to break the design concept of the OS distribution
- Considering not to put dynamic files in the repository (Shell state saving for Apple_Terminal is disabled)
- Assuming use of [zinit](https://zdharma.org/zinit/wiki/)
- Assuming use of [Homebrew](https://brew.sh/)
- Assuming use of [syndbg/goenv](https://github.com/syndbg/goenv), [nodenv/nodenv](https://github.com/nodenv/nodenv), [phpenv/phpenv](https://github.com/phpenv/phpenv), [pyenv/pyenv](https://github.com/pyenv/pyenv), [rbenv/rbenv](https://github.com/rbenv/rbenv), [kylef/swiftenv](https://github.com/kylef/swiftenv)
- Dynamically set ZDOTDIR based on the relative relationship between home directory and ZDOTDIR
- Compliant with XDG Base Directory Specification

## Requirement

- [zsh](https://www.zsh.org/) >= 5.0
- [GNU make](https://www.gnu.org/software/make/) >= 3.8

## Installation

```zsh:-
git clone https://github.com/h12o/.zsh.git ~/.zsh
cd ~/.zsh && make
```

If you can set ZDOTDIR in /etc/zshenv, write it,

```zsh:/etc/zshenv
export ZDOTDIR="${HOME}/.zsh"
```

otherwise you should do `make install` additionally,

```zsh:-
cd ~/.zsh && make install
```

Then ~/.zshenv, ~/.zprofile, ~/.zshrc, ~/.zlogin and ~/.zlogout will be generated and ~/.zshenv will set the correct ZDOTDIR.

## Authors

- Hidetomo Hosono - Initial work - [h12o](https://github.com/h12o)

## License

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/) - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgements

- Authors of [The Z Shell Manual](http://zsh.sourceforge.net/Doc/Release/index.html)
- Authors of Shell Script Advent Calendars
  - [Shell Script Advent Calendar 2019](https://qiita.com/advent-calendar/2019/shellscript)
  - [Shell Script Advent Calendar 2018](https://qiita.com/advent-calendar/2018/shellscript)
  - [Shell Script Advent Calendar 2017](https://qiita.com/advent-calendar/2017/shellscript)
  - [Shell Script Advent Calendar 2016](https://qiita.com/advent-calendar/2016/shell-script)
  - [Shell Script Advent Calendar 2015](https://qiita.com/advent-calendar/2015/shell-script)
- Authors of zsh Advent Calendars
  - [zsh Advent Calendar 2014](https://qiita.com/advent-calendar/2014/zsh)
  - [zsh Advent Calendar 2013](https://qiita.com/advent-calendar/2013/zsh)
  - [zsh Advent Calendar 2012](https://qiita.com/advent-calendar/2012/zsh)
- Authors of [XDG Base Directory - ArchWiki](https://wiki.archlinux.jp/index.php/XDG_Base_Directory)
- Authors of [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/)
- @Suzuki09, the author of [〇〇envのせいでzshの起動が遅いからチューニングした](https://qiita.com/Suzuki09/items/6c27a8a875cf94d981a4)
- Fumiyasu Sato, The author of [拡張 POSIX シェルスクリプト Advent Calendar 2013](https://adventar.org/calendars/212)
- Matt Briggs, the author of "[.zsh by mbriggs](http://mattbriggs.net/.zsh/)"
- Wataru NOGUCHI, the author of [.gitignore collections](https://gist.github.com/wnoguchi/36cc49a9590cbec4aba3)
- y-kishibata, the author of [y-kishibata/dotfiles](https://github.com/y-kishibata/dotfiles/blob/master/.zshrc)
