# What is this?
a bundle of aliases/functions wrapping some commonly used/useful git command using some humanize,directviewing name

# How to use?
1. `git clone git@github.com:rainchen/git-cmd-helpers.git`
2. edit `~/.bash_profile`, append:
    `for f in ~/git-cmd-helpers/*.sh; do source $f; done`
3. reload the bash_profile: `source ~/.bash_profile` or open new terminal window

# Summary for each file
* `git-aliases.sh`: some `alias` wrapping some commonly used/useful git command using humanize,directviewing name
* `git-functions.sh`: commands wrapping using `function`, support arguments
* `github-functions.sh`: some shortcuts for accessing github.com

# Other popular git helpers

* `git-autocomplete`: this is a *MUST INSTALL* helper, bash-completion contains git-autocomplete, install: `brew install bash-completion`

* [hub](https://hub.github.com/): hub is a command-line wrapper for git that makes you better at GitHub.

* [github-gem](https://github.com/defunkt/github-gem): `github` command line helper for simplifying your GitHub experience. 
