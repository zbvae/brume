---
layout: post
title: Python安装第三方模块(Windows)
date: 2016-04-28 20:19:18
tags: [Python]

---
* 目录
{:toc #markdown-toc}

### 前言

本文针对Windows系统下的Python第三方模块安装，之前通过各种途径下载到本地，然后解压，cmd进入文件目录，使用setup.py安装，但是会出现各种莫名的错误，当然在Linux系统上的安装会简单一些。最后使用pip安装whl文件便使模块安装变得容易的多。

### 下载whl文件

whl格式的文件为python模块wheel文件，很多第三方python模块都可以从这个网站中找到[模块库]<http://www.lfd.uci.edu/~gohlke/pythonlibs>,注意请根据实际安装的Python版本，选择文件下载，该页面下提供有2.x和3.x版本以及针对32位和64位版本的下载。

### pip安装whl文件

cmd进入下载文件目录，输入以下命令完成安装：

> 'python -m pip install 模块名(实际不用全部输入，只需输入开头字母，再按tab键即可补全)'

由于本人安装的pip版本较高，所以在之前加入python -m，就是这个错误折腾了好久，希望后来者注意。如果提示successfully installed，说明安装完成。

