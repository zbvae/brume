---
layout: post
title: 使用Hexo和Github搭建自己的个人博客网站
date: 2015-07-09 19:53:48
tags: [技术交流]

---

* 目录
{:toc #markdown-toc}

**摘要** 最近花了几天时间利用**Hexo**和**Github**搭建自己的个人博客网站，虽然中间的过程也是折腾够了，但是结果还是非常令人满意的，毕竟现在网站已经跑起来，独乐乐不如众乐乐，所以决定写这篇文章，也给大家介绍一下经验，顺便也对**Markdown**写博客练一下手。好了，让我们进入正题吧! <!-- more -->

### 环境搭建

使用Hexo+Github搭建自己的个人博客网站，主要分为两步：

1. 在本地下载好Hexo，并选择文件夹，新建本地博客;
2. 将本地建立好的Hexo博客托管到Github上。

本文所有一切都是针对Windows 7系统，因此如果是Linux或其他操作系统请自行索取相关学习资料。

#### Git安装

由于新建好的Hexo博客需要与Github关联，因此首先安装[Git](http://git-scm.com/download/win)工具，直接下载安装。

这时，在你的开始菜单会有Git工具选项，证明你已安装完成Git工具(非常好用的版本控制工具，可以用来管理你的项目)。

#### Node.js安装

为了下载Hexo，你还需要安装[node.js](https://nodejs.org/download/)，选择**msi**版本下载安装，系统会自动为你添加node和npm的环境变量(node.js中集成了npm模块)。

这时候，可以选择在Dos命令行输入`node -v`和`npm -v`，如果出现以下内容

<center> ![node&npm](/images/node&npm.png) </center>

说明你已完成node.js的安装和配置。

#### Hexo安装

终于进入我们正题的第一步了。找到开始菜单的Git工具，选择Git bash打开，输入`npm install hexo -g`，安装hexo全局环境。

### 新建Hexo博客

安装好全局Hexo环境之后，在本地硬盘新建目录**MyHexoBlog**，名字可以自己随便取。

在该目录上选择右击，进入Git bash环境，输入`hexo init`，实际上，这已经为我们新建好了本地Hexo博客了，要想访问，还必须先开启hexo服务，但是hexo服务的开启，还需要在该文件夹下安装hexo的所有依赖。

直接在Git bash上输入`npm install`，这时候，会自动安装好所有hexo依赖，包括hexo server服务，输入`hexo s`，这里的**s**即表示server服务。

服务开启之后，在浏览器端，可以直接输入`localhost:4000`进行Hexo博客网站的浏览，如果你能成功浏览，则说明前面的一切都没有问题，恭喜你，你的个人Hexo博客已经建立完成了。

总结一下，包括以下几步：

1. 在本地硬盘新建目录**MyHexoBlog**
2. 在该目录上右击，选择Git bash进入，依次输入：
2.1 hexo init
2.2 npm install
2.3 hexo s
3. 在本地浏览器地址栏输入`localhost:4000`验证

### Hexo博客的配置

#### 主配置

Hexo博客的主配置在**MyHexoBlog**目录下的**_config.yml**文件，选择某一文本编辑器(可以是nodepad++，也可以是sublime text，但不要用一般的记事本)打开。

下面介绍Hexo博客的一些主要配置。

```yaml
# Hexo Configuration
## Docs: http://hexo.io/docs/configuration.html
## Source: https://github.com/hexojs/hexo/

# Site 注意：后面的空格
title: "My blog"  # 网页标题
subtitle: "good good study, day day up!" # 显示在作者下面的副标题
description: "hello world" # 描述信息我也不知道显示在哪
author: "zhangsan" # 作者姓名
language: zh-CN # 网站语言
timezone: # 时区

# URL
## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
url: # 这里可以填写你的站点，后面会托管到github上，因此这里可以填写你的github URL
root: / # 主目录，目录树的形式
permalink: :year/:month/:day/:title/ # 这是新建博客的默认标签，最好不要更改
permalink_defaults:

# Directory
source_dir: source
public_dir: public # 这是要发布到github上的内容所生成的文件夹
tag_dir: tags
archive_dir: archives
category_dir: categories
code_dir: downloads/code
i18n_dir: :lang
skip_render:

# Writing
new_post_name: :title.md # File name of new posts
default_layout: post
titlecase: false # Transform title into titlecase
external_link: true # Open external links in new tab
filename_case: 0
render_drafts: false
post_asset_folder: false
relative_link: false
future: true
highlight:
  enable: true
  line_number: true
  auto_detect: true
  tab_replace:

# Category & Tag
default_category: uncategorized
category_map:
tag_map: [随笔, 杂念] # 你自己新建的标签

# Date / Time format
## Hexo uses Moment.js to parse and display date
## You can customize the date format as defined in
## http://momentjs.com/docs/#/displaying/format/
date_format: YYYY-MM-DD # 日期格式
time_format: HH:mm:ss # 时间格式

# Pagination
## Set per_page to 0 to disable pagination
per_page: 10 # 默认每页显示10篇文章
pagination_dir: page

# Extensions
## Plugins: http://hexo.io/plugins/
## Themes: http://hexo.io/themes/
theme: yilia # 主题可以自己选择自己喜欢的下载使用，我使用的是litten的yilia主题

# 以下是我安装的插件，主要支持rss订阅功能和google   Sitemap追踪功能
Plugins:
- hexo-generator-feed
- hexo-generator-sitemap

# Feed Atom
feed:
  type: atom
  path: atom.xml
  limit: 20

# sitemap
sitemap:
  path: sitemap.xml

# Deployment
## Docs: http://hexo.io/docs/deployment.html
# 发布到github上所需要填写的内容
deploy:
  type: git #发布器
  repo: git@github.com:username/username.github.io.git #使用git协议的仓库地址最快最好，username是你的github账号的用户名
  branch: master #分支，个人博客网站最好使用主分支
```

#### 修改主题

Hexo默认主题是landscape放置在MyHexoBlog主目录下的themes目录下。不敢说此主题很好看，所以一般都会换掉，网上有很多漂亮的Hexo主题可供下载使用，这里我选择的是litten的yilia主题，主题的下载其实很简单，只需要在MyHexoBlog目录右击的Git bash上，输入

> git clone https://github.com/litten/hexo-theme-yilia.git themes/yilia

然后在主配置文件中更改theme为yilia即可。

#### 主题配置

下载下来的yilia主题，其实我们也可以做很多配置，主题配置文件存在于themes/yilia/下，也是_config.yml文件，与主配置文件一样，进行你自己的定制就可以了。

这里介绍一个添加**fork me on github**到主题上的tip，进入themes/yilia/layout下，打开编辑layout.ejs文件，我所说的一切打开和编辑工作最好是在类似于notepad++或sublime text这种富文本编辑器中进行。在layout.ejs文件中的</body>标签之前加上下面这句：
```html
<a href="https://github.com/zbvae"><img style="z-index:9999; position: absolute; top: 0; left: 0; border: 0;" src="https://camo.githubusercontent.com/82b228a3648bf44fc1163ef44c62fcc60081495e/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f6c6566745f7265645f6161303030302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_left_red_aa0000.png"></a>
```

### 将Hexo博客发布到Github上

将本地新建好的Hexo博客发布到Github上，首先，你要在[Github](https://github.com)官网上，申请github账号，输入用户名和邮箱一定要谨慎，记住最好不要输入163邮箱了，本人亲身经历，163邮箱始终收不到github的验证邮件，导致开始建站一直访问不了，后面我只能重新新建了账户。

新建好github账户之后，需要在本地做一些安全性的配置(**以下输入的用户名和邮箱都要与申请github账号时输入的一致**)，主要有以下几个方面：

* 配置github全局用户名：`git config --global user.name "your username"`
* 配置github全局邮箱：`git config --global user.email "your email address"`
* 配置github ssh key：`ssh-keygen -t rsa -C "your email address"`

将此处生成的ssh key的公钥(具体位置在你生成之后会提示出来)，填写到github账户上的ssh key一栏。这样就完成了本地git与远程github服务器的关联。

要将本地Hexo博客发布到Github Pages，需要先创建远程仓库，直接在你的github页面下，选择create repository，这时，注意，你输入的仓库名，一定要是**username.github.io**(注意username与你的账户名对应)，主分支默认的github page页，每个账户唯一。创建好远程仓库之后，现在可以从本地发布博客了。

注意发布的配置选项已经在主配置中介绍过了。还是在MyHexoBlog上右击进入Git bash，由于默认的git发布工具没有安装，先输入`npm install hexo-deployer-git --save`安装git发布器。依次输入如下命令，完成博客发布：

- 输入`hexo clean` 先清空MyHexoBlog下的所有静态网页，即删除之前已经发布的public文件(第一次发布可以省略这一步)
- 输入`hexo g` 这里的**g**就是generate，意思是生成静态网页，即生成public文件夹
- 输入`hexo d` 这里的**d**就是deploy， 意思是发布到指定的仓库。

正常的话，现在你的github上默认用户名仓库就已经有了博客文件了，你可以在浏览器输入<https://username.github.io>进行访问(username与你账户名username对应)，若访问hexo博客成功，说明你本地的博客已经成功发布到github上了。

### 域名绑定

域名绑定的前提是，你已经有了自己的域名，域名的购买，你可以在godaddy网站上购买，大部分人都是在此网站上买的，我的域名是在阿里云买的，也很便宜，解析起来也很方便。

为了将你的域名绑定到github page，首先在本地输入`ping username.github.io`得到ip地址，然后登陆你的域名管理器(在哪买的，你就去哪吧)，添加解析，A类解析，@和www记录配套，输入上面得到的ip地址，完成。

<center> ![domain](/images/domain.png) </center>

最后一步工作就是，在你的远程仓库主目录下，新建CNAME文件，里面输入`你的域名`，注意这里的域名不需要任何如www等的前缀。

提交更改之后，点击右边的setting栏，下拉，看到Github Pages上，如果说你的页面被发布至你的域名下，那么你就成功了。