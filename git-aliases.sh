# here are some alias wrapping some commonly used/useful git command using humanize,directviewing name

# ==== for git branch ====
alias gb='git branch'
alias gbv='git branch -v'
alias gbr='git branch -r'

alias git-current-branch='git rev-parse --abbrev-ref HEAD'
# In Git 1.8.1 you can use the git symbolic-ref command with the "--short" option:
# alias git-current-branch='git symbolic-ref --short HEAD'

# http://stackoverflow.com/questions/6127328/how-can-i-delete-all-git-branches-which-are-already-merged
# To delete all branches that are already merged into the currently checked out branch(skip master and develop):
alias git-delete-remote-branches-merged-into-current='git branch --merged | grep -v "\*" | grep -v master | grep -v develop | xargs -n 1 git branch -d'
alias git-delete-local-branches-deleted-from-remote='git fetch --prune'

# show all remote branches that have already been merged into master
alias git-remote-branches-merged='git branch -r --merged'

# Using git-sweep you can safely remove remote branches that have been merged into master.
# https://github.com/arc90/git-sweep
# sudo easy_install git-sweep
# $ git-sweep cleanup
# after clean up, Tell everyone to run `git fetch --prune` to sync with this remote.
alias git-delete-remote-branches-mereged-into-master='git-sweep cleanup --skip develop'
alias git-delete-remote-branches-mereged-into-develop='git-sweep cleanup --master develop --skip master'

# git branch -m <oldname> <newname>
# If you want to rename the current branch, you can simply do:
# git branch -m <newname>
alias git-branch-rename-to='git branch -m '



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
alias git-log-first='git log $(git log --pretty=format:%H|tail -1)'

# shows commits from start.
alias git-log-reverse="git log --reverse"




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




# ==== for git remote config ====
# http://www.git-scm.com/docs/git-remote
# http://stackoverflow.com/questions/4089430/how-can-i-determine-the-url-that-a-local-git-repo-was-originally-cloned-from/16880000#16880000
alias git-remote-url='git ls-remote --get-url'
alias git-config-get-remote-origin-url='git config --get remote.origin.url'




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
alias git-last-commit-id-full='git log -1 --pretty=oneline |cut -c1-40'

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
alias git-add-untracked-files='git add $(git ls-files -o --exclude-standard); git status'
alias git-del-untracked-files='del $(git ls-files -o --exclude-standard); git status'
alias git-unstage-untracked-files='git reset HEAD $(git diff --name-only --diff-filter=A HEAD); git status'
# http://stackoverflow.com/questions/3801321/git-list-only-untracked-files-also-custom-commands
# NOTICE: this will also delete files marked in .gitignore, e.g.: config/database.yml
# NOT RECOMMEND TO USE
# alias git-clear-untracked-files='git clean -df'




# ==== for git flow ====
# brew install git-flow
# https://github.com/nvie/gitflow/wiki/Mac-OS-X
alias git-flow-init-push='git flow init;git push -u origin develop;'




# ==== for git patch ====
# alias git-patch-build='git diff --no-prefix > patchfile.diff; ls patchfile.diff'
# show the changes which have been staged?
alias git-build-patch='git diff --cached --no-prefix > patchfile.diff; ls patchfile.diff'

# usage: $ git-apply-patch ../vendors/local_production_patch.diff
alias git-apply-patch='patch -p0 <'




# ==== for git tag ====
# list tags
alias git-tag='git tag'

# tips for adding new tag
# $ git tag -a v1.2 -m 'tag v1.2'
# $ git push origin v1.2

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
# gitstats is a statistics generator for git repositories. Currently it produces only HTML output with tables and graphs.
# git://repo.or.cz/gitstats.git
# usage: $ git-stats <path> <output-folder>
# Requirement 'gnuplot': $ brew install gnuplot
alias git-stats="gitstats . git-stats"




