# open gitlab page for current repo
function gitlab-open {
  gitlab_repo_url=`git ls-remote --get-url` # git@git.example.com:repo-name.git
  gitlab_user=`echo $gitlab_repo_url|cut -d @ -f 1`
  gitlab_host=`echo $gitlab_repo_url|cut -d : -f 1|cut -d @ -f 2`
  gitlab_repo=`echo $gitlab_repo_url|cut -d : -f 2|cut -d . -f 1`
  gitlab_web_url="http://${gitlab_host}/${gitlab_repo}"
  open $gitlab_web_url
}


# use current branch to send pull request on gitlab website
# will open url like:
#   # http://gitlab.exapmle.com/repo-name/merge_requests/new?merge_request[source_branch]=current_branch&merge_request[target_branch]=develop&merge_request[title]=title"
# example for using develop as base branch: $ gitlab-send-merge-request develop
function gitlab-send-merge-request {
  default_target_branch="master"
  target_branch=$1
  # use default_target_branch for target_branch
  if [[ $target_branch == "" ]]; then
    target_branch=$default_target_branch
  fi

  gitlab_repo_url=`git ls-remote --get-url` # git@git.example.com:repo-name.git
  gitlab_user=`echo $gitlab_repo_url|cut -d @ -f 1`
  gitlab_host=`echo $gitlab_repo_url|cut -d : -f 1|cut -d @ -f 2`
  gitlab_repo=`echo $gitlab_repo_url|cut -d : -f 2|cut -d . -f 1`
  gitlab_web_url="http://${gitlab_host}/${gitlab_repo}"

  current_branch=`git rev-parse --abbrev-ref HEAD`

  # String.titleize(){
  #   echo "$1" | sed -E -e "s/-|_/ /g" -e 's/\b(.)/\U\1/g'
  # }
  # gitlab_mr_title=`String.titleize $current_branch`

  git_last_commit_message=`git log -1 --pretty=%B`
  gitlab_mr_title=$git_last_commit_message

  gitlab_mr_url="${gitlab_web_url}/merge_requests/new?merge_request[source_branch]=${current_branch}&merge_request[target_branch]=${target_branch}&merge_request[title]=${gitlab_mr_title}"
  open "$gitlab_mr_url"
}
alias gitlab-send-merge-request-to-develop='gitlab-send-merge-request develop'
