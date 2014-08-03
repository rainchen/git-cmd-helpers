# open github page for current repo
function github-open {
  github_repo_url=`git ls-remote --get-url`
  github_user=`echo $github_repo_url|cut -d : -f 2|cut -d / -f 1`
  github_repo=`echo $github_repo_url|cut -d : -f 2|cut -d / -f 2|cut -d . -f 1`
  current_branch=`git rev-parse --abbrev-ref HEAD`

  github_pr_url="https://github.com/${github_user}/${github_repo}"
  open $github_pr_url
}


# use current branch to send pull request on github
# will open url like:
#   "https://github.com/${github_user}/${github_repo}/compare/${base_branch}...${current_branch}"
# example for using develop as base branch: $ github-send-pull-request develop
function github-send-pull-request {
  default_base_branch="master"
  base_branch=$1
  # use default_base_branch
  if [[ $base_branch == "" ]]; then
    base_branch=$default_base_branch
  fi

  github_repo_url=`git ls-remote --get-url`
  github_user=`echo $github_repo_url|cut -d : -f 2|cut -d / -f 1`
  github_repo=`echo $github_repo_url|cut -d : -f 2|cut -d / -f 2|cut -d . -f 1`
  current_branch=`git rev-parse --abbrev-ref HEAD`

  github_pr_url="https://github.com/${github_user}/${github_repo}/compare/${base_branch}...${current_branch}"
  # echo $github_pr_url
  open $github_pr_url
}
