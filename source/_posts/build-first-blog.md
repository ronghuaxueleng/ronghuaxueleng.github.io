---
title: 使用hexo搭建属于自己的博客
category: hexo
tags: 'hexo,博客,blog,搭建'
abbrlink: f94f1ed0
date: 2015-11-25 00:00:00
modifiedOn: 2015-11-25 00:00:00
---

------

在搭建这个博客期间参考了很多资料，因为不是所有的资料都能完整并且顺利搭建出来，经过我本人实践，整理出来这篇文章，希望可以帮助大家减少不必要的麻烦，不用再到处找搭建方法，本文的共分为一下几章：

> 第一节： 什么是hexo
第二节： 为什么要用hexo
第三节： 谁使用hexo
第四节： 怎样搭建hexo博客
第五节： 如何更换自己的主题
第六节： 如何发表文章


----------

 

第一节：什么是hexo
-----------

 hexo是一个基于Node.js的静态博客程序，可以方便的生成静态网页托管在github和Heroku上。作者是来自台湾的@tommy351。引用@tommy351的话，hexo：
>快速、简单且功能强大的 Node.js 博客框架。
A fast, simple & powerful blog framework, powered by Node.js.
类似于jekyll、Octopress、Wordpress，我们可以用hexo创建自己的博客，托管到github或Heroku上，绑定自己的域名，用markdown写文章。本博客即使用hexo创建并托管在github上。

类似于jekyll、Octopress、Wordpress，我们可以用hexo创建自己的博客，托管到github或Heroku上，绑定自己的域名，用markdown写文章。

----------

第二节：为什么要用hexo
-------------

还是引用作者的话：
>不可思议的快速 ─ 只要一眨眼静态文件即生成完成
支持 Markdown
仅需一道指令即可部署到 GitHub Pages 和 Heroku
已移植 Octopress 插件
高扩展性、自订性
兼容于 Windows, Mac & Linux

我在加几个自己体会到的优点：

 - 易用：不仅部署简单，平时使用中仅需要hexo new hexo generate hexo server hexo deploy四个命令。不像Jekyll需要很多繁琐的git命令。
 - 轻：文件少、小，易理解，方便自定义。
 - 用户多：虽然赶不上Jekyll和Octopress，但遇到什么问题都能搜索到答案，或者找到同样使用hexo的用户进行参考和咨询。
 - 简单：我本人不太爱倒腾这东西，但是当我看到本博客的模板后，在看完教程后，都停不下来，用了一晚上就搭起来了
 - 省时：不必浪费时间在你不关注的东西上，专心写你的博客
 


----------


第三节：谁使用hexo
-----------

这是一个免费开源的博客程序，任何人都可以使用和修改。但是不同于wordpress，hexo由于需要使用**Github,Git,Markdown,Node.js**这样的工具，好多插件、widget都需要自己安装、设置。所以**适合那些有一定计算机基础，喜欢折腾的人**。

----------

第四节：怎样搭建hexo博客
--------------
>*注意：本节教程只针对Windows用户，Linux和Mac用户请移步hexo安装*。

----------

***安装Git***


>下载 [msysgit][1] 并执行即可完成安装。

----------
***安装Node.js***


>在Windows环境下安装[Node.js][2]非常简单，仅须下载安装文件并执行即可完成安装。

----------

***设置软件包国内镜像***

    npm config set registry http://registry.npm.taobao.org

----------
***安装hexo***

    npm install -g hexo

----------
***创建hexo文件夹***
安装完成后，在你喜爱的文件夹下（如F:\hexo），执行以下指令(在F:\hexo内点击鼠标右键，选择Git bash)，Hexo即会自动在目标文件夹建立网站所需要的所有文件。

    hexo init

执行完这一步后，你会发现文件夹下生成了一些文件和文件夹，用文本编辑器打开package.json文件，将里面的内容改为以下内容：

    {
      "name": "hexo-site",
      "version": "0.0.0",
      "private": true,
      "hexo": {
        "version": "3.1.1"
      },
      "dependencies": {
        "hexo": "^3.1.0",
        "hexo-deployer-git": "0.0.4",
        "hexo-deployer-heroku": "0.0.3",
        "hexo-deployer-openshift": "0.0.1",
        "hexo-deployer-rsync": "^0.1.1",
        "hexo-generator-archive": "^0.1.3",
        "hexo-generator-category": "^0.1.3",
        "hexo-generator-feed": "^1.0.3",
        "hexo-generator-index": "^0.1.3",
        "hexo-generator-sitemap": "^1.0.1",
        "hexo-generator-tag": "^0.1.2",
        "hexo-renderer-ejs": "^0.1.0",
        "hexo-renderer-marked": "^0.2.5",
        "hexo-renderer-stylus": "^0.2.3",
        "hexo-server": "^0.1.2"
      }
    }

