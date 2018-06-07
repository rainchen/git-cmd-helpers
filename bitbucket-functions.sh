# open bitbucket page for current repo
function bitbucket-open {
  bitbucket_repo_url=`git ls-remote --get-url`
  bitbucket_user=`echo $bitbucket_repo_url|cut -d : -f 2|cut -d / -f 1`
  bitbucket_repo=`echo $bitbucket_repo_url|cut -d : -f 2|cut -d / -f 2|cut -d . -f 1`
  current_branch=`git rev-parse --abbrev-ref HEAD`

  bitbucket_pr_url="https://bitbucket.org/${bitbucket_user}/${bitbucket_repo}"
  open $bitbucket_pr_url
}


# use current branch to send pull request on bitbucket
# will open url like:
#   "https://bitbucket.org/${bitbucket_user}/${bitbucket_repo}/pull-requests/new?source=${current_branch}&dest=${base_branch}"
# example for using develop as base branch: $ bitbucket-send-pull-request develop
function bitbucket-send-pull-request {
  default_base_branch="master"
  base_branch=$1
  # use default_base_branch
  if [[ $base_branch == "" ]]; then
    base_branch=$default_base_branch
  fi

  bitbucket_repo_url=`git ls-remote --get-url`
  bitbucket_user=`echo $bitbucket_repo_url|cut -d : -f 2|cut -d / -f 1`
  bitbucket_repo=`echo $bitbucket_repo_url|cut -d : -f 2|cut -d / -f 2|cut -d . -f 1`
  current_branch=`git rev-parse --abbrev-ref HEAD`

  bitbucket_pr_url="https://bitbucket.org/${bitbucket_user}/${bitbucket_repo}/pull-requests/new?source=${current_branch}&dest=${base_branch}"
  open $bitbucket_pr_url
}

alias bitbucket-send-pull-request-to-develop='bitbucket-send-pull-request develop'
