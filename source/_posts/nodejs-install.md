---
title: 快速搭建 Node.js 开发环境
category: '环境,nodejs'
tags: 'tool,nodejs,javascript,环境,搭建'
abbrlink: 4d2fd6c9
date: 2015-12-08 19:12:59
modifiedOn: 2015-12-08 19:12:59
---

----------

如果你想长期做 node 开发, 或者想快速更新 node 版本, 或者想快速切换 node 版本,
那么在非 Windows(如 osx, linux) 环境下, 请使用 nvm 来安装你的 node 开发环境, 保持系统的干净.
如果你使用 Windows 做开发, 那么你可以使用 nvmw 来替代 nvm

<!-- more -->

----------

osx, linux 环境
=============

如果你是 windows 环境开发, 请跳过这里, 直接查看下一章.

git clone nvm
-------------
直接从 github clone nvm 到本地, 这里假设大家都使用 ~/git 目录存放 git 项目:

    cd ~/git
    git clone https://github.com/creationix/nvm.git

配置终端启动时自动执行 source ~/git/nvm/nvm.sh,
在 ~/.bashrc, ~/.bash_profile, ~/.profile, 或者 ~/.zshrc 文件添加以下命令:

    source ~/git/nvm/nvm.sh

重新打开你的终端, 输入 nvm

    $ nvm
    
    Node Version Manager
    
    Usage:
        nvm help                    Show this message
        nvm --version               Print out the latest released version of nvm
        nvm install [-s] <version>  Download and install a <version>, [-s] from source
        nvm uninstall <version>     Uninstall a version
        nvm use <version>           Modify PATH to use <version>
        nvm run <version> [<args>]  Run <version> with <args> as arguments
        nvm current                 Display currently activated version
        nvm ls                      List installed versions
        nvm ls <version>            List versions matching a given description
        nvm ls-remote               List remote versions available for install
        nvm deactivate              Undo effects of NVM on current shell
        nvm alias [<pattern>]       Show all aliases beginning with <pattern>
        nvm alias <name> <version>  Set an alias named <name> pointing to <version>
        nvm unalias <name>          Deletes the alias named <name>
        nvm copy-packages <version> Install global NPM packages contained in <version> to current version
    Example:
        nvm install v0.10.24        Install a specific version number
        nvm use 0.10                Use the latest available 0.10.x release
        nvm run 0.10.24 myApp.js    Run myApp.js using node v0.10.24
        nvm alias default 0.10.24   Set default node version on a shell
    Note:
        to remove, delete or uninstall nvm - just remove ~/.nvm, ~/.npm and ~/.bower folders


通过 nvm 安装任意版本的 node
-------------------
nvm 默认是从 http://nodejs.org/dist/ 下载的, 国外服务器, 必然很慢,
好在 nvm 以及支持从镜像服务器下载包, 于是我们可以方便地从七牛的 node dist 镜像下载:

    NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist nvm install 0.11.11

于是你就会看到一段非常快速进度条:

    ######################################################################## 100.0%
    Now using node v0.11.11

如果你不想每次都输入环境变量 NVM_NODEJS_ORG_MIRROR, 那么我建议你加入到 .bashrc 文件中:

    # nvm
    export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist
    source ~/git/nvm/nvm.sh

然后你可以继续非常方便地安装各个版本的 node 了, 你可以查看一下你当前已经安装的版本:

    $ nvm ls
         nvm
     v0.8.26
    v0.10.26
    v0.11.11
    ->  v0.11.12

windows 环境
==========

----------

git clone nvmw
--------------

直接从 github clone nvmw 到本地, 这里假设大家都使用 d:\git 目录存放 git 项目:

    $ d:
    $ cd git
    $ git clone https://github.com/hakobera/nvmw.git

设置 d:\git\nvmw 目录到你的 PATH 环境变量中:

    set "PATH=d:\git\nvmw;%PATH%"

重新打开你的终端, 输入 nvmw

    $ nvmw
    Usage:
      nvmw help                    Show this message
      nvmw install [version]       Download and install a [version]
      nvmw uninstall [version]     Uninstall a [version]
      nvmw use [version]           Modify PATH to use [version]
      nvmw ls                      List installed versions
    Example:
      nvmw install v0.6.0          Install a specific version number
      nvmw use v0.6.0              Use the specific version


通过 nvmw 安装任意版本的 node
--------------------

nvmw 默认是从 http://nodejs.org/dist/ 下载的, 国外服务器, 必然很慢,
好在 nvmw 以及支持从镜像服务器下载包, 于是我们可以方便地从七牛的 node dist 镜像下载:

    $ set "NVMW_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist"
    $ nvmw install 0.11.11

于是你就会看到一段非常快速进度条:

    ######################################################################## 100.0%
    Now using node v0.11.11

如果你不想每次都输入环境变量 NVMW_NODEJS_ORG_MIRROR, 那么我建议你在全局环境变量中增加它.

然后你可以继续非常方便地安装各个版本的 node 了, 你可以查看一下你当前已经安装的版本:

    $ nvmw ls
    v0.10.26
    v0.11.12
    Current: v0.11.12

到此, 无论是 windows 环境, 还是 osx, linux 环境, 都能快速安装多个版本的 node 了.