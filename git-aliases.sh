# here are some alias wrapping some commonly used/useful git command using humanize,directviewing name

# ==== for git clone ====
# copy only the latest revision in the repository, userful for trying opensource project
alias git-shallow-clone='git clone --depth 1'
# to backfill history: git pull --unshallow

# fetch and rebase all locally-tracked remote branches
alias git-up='git pull --rebase --autostash'
# add an git alias: `git up`
alias git-up-alias='git config --global alias.up "pull --rebase --autostash"'

# ==== for git branch ====
alias gb='git branch'
alias gbv='git branch -v'
alias gbr='git branch -r'

alias git-current-branch='git rev-parse --abbrev-ref HEAD'
# In Git 1.8.1 you can use the git symbolic-ref command with the "--short" option:
# alias git-current-branch='git symbolic-ref --short HEAD'

# usage: git-delete-remote-branch the_remote_branch_name
alias git-delete-remote-branch='git push origin --delete'

# http://stackoverflow.com/questions/6127328/how-can-i-delete-all-git-branches-which-are-already-merged
# To delete all branches that are already merged into the currently checked out branch(skip master and develop):
alias git-delete-remote-branches-merged-into-current='git branch --merged | grep -v "\*" | grep -v master | grep -v develop | xargs -n 1 git branch -d'
alias git-delete-local-branches-deleted-from-remote="git fetch --all -p; git branch -vv | grep ': gone]' | awk '{ print \$1 }' | xargs -n 1 git branch -d"

# show all remote branches that have already been merged into master
alias git-remote-branches-merged='git branch -r --merged'

# Using git-sweep you can safely remove remote branches that have been merged into master.
# https://github.com/arc90/git-sweep
# install: pip install git-sweep || easy_install git-sweep
# $ git-sweep cleanup
# after clean up, Tell everyone to run `git fetch --prune` to sync with this remote.
alias git-delete-remote-branches-mereged-into-master='git-sweep cleanup --skip develop'
alias git-delete-remote-branches-mereged-into-develop='git-sweep cleanup --master develop --skip master'

# git branch -m <oldname> <newname>
# If you want to rename the current branch, you can simply do:
# git branch -m <newname>
alias git-branch-rename-to='git branch -m '

# show all remote branches, with branch name, commit date, author name, commit id, commit message
alias git-branch-list-remote="git for-each-ref --format='%(refname:short)|%(committerdate:short) (%(committerdate:relative))|%(authorname)|%(objectname:short)|%(contents:subject)' --sort=committerdate refs/remotes/ | column -t -s '|'"

# show all local branches, with branch name, commit date, author name, commit id, commit message
alias git-branch-list-local="git for-each-ref --format='%(refname:short)|%(committerdate:short) (%(committerdate:relative))|%(authorname)|%(objectname:short)|%(contents:subject)' --sort=committerdate refs/heads/ | column -t -s '|'"


# ==== for git log ====
# git log graph
# more tips: http://book.git-scm.com/3_reviewing_history_-_git_log.html
alias glg="git log --pretty=format:'%h : %s' --topo-order --graph"

# show git last log
alias gll='git log -n 1'

alias git-log-for-author='eval "git log --author=\"`git-author`\""'
alias git-log-oneline='git log --pretty=oneline'
alias git-log-graph='git log --graph --decorate'

alias git-log-last='git log -n 1'
alias git-log-first='git log --pretty=format:%H|tail -1 | xargs git log'

# shows commits from start.
alias git-log-reverse="git log --reverse"

# display git log with browser at http://localhost:1234
alias git-log-webview='git instaweb --local --httpd=webrick'
alias git-log-webview-stop='git instaweb --stop'

alias git-log-treeview='git log --graph --oneline --all'
alias git-log-treeview-pretty="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# In case you were curious what the different options were: %h = abbreviated commit hash, %x09 = tab (character for code 9), %an = author name, %ad = author date (format respects --date= option), %s = subject. From kernel.org/pub/software/scm/git/docs/git-log.html (PRETTY FORMATS section)
# alias git-log-listview="git log --pretty=format:'%C(yellow)%h|%Cred%ad|%Cblue%an|%Cgreen%d %Creset%s' --date=short | column -ts'|' | less -r"
# https://stackoverflow.com/a/9463536/130353
alias git-log-listview="git log --pretty=format:'%C(auto,yellow)%h%C(auto,magenta) %C(auto,blue)%>(12,trunc)%ad %C(auto,green)%<(12,trunc)%aN%C(auto,reset)%s%C(auto,red)% gD% D' --date=short"

# this is useful for writting changes logs
# e.g.: git-log-listview-no-merges v0.1..v0.2 --author="MyName"
alias git-log-listview-no-merges="git-log-listview --no-merges"

