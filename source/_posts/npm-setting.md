---
title: NPM安装及优化步骤--详细版
category: '环境,npm'
tags: 'tool,npm,安装,优化'
abbrlink: 5b6e6c1a
date: 2015-12-15 19:12:59
modifiedOn: 2015-12-15 19:12:59
---

----------

npm的常用命令
=============

    npm install xxx 安装模块  
    npm install xxx@1.1.1   安装1.1.1版本的xxx  
    npm install xxx -g 将模块安装到全局环境中。  
    npm ls 查看安装的模块及依赖  
    npm ls -g 查看全局安装的模块及依赖  
    npm uninstall xxx  (-g) 卸载模块  
    npm cache clean 清理缓存  
    npm help xxx  查看帮助  
    npm view moudleName dependencies  查看包的依赖关系  
    npm view moduleNames  查看node模块的package.json文件夹  
    npm view moduleName labelName  查看package.json文件夹下某个标签的内容  
    npm view moduleName repository.url  查看包的源文件地址  
    npm view moduleName engines   查看包所依赖的Node的版本  
    npm help folders   查看npm使用的所有文件夹  
    npm rebuild moduleName    用于更改包内容后进行重建  
    npm outdated   检查包是否已经过时，此命令会列出所有已经过时的包，可以及时进行包的更新  
    npm update moduleName   更新node模块  

<!-- more -->

npm获取配置有6种方式，优先级由高到低
=============

    1、命令行参数。 --proxy http://server:port即将proxy的值设为http://server:port。
    2、环境变量。 以npm_config_为前缀的环境变量将会被认为是npm的配置属性。如设置proxy可以加入这样的环境变量npm_config_proxy=http://server:port。
    3、用户配置文件。可以通过npm config get userconfig查看文件路径。如果是mac系统的话默认路径就是$HOME/.npmrc。
    4、全局配置文件。可以通过npm config get globalconfig查看文件路径。mac系统的默认路径是/usr/local/etc/npmrc。
    5、内置配置文件。安装npm的目录下的npmrc文件。
    6、默认配置。 npm本身有默认配置参数，如果以上5条都没设置，则npm会使用默认配置参数。

针对npm配置的命令行操作
=============

    npm config set <key> <value> [--global]
    npm config get <key>
    npm config delete <key>
    npm config list
    npm config edit
    npm get <key>
    npm set <key> <value> [--global]
    在设置配置属性时属性值默认是被存储于用户配置文件中，如果加上--global，则被存储在全局配置文件中。
    如果要查看npm的所有配置属性（包括默认配置），可以使用npm config ls -l。
    如果要查看npm的各种配置的含义，可以使用npm help config。

解决npm install安装模块失败的问题
=============


1、为npm设置代理
-------------
    npm config set proxy http://server:port
    npm config set https-proxy http://server:port

如果代理需要认证的话可以这样来设置。

    npm config set proxy http://username:password@server:port
    npm config set https-proxy http://username:pawword@server:port

2、国内镜像
-------------

    清华大学Node Packaged Modules镜像：
    http://npm.tuna.tsinghua.edu.cn
    淘宝：
    http://registry.npm.taobao.org
    cnpmjs:
    http://r.cnpmjs.org
    未知：
    http://registry.cnpmjs.org

方法一：通过config命令指定

    npm config set registry http://registry.cnpmjs.org 
    npm info underscore （如果上面配置正确这个命令会有字符串response）

方法二：在命令行中指定

    npm --registry http://registry.cnpmjs.org info underscore

方法三：在配置文件中指定，编辑安装npm的目录下的npmrc文件加入下面内容

    registry = http://registry.cnpmjs.org

方法四：利用定制的cnpm代替npm

    #安装该模块，然后通过该命令来安装所需模块
    npm install -g cnpm --registry=http://registry.npm.taobao.org
    # 利用cnpm来安装模块
    cnpm install [name]# 利用cnpm来同步模块
    cnpm sync connect

方法五：利用alias添加一个基于npm的新命令

    alias cnpm="npm --registry=http://registry.npm.taobao.org \--cache=$HOME/.npm/.cache/cnpm \--disturl=http://npm.taobao.org/dist \--userconfig=$HOME/.cnpmrc"#Or alias it in .bashrc or .zshrc$ echo '\n#alias for cnpm\nalias cnpm="npm --registry=registry.npm.taobao.org \  --cache=$HOME/.npm/.cache/cnpm \  --disturl=http://npm.taobao.org/dist \  --userconfig=$HOME/.cnpmrc"' >> ~/.zshrc && source ~/.zshrc