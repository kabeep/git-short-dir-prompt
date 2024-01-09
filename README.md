<h1 align="center"> git-short-dir-prompt </h1>
<p align="center">
  <b>A Bash script to simplify Git working directory paths for enhanced efficiency and focus in the command line</b>
</p>

---

<div align="center">

![Linux](https://img.shields.io/badge/Linux-support-lightseagreen?logo=linux)
![Windows](https://img.shields.io/badge/Windows-support-cornflowerblue?logo=windows)
![MacOS](https://img.shields.io/badge/MacOS-support-salmon?logo=apple)
[![Version](https://img.shields.io/badge/Version-1.0.0-slateblue?logo=powershell)](CHANGELOG.md)
[![License](https://img.shields.io/badge/License-MIT-yellowgreen)](LICENSE)

English | [简体中文](README.zh-CN.md)

</div>

## 📖 Features

`git-short-dir-prompt` is a script designed for the Bash shell environment, based on the concept of [git-prompt.sh](https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh). It displays a concise directory path within Git repositories.

It aims to enhance work efficiency and focus in the command line, especially suitable for developers who need to navigate quickly through complex directory structures.

> It helps you:
>
> - Automatically detect if the current directory is a Git repository, not just initialized
>
> - Hide lengthy working directory paths in Git directories
>
> - Simplify paths to clearly point to the user and GitHub repository address
> 
> - Resolved the issue of case insensitivity on Windows

#### Default Command Line Prompt

![default_prompt](images/default_prompt.png)

#### Simplified Command Line Prompt

![simplified_prompt](images/simplified_prompt.png)

## ⚙️ Installation

1. Clone the repository

```shell
git clone https://github.com/kabeep/git-short-dir-prompt.git
```

2. Edit .bash_profile to call during initialization

```shell
vim ~/.bash_profile
```

Example

```shell
# .bash_profile

# Git Bash Prompt String 1
PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]'  # Set terminal window title to include PWD (Present Working Directory)
PS1="$PS1"'\n'                          # Add a new line to the prompt
PS1="$PS1"'\[\033[32m\]'                # Change text color to green
PS1="$PS1"'your_username'               # representing the username placeholder
PS1="$PS1"'\[\033[35m\]'                # Change text color to purple
PS1="$PS1"'@your_hostname '             # representing the your_hostname placeholder
PS1="$PS1"'\[\033[33m\]'                # Change text color to brownish yellow

# Check if WINELOADERNOEXEC is not set, if not, proceed to configure Git related prompts
if test -z "$WINELOADERNOEXEC"
then
  # Determine the path for Git completions
  GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
  COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
  COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
  COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"

  ################### Change $COMPLETION_PATH to your path ####################
  # Check if repo-prompt.sh exists and source it if it does
  if test -f "$COMPLETION_PATH/git-short-dir-prompt.sh"
  then
    . "$COMPLETION_PATH/git-short-dir-prompt.sh"
    PS1="$PS1"'`__git_short_dir_ps1`'  # Add the output from __repo_ps1 function to PS1
  fi
  #############################################################################

  # Check if git-prompt.sh exists and source it if it does
  if test -f "$COMPLETION_PATH/git-prompt.sh"
  then
    . "$COMPLETION_PATH/git-completion.bash"
    . "$COMPLETION_PATH/git-prompt.sh"
    PS1="$PS1"'\[\033[36m\]'  # Change text color to cyan
    PS1="$PS1"'`__git_ps1`'   # Add the output from __git_ps1 function to PS1
  fi
else
  PS1="$PS1"'\w'  # Display the current working directory if WINELOADERNOEXEC is set
fi

PS1="$PS1"'\[\033[0m\]'         # Reset text color to default
PS1="$PS1"'\n'                  # Add a new line
PS1="$PS1"'$ '                  # Finalize the prompt with a dollar sign

# Include other configuration files if they exist
# generated by Git for Windows
test -f ~/.profile && . ~/.profile  # Source the .profile file if it exists
test -f ~/.bashrc && . ~/.bashrc    # Source the .bashrc file if it exists
```

3. Load .bash_profile / Restart Terminal

```shell
source ~/.bash_profile
```

## 🚀 Usage

Once installed and configured, when you enter a Git repository directory, the command line prompt will automatically update to display a simplified directory path.

## 🤝 Contribution

Contributions via Pull Requests or Issues are welcome.

## 📄 License

This project is licensed under the MIT License. See the LICENSE file for details.
