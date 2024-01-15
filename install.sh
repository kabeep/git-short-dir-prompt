#!/bin/bash

# 要复制的文件名，根据需要更改
PROMPT_FILE="git-short-dir-prompt.sh"

TEMPLATE_FILE=".bash_profile_template"

PROFILE_FILE=".bash_profile"

# 获取 Git 执行路径
GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"

# 计算完成路径
COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"

__get_user_directory() {
  if [[ -n "$HOME" ]]; then
    echo "$HOME"
  elif [[ -n "$USERPROFILE" ]]; then
    echo "$USERPROFILE"
  else
    echo "Error: User directory not found." >&2
    return 1
  fi
}

PROFILE_PATH="$(__get_user_directory)";

if [[ -f "$PROFILE_PATH/$PROFILE_FILE" ]]; then
  echo "Bash Profile File already exists, please remove first: $PROFILE_PATH/$PROFILE_FILE"
else
# 检查文件是否存在
  if [[ -f "$PROMPT_FILE" ]]; then
    # 检查目标目录是否存在
    if [ -d "$COMPLETION_PATH" ]; then
      # 复制文件到目标目录
      cp "$PROMPT_FILE" "$COMPLETION_PATH/"
      echo "Copied prompt to: $COMPLETION_PATH/$PROMPT_FILE"
      cp "$TEMPLATE_FILE" "$PROFILE_PATH/$PROFILE_FILE"
      echo "Copied profile to: $PROFILE_PATH/$PROFILE_FILE"
    else
      echo "Directory does not exists: $COMPLETION_PATH"
    fi
  else
    echo "File does not exists: $PROMPT_FILE"
  fi
fi
