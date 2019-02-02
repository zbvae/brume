---
layout: post
title: CENTOS 6.5安装vncserver
date: 2016-03-08 22:04:11
tags: [云服务器]

---
vnc是一款使用广泛的服务器管理软件，可以实现图形化管理，下面简单介绍一下如何在centos6.5下安装vnc。

### 安装vncserver 

输入命令：`yum -y install tigervnc-server`

### 配置 vncserver  

编辑/etc/sysconfig/vncservers文件,找到

> VNCSERVERS="2:myusername"
> VNCSERVERARGS[2]="-geometry 800x600 -nolisten tcp -localhost"

修改为：

> VNCSERVERS="1:root"
> VNCSERVERARGS[1]="-geometry 1024x768" <!-- more -->

### 设置远程登陆密码

输入`vncserver`命令，系统会检测到您是第一次输入，提示您设置密码，连续输入两次即可。这个密码是vnc连接密码，和系统密码没有关系。可以不一样。

> [root@localhost ~]# vncpasswd Password:
> Verify:[root@localhost ~]# 

后期可以通过输入vncpasswd命令，来设置vnc用户登录密码

### 启动和关闭vncserver

第一次启动时直接输入`vncserver`系统会自动建立相关的配置文件和日志文件。启动后系统会提示出一个进程号为1的窗口。如果需要启动两个窗口的话则再次执行`vncserver`命令即可。

通过输入命令`vncserver -kill :1`来关闭刚刚启动的1号窗口服务，可以通过输入命令`vncserver :1`来再次启动1号窗口提供vnc远程登录服务。

### 让vnc服务开机启动

输入命令`chkconfig  vncserver  --level 345  on`或者直接输入`chkconfig vncserver on`

再通过输入`chkconfig --list`查看所有的开机启动服务里有没有vncserver.

### 客户端使用vncviewer 

安装vncviewer之后，打开软件，以 “ip:1”的形式连接，输入密码后进入到vncserver中。 

### 问题及解决方法

若进入后系统显示灰屏的话需要修改**~/.vnc/xstartup**文件，找到最后一行，将

> twm & #注释掉这一行
> gnome-session & #添加这一行

输入`service vncserver restart`重启vncserver服务，再次使用vncviewer登录，如果还是灰屏，则查看日志 `cat ~.vnc/name:1.log`，查看其中出现的错误，一般是还未安装gnome环境，则通过网络安装即可：`yum -y install gnome-session`,`yum -y install xterm`,`yum -y install xsetroot`.

安装完以上，这时候登录进去，不再是灰屏，可能是空白桌面，也就是没有图标，这时候，再次查看日子，发现错误，最后发现没有安装任务栏和桌面插件,通过网络安装即可`yum -y install gnome-panel`.

解决桌面图标问题之后，有可能还会发现，浏览中文显示乱码的问题，那是因为桌面环境是英文的，可以通过echo $LANG,来确定，通过网络安装中文支持包`yum groupinstall chinese-support`，安装完成之后，修改/etc/sysconfig/i18n文件，设置`LANG=zh_CN.UTF-8`。

以上这些解决是通过查看日志，发现问题，逐项解决，可以通过以下系统方案解决。

> 安装图形桌面环境
> * 要安装 KDE 桌面环境，执行指令，
> > > `yum groupinstall "X Window System" "KDE Desktop" Desktop`即可，同时安装了 3 个软件包。注意，因为 KDE Desktop 和  X Window System 两个软件包名称中间都包含空格，需要用引号引起来才行。
> * 要安装 Gnome 桌面环境，执行指令，
> > > `yum groupinstall "X Window System" "Desktop Platform" Desktop`即可，也是同时安装了 3 个软件包，其中 X Window System 是必须的，不管是 Gnome 还是 KDE。

> 既然是桌面环境，可能还需要诸如字体、管理工具之类的，如，

> * yum -y groupinstall "Graphical Administration Tools"
> * yum -y groupinstall "Internet Browser"
> * yum -y groupinstall "General Purpose Desktop"
> * yum -y groupinstall "Office Suite and Productivity"
> * yum -y groupinstall "Graphics Creation Tools"