# show commit messages(in reverse order) in current branch
# useful for writing changes in a PR
# alias git-changes-in-current-branch="git log --reverse --pretty=format:'%s' $(git merge-base master HEAD)..HEAD"
alias git-changes-in-current-branch="git merge-base master HEAD | xargs -I @ git log --reverse --pretty=format:'%s' @..HEAD"
alias git-changes-in-current-branch-v="git cherry -v master"

# ==== for git status ====
alias gs='git status'
alias gits='git status'




# ==== for git checkout ====
alias git-update-develop='git checkout develop; git pull'
alias git-update-master='git checkout master ; git pull'
alias git-checkout-develop='git checkout develop'
alias git-checkout-master='git checkout master'

# create and switch to a new branch
alias git-checkout-b='git checkout -b'
# tips: create a local branch from remote
# git checkout -b test origin/test

alias git-checkout-deleted='git ls-files -d | xargs git checkout'

# discard all your modified files
alias git-discard-modified='git ls-files -m | xargs git checkout --'


# ==== for git remote config ====
# http://www.git-scm.com/docs/git-remote
# http://stackoverflow.com/questions/4089430/how-can-i-determine-the-url-that-a-local-git-repo-was-originally-cloned-from/16880000#16880000
alias git-remote-url='git ls-remote --get-url'
alias git-config-get-remote-origin-url='git config --get remote.origin.url'
alias git-config-set-remote-origin-url='echo old remote.origin.url:; git config remote.origin.url; git remote set-url origin'




# ==== for git rm ====
alias git-rm-cached='git rm --cached'




# ==== for git pull/push ====
alias git-pull='git pull'
alias gitpull='git pull'
alias git-push='git push'
alias gitpush='git push'

alias git-push-develop='git checkout develop;git push;'
alias git-pull-master='git checkout master; git pull;'




# ==== for git commit ====
alias git-last-commit-id='git rev-parse --short HEAD'
# a longer version
# alias git-last-commit-id='git log -1 --pretty=oneline --abbrev-commit|cut -c1-7'
alias git-last-commit-id='git rev-parse HEAD'
alias git-last-commit-id-short='git rev-parse --short HEAD'

alias git-last-commit-message='git log -1 --pretty=%B'

alias git-commits-count="git rev-list HEAD | wc -l | awk '{print \$1}'"

# http://stackoverflow.com/questions/927358/git-undo-last-commit
# Git undo last commit
alias git-undo-last-commit='git reset --soft HEAD^'

# commits per author
# how many commits you’ve contributed to a project
# http://gitready.com/intermediate/2009/01/22/count-your-commits.html
alias git-commits-top='git shortlog -s -n'

# Show number of commits by developer
# http://zanshin.net/2012/06/08/showing-git-commit-counts/
alias git-commits-list="git shortlog | grep -E '^[^ ]'"

alias git-commits-first="git log --pretty=oneline --reverse | head -1"
alias git-commits-last="git log -1"
alias git-commits-last-time="git log -1 --format=%cd"




# ==== for git diff ====
alias git-diff-cached='git diff --cached'

# some tips
# All new files not yet committed
alias git-diff-new-files-tobecommitted='git diff --name-only --diff-filter=A HEAD'
# 'git diff --name-only --diff-filter=A --cached' # All new files in the index
# 'git diff --name-only --diff-filter=A' # All files that are not staged



# ==== for Untracked files ====
alias git-list-untracked-files='git ls-files -o --exclude-standard'
alias git-list-staged-untracked-files='git diff --name-only --diff-filter=A HEAD'
alias git-add-untracked-files='git add `git ls-files -o --exclude-standard`; git status'
alias git-del-untracked-files='del `git ls-files -o --exclude-standard`; git status'
alias git-unstage-untracked-files='git reset HEAD `git diff --name-only --diff-filter=A HEAD`; git status'
# http://stackoverflow.com/questions/3801321/git-list-only-untracked-files-also-custom-commands
# NOTICE: this will also delete files marked in .gitignore, e.g.: config/database.yml
# NOT RECOMMEND TO USE
# alias git-clear-untracked-files='git clean -df'




# ==== for git flow ====
# brew install git-flow
# https://github.com/nvie/gitflow/wiki/Mac-OS-X
alias git-flow-cheatsheet='open https://danielkummer.github.io/git-flow-cheatsheet/'
alias git-flow-init-push='git flow init;git push -u origin develop;'




# ==== for git patch ====
# alias git-patch-build='git diff --no-prefix > patchfile.diff; ls patchfile.diff'
# show the changes which have been staged?
alias git-build-patch='git diff --cached --no-prefix > patchfile.diff; ls patchfile.diff'

# usage: $ git-apply-patch ../vendors/local_production_patch.diff
alias git-apply-patch='patch -p0 <'

