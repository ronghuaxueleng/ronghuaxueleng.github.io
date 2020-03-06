---
title: 使用sendMail发送邮件
category: kindle
tags: kindle
toc: true
abbrlink: '48608651'
date: 2016-09-19 00:00:00
modifiedOn: 2016-09-19 00:00:00
---

------
由于前不久买了个kindle，所以就一直琢磨怎么把它用好，发现亚马逊提供了一个推送服务，可以把书籍推送到绑定的kindle上，所以就在网上搜罗了一些kindle推送的网站，像[kindle推][1]、[看云][2]等都是很好的平台，有的时候也想把本地书籍推送到kindle上阅读，方法当然也有很多，比如直接连接到电脑、通过邮箱发送邮件等，这些都是很好的办法，下面我就将介绍一种使用sendMail发送邮件的方法


<!--more-->

# 安装
到[sendMail][3]官方网站去下载压缩包，解压即可使用

# 发送邮件

进入到解压后的目录，你也可以把这个目录配置到环境目录中这样更方便使用

使用命令：

 ```bash
 sendEmail -f yourselfemail@163.com -t targetemail@qq.com -s smtp.163.com -u "我是邮件主题" -o message-content-type=html -o message-charset=utf8 -xu 登陆用户名@163.com -xp 123456用户密码  -m "我是邮件内容 -a "附件路径" -o message-charset=GB2312 -o message-header=GB2312
 ```
 -f yourselfemail@163.com  发件人邮箱
-s smtp.163.com       发件人邮箱的smtp服务器
-u "我是邮件主题"     邮件的标题
-o message-content-type=html   邮件内容的格式,html表示它是html格式
-o message-charset=utf8        邮件内容编码
-xu 登陆用户名@163.com          发件人邮箱的用户名
-xp 123456用户密码               发件人邮箱密码
-m "我是邮件内容"        邮件的具体内容
-a "附件路径"

  [1]: http://www.kindlepush.com/main
  [2]: http://www.kancloud.cn/
  [3]: http://caspian.dotconf.net/menu/Software/SendEmail/#download