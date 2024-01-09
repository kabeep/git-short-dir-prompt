# repo_prompt.sh
#
# Copyright (C) 2024 张子鑫
# Distributed under the MIT General Public License.
#
# This script helps you shorten the git working directory to a shorter path in your prompt.

# Function to check if the current directory is within a Git repository
# Uses `git rev-parse --is-inside-work-tree` to determine if inside a Git repo.
__is_in_git_repo() {
  git rev-parse --is-inside-work-tree &>/dev/null
}

# Function to get the root directory of the Git repository and extract its basename
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

# Function to get GitHub username from Git configuration
# Fetches the global Git user name, falls back to "default_username" if not set.
__get_git_username() {
  local github_username=$(git config --global user.name)
  if [ -n "$github_username" ]; then
    echo "$github_username"
  else
    echo "default_username" # Default username if not configured
  fi
}

# Function to customize the prompt for Git repositories
# Builds a custom prompt showing the GitHub username, repository name, and relative path within the repo.
__git_short_dir_ps1() {
  # Get the current working directory
  if [ "$OS" = "Windows_NT" ]; then
    local current_dir=$(pwd | tr '[:upper:]' '[:lower:]')
  else
    local current_dir=$(pwd)
  fi

  if __is_in_git_repo; then
    # Define the root directory of your target git repository
    local repo_root=$(__git_repo_root) # Modify this path accordingly

    # Get the username from git config --global
    local git_username=$(__get_git_username)

    # Extract the relative path from the repo root
    local relative_path="${current_dir#$repo_root}"

    # Check if at the root of the repo
    if [[ -z "$relative_path" ]]; then
      relative_path="" # Indicates being at the root of the repo
    fi

    # Print the customized prompt part
    # Format: "github:[username]/[repo_name][relative_path] "
    printf "github:${git_username}/$(basename "$repo_root")${relative_path}"
  else
    # Outside the target repo, return standard working directory
    printf $current_dir
  fi
}