# Generate a git patch(with committing info) for a specific commit
# usage: git-build-patch-for <sha>
alias git-build-patch-for='git format-patch -1'
# apply patch(with committing info)
# usage: git-apply-patch-from 0001-fix-bug.patch
alias git-apply-patch-from='git am <'



# ==== for git tag ====
# list tags
alias git-tag='git tag'
alias git-tag-ref='git show-ref --tags'
alias git-tag-verbose='git log --oneline --decorate --tags --no-walk'
alias git-tag-with-message='git tag -n1'
# delete all local tags and fetch from remote
alias git-tag-reset-with-remote='git tag -l | xargs git tag -d;git fetch --tags'
# delete local tags deleted from remote
alias git-tag-prune='git fetch --prune origin "+refs/tags/*:refs/tags/*"'
alias git-tag-push-all='git push --tags'

# get latest tag
alias git-tag-latest-commit-id='git rev-list --tags --max-count=1'
# get latest tag name (Notes: This command returns the "newest" tag even this tag is on another branch)
alias git-tag-latest='git-tag-latest-commit-id | xargs git describe --tags'
alias git-tag-latest-verbose='git-tag-latest-commit-id | xargs git log --oneline --decorate --no-walk'
alias git-tag-latest-checkout='git-tag-latest-verbose; git-tag-latest | xargs -I @ git checkout tags/@ -b @'

# tips for adding new tag
# $ git tag -a v1.2 -m 'tag: v1.2'
# $ git push origin v1.2

# tips for editing a tag
# How do I edit an existing tag message in git?
# refs: https://stackoverflow.com/questions/7813194/how-do-i-edit-an-existing-tag-message-in-git
# git tag <tag name> <tag name>^{} -f -m "<new message>"
# .e.g.:
# git tag v0.1.0 v0.1.0^{} -f -m "tag: v0.1.0"
# or using:
# git tag <tag name> <tag name> -f -a
# This will open an editor with the contents of your old tag message.

# tips for deleting a tag
# If you have a tag named '12345' then you would just do this:
# git tag -d 12345 # delete from local
# git push origin :refs/tags/12345 # delete from remote




# ==== for git reset ====
# http://stackoverflow.com/questions/1616957/how-do-you-roll-back-reset-a-git-repository-to-a-particular-commit
# git reset --hard <tag/branch/commit id>
alias git-revert-to='git reset --hard '


# tips for how to cancel a remote commit
# useful for changing commit message or other
#   1. git-cancel-commit
#   2. git-push-force
alias 'git-cancel-commit'='git reset --soft HEAD~1' # cancel last commit
alias 'git-push-force'='git push origin HEAD --force' # force to push to remote




# ==== with vendor tools ====


## ==== gitx helper for mac ====
alias gitx-quit="killall GitX"
alias gitx="open /Applications/GitX.app -n"
alias gitx.="open /Applications/GitX.app ."


## ==== for PlistBuddy ====
# alias update-plist-version-with-git-last-commit='/usr/libexec/PlistBuddy -c "Set :BuildRevision `git log -1 --pretty=oneline --abbrev-commit|cut -c1-7`" ${TARGET_BUILD_DIR}/${INFOPLIST_PATH}'


## ==== for gitstats ====
# [DEPRECATED] keep for reference only
# gitstats is a statistics generator for git repositories. Currently it produces only HTML output with tables and graphs.
# git://repo.or.cz/gitstats.git
# usage: $ git-stats <path> <output-folder>
# Requirement 'gnuplot': $ brew install gnuplot
# demo: http://gitstats.sourceforge.net/examples/gitstats/
# alias git-stats="gitstats . git-stats"

# GitStats is a git repository statistics generator. It browses the repository and outputs html page with statistics.
# https://github.com/tomgi/git_stats
# demo: http://tomgi.github.io/git_stats/examples/rails/general.html
# install git_stats: gem install git_stats
# git_stats usage:
# $ git_stats generate
# $ open git_stats/index.html
alias git-stats='git_stats generate;open git_stats/index.html'


## ==== for resolving conflicts ====

# Resolve Git merge conflicts in favor of their changes during a pull
alias git-pull-using-theirs='git pull -s recursive -X theirs'

# Resolve Git merge conflicts in favor of their changes
# e.g.: git-merge-using-theirs other_branch
alias git-merge-using-theirs='git merge -X theirs'


## ==== for stash ====
# This command will create a stash with ALL of your changes (staged and unstaged), but will leave the staged changes in your working directory (still in state staged).
alias git-stash-unstaged='git stash --keep-index'


## ==== for gitignore config ====

# For more on global gitignores: https://help.github.com/articles/ignoring-files/#create-a-global-gitignore
# $ git config --global core.excludesfile ~/.gitignore_global

alias gitignore-for-macos='curl https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore -o macOS.gitignore; ls -lah macOS.gitignore'
