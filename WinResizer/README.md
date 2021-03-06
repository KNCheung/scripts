Windows窗口排列工具
======================

说明
--------

+ 适用系统：Win XP/7/8.1
+ 外部库：
    - [GDI+](http://www.autohotkey.com/board/topic/29449-gdi-standard-library-145-by-tic/) By tic (Tariq Porter)
    - [SmartGUI Creator](http://www.autohotkey.com/board/topic/738-smartgui-creator/) By Rajat
+ 编辑注释：建议使用Vim编辑并:set foldmethod=marker
+ 开发日志：
    - 2014.11.20 确认Win8.1可以正常使用，原因不明
    - 2013.01.06 使任务栏不在底部亦能正常使用
    - 2013.01.05 小修改，更改热键为Ctrl+Win+鼠标左键
    - 2013.01.02 小修改
    - 2012.12.29 修复一个严重的Bug
    - 2012.12.24 修复一个Bug
    - 2012.12.23 代码规范化
    - 2012.12.18 调整
    - 2012.12.17 调整
    - 2012.12.07 继续调试网格绘制，成功。但发现Bug。
    - 2012.12.06 在Autohotkey Forum寻找解决方案，得知有人已经写好直接调用GDI函数的函数（好别扭……），下载源码研究。（AHK多数开源）并试写网格绘制，失败。
    - 2012.12.05 继续研究DllCall与GDI，失败。
    - 2012.12.04 无电脑用，暂停。
    - 2012.12.03 开始写GDI，失败。
    - 2012.12.02 意识到API函数可直接被其他语言运用，于是重新查看Autohotkey帮助文档，发现DllCall函数。决定用AHK编写，构建框架、算法。开始写第一步，完成。
    - 2012.12.01 学习API的编写，知道有GDI。
    - 2012.11.30 到主校区图书馆找书，无意中见到API一词，于是找到《Windows API开发详解》。
    - 2012.11.29 首先想到用Autohotkey编写，但是发现没有绘图函数，GUI界面不好编写。后来想到用VC++编写。
    - 2012.11.27 在机房学习时发现窗口太多，屏幕不够用，不得不反复调整各窗口的大小及位置，表示相当抓狂。萌发窗口整理的想法。  

