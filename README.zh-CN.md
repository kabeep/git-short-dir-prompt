<h1 align="center"> git-short-dir-prompt </h1>
<p align="center">
  <b >简化 Git 工作目录路径的 Bash 脚本，用来提升在命令行中的工作效率和专注度</b>
</p>

---

<div align="center">

![Linux](https://img.shields.io/badge/Linux-support-lightseagreen?logo=linux)
![Windows](https://img.shields.io/badge/Windows-support-cornflowerblue?logo=windows)
![MacOS](https://img.shields.io/badge/MacOS-support-salmon?logo=apple)
[![Version](https://img.shields.io/badge/Version-1.0.0-slateblue?logo=powershell)](CHANGELOG.md)
[![License](https://img.shields.io/badge/License-MIT-yellowgreen)](LICENSE)

[English](README.md) | 简体中文

</div>

## 📖 简介

`git-short-dir-prompt` 是一个以 [git-prompt.sh](https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh) 的概念为 Bash shell 环境设计的脚本，用于在 Git 仓库中显示简洁的目录路径

它旨在提升命令行中的工作效率和专注度，特别适用于需要在复杂的目录结构中快速导航的开发者

>
> 它能够帮你：
>
> - 自动检测当前目录是否为 Git 仓库，不止初始化
>
> - 在 Git 目录中隐藏冗长的工作目录路径
>
> - 简化路径清晰指向用户与 GitHub 仓库地址
> 
> - 解决了 windows 的大小写不敏感问题

#### 默认的命令行提示符

![default_prompt](images/default_prompt.png)

#### 简化的命令行提示符

![simplified_prompt](images/simplified_prompt.png)

## ⚙️ 安装

1. 克隆仓库

```shell
git clone https://github.com/kabeep/git-short-dir-prompt.git
```

2. 进入项目目录

```shell
cd git-short-dir-prompt
```

3. 执行安装程序

```shell
./install.sh
```

4. 编辑 `.bash_profile` 以在初始化中调用

```shell
vim ~/.bash_profile

### .bash_profile
# 修改你的 用户名
PS1="$PS1"'username'                    # username
# 修改你的 主机名
PS1="$PS1"'@hostname '                  # hostname
```

5. 加载 `.bash_profile` / 重启终端

```shell
source ~/.bash_profile
```

## 🚀 使用

一旦安装和配置完成，当你进入一个 Git 仓库目录时，命令行提示符将自动更新以显示简化的目录路径。

## 🤝 贡献

欢迎通过 Pull Requests 或 [Issues](https://github.com/kabeep/git-short-dir-prompt/issues) 来贡献你的想法和代码。

## 📄 许可

本项目采用 MIT 许可证。详情请见 [LICENSE](LICENSE) 文件。