----------
***安装依赖包***

    npm install

----------

***本地查看***
现在我们已经搭建起本地的hexo博客了，执行以下命令(在F:\hexo)，然后到浏览器输入localhost:4000看看。

    hexo generate
    hexo server

----------
***注册Github账号***

> 已有账号可以跳过，没有的，请在[此处][3]进行注册，很简单，这里就不介绍了。

----------
***创建repository***

> 在自己Github主页右下角，创建一个新的repository。比如我的Github账号是ronghuaxueleng，那么我应该创建的repository名字应该是[ronghuaxueleng.github.io][4]

![](/img/github_build.png)
![](/img/github_created.png)

----------
***部署***

编辑_config.yml(在F:\hexo下)。你在部署时，要把下面的nothingcpd都换成你的账号名。

    deploy:
      type: git
      repository: http://github.com/ronghuaxueleng/ronghuaxueleng.github.io.git
      branch: master
      ##注意："："后边需要有一个"空格"

***执行下列指令即可完成部署。***

    hexo generate
    hexo deploy
    
----------

第五节：如何更换自己的主题
-------------

***使用***

 1. 安装

> 在hexo主目录下
$ git clone https://github.com/litten/hexo-theme-yilia.git themes/yilia

2.配置

> 修改hexo根目录下_config.yml ：
theme: yilia

3.更新

    cd themes/yilia
    git pull

----------
***配置***
主题配置文件在主题目录yalia下的_config.yml：

    # Header
    menu:
      主页: /
      所有文章: /archives
      # 随笔: /tags/随笔
    
    # SubNav
    subnav:
      github: "#"
      weibo: "#"
      rss: "#"
      facebook: "#"
      # google: "#"
      # twitter: "#"
      # linkedin: "#"

    rss: /atom.xml
    
    # Content
    excerpt_link: more
    fancybox: true
    
    # Miscellaneous
    google_analytics: ''
    favicon: /favicon.png

    #你的头像
    avatar: "https://avatars2.githubusercontent.com/u/2024949?v=2&s=150"
    #是否开启分享
    share: true
    #是否开启多说评论，填写你在多说申请的项目名称
    duoshuo: true
    #是否开启云标签
    tagcloud: true

    #是否开启友情链接
    #不开启——
    #friends: false
    #开启——
    friends:
      奥巴马的博客: http://localhost:4000/
      卡卡的美丽传说: http://localhost:4000/
      本泽马的博客: http://localhost:4000/
      吉格斯的博客: http://localhost:4000/
      习大大大不同: http://localhost:4000/
      托蒂的博客: http://localhost:4000/
    
    #是否开启“关于我”。
    #不开启——
    #aboutme: false
    #开启——
    aboutme: 我是谁，我从哪里来，我到哪里去？我就是我，是颜色不一样的吃货…

----------
***体验***

    hexo generate
    hexo server

最后在浏览器中输入：localhost:4000 查看主题效果

    hexo generate
    hexo deploy
    
    最后在浏览器中输入： ronghuaxueleng.github.com 
    ps：ronghuaxueleng换成你自己的repo名字，查看效果
    
----------
这里有hexo的各种主题，喜欢折腾的可以去看看

    https://hexo.io/themes/


第六节：如何发表文章
----------

> **1. step1：输入 hexo new "my first post"**
ps:引号可以不加，最好不加，此时 查看source/_posts/下面会产生post.md的文件，此文件需要用markdown语言编辑，后面会有一篇专门介绍markdown语法的blog
以后每次运行上面的命令都会产生文件，会产生post1-1.md，post-2.md等依次增加

>**step2: 在F:\hexo\source_posts中打开这个文件（打开方式用“记事本”即可）, 然后将下面内容 拷贝到里面**
>
     layout: post
     title: "我的博客情缘"
     date: 2014-12-17 13:15
     comments: true
     tags: 
        - 随笔
        - 心情
        - 个人
    ---

>**step3: 输入 hexo server**
访问localhost:4000预览效果。（退出server用Ctrl+c）

>**step4: 输入 hexo deploy**
同步到github。访问网站看看效果。ronghuaxueleng.github.io(ronghuaxueleng换成你自己的repo)

现在为止，我们已经搭建起博客，进行一些基本配置，设置了主题，并学会了怎么发表文章。


  [1]: http://git-scm.com/download/win
  [2]: https://nodejs.org/en/
  [3]: https://github.com/
  [4]: http://ronghuaxueleng.github.io