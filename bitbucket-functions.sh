# open bitbucket page for current repo
function bitbucket-open {
  bitbucket_repo_url=`git ls-remote --get-url`
  bitbucket_user=`echo $bitbucket_repo_url|cut -d : -f 2|cut -d / -f 1`
  bitbucket_repo=`echo $bitbucket_repo_url|cut -d : -f 2|cut -d / -f 2|cut -d . -f 1`
  current_branch=`git rev-parse --abbrev-ref HEAD`

  bitbucket_pr_url="https://bitbucket.org/${bitbucket_user}/${bitbucket_repo}"
  open $bitbucket_pr_url
}

# create a new branch which name is using dasherize style, e.g.: "the-branch-name
# usage example:
#   $ bitbucket-new-branch "MyProject-1234 [docs] fix typos in README."
#   Switched to a new branch 'MyProject-1234-docs-fix-typos-in-readme'
# keeping the begging "MyProject-1234" unchanged because Jira will use it reference to Bitbucket
# more naming examples:
#   $ bitbucket-new-branch "[docs] fix typos in README."
#   $ docs-fix-typos-in-readme
#   $ bitbucket-new-branch "[refactor]log 放入logger里面"
#   $ refactor-log-logger
function bitbucket-new-branch {

  # conver input to a dasherize style branch name
  function format_branch_name {
    local input=$1
    # convert none-alpha to "-", keep one "-" only, remove first "-", remove last "-"
    local branch_name=` echo $input | sed -e 's/[^a-zA-Z0-9]/-/g' -e 's/--*/-/g'  -e 's/^-//' -e 's/-$//'`
    local project_key=""
    if [[ $branch_name =~ ^[A-Za-z]+-[0-9]+.+ ]]; then
      branch_name=` echo $branch_name | sed -e 's/\(^[A-Za-z]*-[0-9]*\)\(.*\)/\1:\2/' `
      project_key=` echo $branch_name | cut -d : -f 1 `
      branch_name=` echo $branch_name | cut -d : -f 2 `
    fi
    # conver branch_name to lowercase, BSD version of sed doesn't support "\L" but GNU version works
    branch_name=` echo $branch_name | sed -e 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/' `
    branch_name="$project_key$branch_name"
    echo $branch_name
  }

  function confirm_branch_name {
    local branch_name=$1
    echo -n "Going to create a branch \"$branch_name\", ok? [y/n]: "
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
      create_branch $branch_name
    else
      ask_for_branch_name
    fi
  }

  function ask_for_branch_name {
    echo -n "Please enter a new branch name using dasherize style, e.g.: \"the-branch-name\" (blank to abort): "
    read answer
    if [[ $answer = *[!\ ]* ]]; then
      create_branch $answer
    else
      echo "Aborted"
    fi
  }

  function create_branch {
    local branch_name=$1
    git checkout -b $branch_name
  }

  # main
  local input=$1
  branch_name=` format_branch_name \"$input\" `
  confirm_branch_name $branch_name
}

function bitbucket-push-current-branch {
  current_branch=`git rev-parse --abbrev-ref HEAD`
  git push -u origin $current_branch
}

function bitbucket-delete-remote-branch {
  git push --delete origin $1;
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
  echo "Prepare sending Pull Request from ${current_branch} to ${base_branch}"
  echo "$bitbucket_pr_url"
  open $bitbucket_pr_url
}

alias bitbucket-send-pull-request-to-develop='bitbucket-send-pull-request develop'
