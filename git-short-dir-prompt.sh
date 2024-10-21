# git-short-dir-prompt.sh
#
# Copyright (C) 2024 张子鑫
# Distributed under the MIT General Public License.
#
# This script helps you shorten the git working directory to a shorter path in your prompt.

# Check if the current directory is within a Git repository
# Uses `git rev-parse --is-inside-work-tree` to determine if inside a Git repo.
__is_in_git_repo() {
  git rev-parse --is-inside-work-tree &>/dev/null
}

# Get the root directory of the Git repository and cache the result
# Retrieves the top-level directory of the Git repository using `git rev-parse --show-toplevel`.
# Converts the path to Unix format if on a Cygwin environment.
__git_repo_root() {
  local repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ -n "$repo_root" ]; then
    repo_root=$(cygpath -u "$repo_root") # Convert to Unix path format on Cygwin
    if [ "$OS" = "Windows_NT" ]; then
      echo "$repo_root" | tr '[:upper:]' '[:lower:]'
    else
      echo "$repo_root"
    fi
  fi
}

# Get GitHub username from Git configuration and cache the result
# Fetches the global Git user name, falls back to "anonymous" if not set.
__get_git_username() {
  git config --global user.name || echo "anonymous"
}

# Customize the prompt for Git repositories
# Builds a custom prompt showing the GitHub username, repository name, and relative path within the repo.
__git_short_dir_ps1() {
  # Get the current working directory
  local current_dir=$(pwd)
  if [ "$OS" = "Windows_NT" ]; then
    current_dir=$(pwd | tr '[:upper:]' '[:lower:]')
  fi

  if __is_in_git_repo; then
    # Define the root directory of your target git repository
    local repo_root=$(__git_repo_root) # Modify this path accordingly

    local git_username=$(__get_git_username)

    # Extract the relative path from the repo root
    local relative_path="${current_dir#$repo_root}"

    # Check if at the root of the repo
    if [[ -z "$relative_path" ]]; then
      relative_path="" # At the root of the repo
    fi

    # Print the customized prompt part
    # Format: "github:[username]/[repo_name][relative_path] "
    printf "github:${git_username}/$(basename "$repo_root")${relative_path}"
  else
    # Outside a git repo, print the current directory safely
    printf "%s" "$current_dir"
  fi
}
