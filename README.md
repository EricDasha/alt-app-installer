# 替代应用安装器

一款用于下载并安装微软应用商店应用的程序，命令行版本请查看[替代应用安装器命令行版](https://github.com/mjishnu/alt-app-installer-cli)

# 功能特性

- 无需微软应用商店或应用安装器即可下载并安装微软应用商店UWP应用（appx、msix、eappx、appxbundle等格式）
- 支持下载微软应用商店中的非UWP应用
- 自动根据系统架构（x64/x32）下载最新版本
- 优先下载[Appx,Msix,appxbundle...]格式，而非需管理员权限安装的加密格式（如Eappx）
- 可安装已下载的微软应用商店应用（appx,msix,appxbundle...）
- 支持通过提供URL获取微软商店应用
- 采用自定义链接生成机制，基于[StoreLib](https://github.com/StoreDev/StoreLib)与[MS-Store-API](https://github.com/ThomasPe/MS-Store-API)接口生成下载链接
- 采用基于[pypdl](https://github.com/mjishnu/pypdl)的[并行/多段下载器](https://stackoverflow.com/questions/93642/how-do-download-accelerators-work)实现高速下载
- 支持中断下载任务的续传
- 当前网址失效时自动切换新网址
- 下载并安装应用及所有依赖项

# 工作原理

- 应用打开浏览器，用户选择需安装的文件（应用/游戏）并返回其网址
- 解析网址获取产品密钥，通过Microsoft-Display-Catalog-API查询类别ID及文件名 
- 基于上述数据向Microsoft-Delivery-Optimization-service-API发送请求获取应用数据，并根据以下条件进一步解析：
    - 用户系统架构（x64/x32）
    - 优先类型（可直接安装的解密文件格式，无需管理员权限）
    - 最新版本
- 随后通过API获取解析数据的下载链接，并使用[pypdl](https://github.com/mjishnu/pypdl)进行文件下载。该工具支持并行/分段下载以提升速度，具备中断下载续传功能，并在当前链接失效时自动切换新URL。
- 最后通过Subprocess模块安装下载文件

<img width="1060" alt="1-min" src="https://user-images.githubusercontent.com/83004520/226940878-11cfb8ca-074e-4876-8a38-142559f5116b.png">
<img width="1060" alt="2-min" src="https://user-images.githubusercontent.com/83004520/226940893-f4f01e91-2d0c-4231-b1a2-27653d6ac164.png">
<img width="1060" alt="3-min" src="https://github.com/mjishnu/alt-app-installer/assets/83004520/325e4b8f-f026-4e83-8055-b7defc3adcf5">

# 系统要求
- Windows 10/11
- 网络连接

# 使用指南
- 下载“alt app installer.exe”并运行，或从源代码编译
- 在解压后的文件夹（“alt app installer”文件夹）中打开“alt app installer.exe”并运行（首次运行可能耗时较长）
- 点击“选择应用”，搜索目标应用，页面完全加载后点击顶部栏“选择”按钮
- 等待安装完成，随后在开始菜单中查找应用
- 也可通过“选项”菜单中的“从文件安装”安装已下载的应用
- 还可通过“选项”菜单中的“从链接获取”手动粘贴应用网址进行安装

# 如何从源代码构建

- 安装 [git](https://git-scm.com/download/win)
- 打开git bash终端运行命令 `git clone https://github.com/mjishnu/alt-app-installer`
- 安装python3和pip，进入克隆目录后执行命令 `pip install -r requirements.txt`
- 在克隆目录中运行“run.bat”或执行命令`.\run`
- 尽情使用吧！

## 中文化与打包（Windows）

- 运行（中文界面）：双击`run.bat`
- 打包：双击`build.bat`，输出路径为`dist/Alt App Installer CN/`
- 打包包含资源：`app/data/images` 与 `app/data/xml`

# 视频教程

https://youtu.be/ayIilTc-6u4

# 常见问题

- 如何解决依赖安装失败？

    部分情况下，此问题源于依赖项已在您的电脑上安装。请通过开始菜单检查程序是否已安装。
    若仍未安装，可通过两种方式解决。**[仅当第一种方法失败时尝试第二种]**
    1. 启用忽略版本（选项 --> 高级 --> 依赖项 --> 忽略版本），这将下载系统支持的所有依赖项版本
    2. 启用忽略所有过滤器（选项 → 高级 → 依赖项 → 忽略所有过滤器），此操作将下载所有可用依赖项（可能耗时较长）

- 其他问题处理
    
    您可提交问题报告或直接通过[Discord](https://discord.gg/9eeN2Wve4T)联系我

# 致谢

- [StoreLib](https://github.com/StoreDev/StoreLib)：下载链接生成API
- [pypdl](https://github.com/mjishnu/pypdl)：下载器
- [MS-Store-API](https://github.com/ThomasPe/MS-Store-API)：下载链接生成API
- [mjishnu](https://github.com/mjishnu/alt-app-installer)：原项目作者
