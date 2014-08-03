# here are commands wrapping using `function`, support arguments

# ==== for git checkout ====

function git-checkout-remote { git checkout -b $1 origin/$1; }

function git-delete-remote { git push --delete origin $1; }

function git-fetch-remote { git fetch origin :$1; git checkout $1; }




# ==== for git remote ====

# git remote add origin git@example.com:myrepo
function git-remote-add { git remote add $1 $2; };
function git-remote-add-origin { git remote add origin $1; };

# How to change a remote repository URI using Git? (http://stackoverflow.com/questions/2432764/how-to-change-a-remote-repository-uri-using-git)
# git remote set-url origin git://new.url.here
function git-remote-set-url-origin { git remote set-url origin $1; };




# ==== for git branch ====

# convert a string to parameterize format
# for example:
# $ String.parameterize ""this s a LongString"
# this-s-a-longstring
# requirement: ruby gem active_support
function String.parameterize (){
  ruby -e "require 'active_support/core_ext/string'; puts '$1'.parameterize;"
}

# usage example:
# $ git-new-branch "56856748 daily statistics for count of leads for each sales_person"
# Switched to a new branch '56856748-daily-statistics-for-count-of-leads-for-each-sales_person'
function git-new-branch {
  String.parameterize "$1" > __tmp__
  cat __tmp__ |xargs -L1 git checkout -b
  rm __tmp__
}




# ==== for git push ====

function git-push-current-branch-to-remote {
  branch_name=`git-current-branch`
  git push origin $branch_name
  git branch --set-upstream-to=origin/$branch_name $branch_name
}

# tips: git push to different remote branch
# git push <REMOTENAME> <LOCALBRANCHNAME>:<REMOTEBRANCHNAME>

# push local "test" to remote "master"
# $ git push origin test:master
# git-push-local-to-remote test master
function git-push-local-to-remote {
  git push origin $1:$2
}




# ==== for git config ====

function git-author {
  gituser=`git config user.name`
  gitemail=`git config user.email`
  echo "$gituser <$gitemail>"
}




# ==== for git tag ====

# delete a tag from local
function git-tag-delete-local { git tag -d $1; };

# delete a tag from remote
# function git-tag-delete-remote { git push origin :refs/tags/$1; };
function git-tag-delete-remote { git push origin :$1; };

