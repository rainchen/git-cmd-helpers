# usage demo for https://github.com/rainchen/git-cmd-helpers

# create new branch
gb # list local branches
git-new-branch "demo: Create a new Branch" # create a branch with valid format "demo-create-a-new-branch"
gbv # list local branches with last commit

---

# commit a new file
echo use git-new-branch to create a new branch > CHANGES
git add CHANGES
gits # git status
git commit -am "add CHANGES"
gll # show git last log

---

# push current branch to remote
gbr # list remote branches
git-push-current-branch-to-remote
gbr # should see a new remote branch

---

# send a new pull request on GitHub
github-send-pull-request
# github-send-pull-request-to-develop # or using "develop" as base branch
github-open # open current repo's github repo url using web browser

# or send a new merge request on GitLab
gitlab-send-merge-request
gitlab-open

# or send a new pull request on Bitbucket
bitbucket-send-pull-request
bitbucket-open

---

# undo last commit
git-undo-last-commit

# fix last commit message or files
git commit --amend # # strongly recommend to use GitX to amend changes
# check Amend and commit
gits # you should see:
# Your branch and 'origin/demo-create-a-new-branch' have diverged,
# and have 1 and 1 different commit each, respectively.
git push -f # force push your feature branch, BUT DONT DO THIS ON YOUR BASE BRANCH

---

# merge the feature branch into master but not deleting the feature branch on GitHub/GitLab/Bitbucket

---

# delete a remote branch after PR get merged

gbr # list remote branches
git-delete-remote demo-create-a-new-branch
# - [deleted]         demo-create-a-new-branch
gbr # confirm it has been deleted

---

# delete all branches that are already merged
gb # check local branches
git-checkout-master
git-up # fetch and rebase local branch
git-delete-local-branches-deleted-from-remote
gb # confirm local are clean

---

# remove remote branches that have been merged into master
git-new-branch "new-master"
git-push-current-branch-to-remote
gbr
git-delete-remote-branches-mereged-into-master
gbr

---

# revert commit
git log
# backup master
git-new-branch "master-backup"
git-commits-first # get first commit hash, e.g.:
# a05dce35923a5e960a3cb258a670b34b43bf07ae
git-revert-to a05dce35923a5e960a3cb258a670b34b43bf07ae
git log
git push -f # override your remote branch

---

# resolve conflict

# step 1: change README in feature1 branch
git-new-branch feature1
echo add feature1 > README.md
git commit -am "add feature1"


# step 2: change README in master branch
git checkout master
echo add feature2 > README.md
git commit -am "add feature2"

# step 3: create conflict: merge master with feature1 branch
git merge feature1
# should see:
# CONFLICT (content): Merge conflict in README.md
# Automatic merge failed; fix conflicts and then commit the result.

# use opendiff as merge.tool
git config --global merge.tool opendiff

# call mergetool to fix conflicts
git mergetool # git will run opendiff to assist you to resolve conflicts, press cmd+s & cmd+q in opendiff to quit
# Normal merge conflict for 'README.md':
#   {local}: modified file
#   {remote}: modified file

# after resolving conflicts, commit the changes
git commit
# [master f497858] Merge branch 'feature1'
