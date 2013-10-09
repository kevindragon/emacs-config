emacs-config
============

My Emacs configurations


* 查看图片
可以先在运行下面几个语句检查一下是否已经支持了图片
(image-type-available-p 'gif)
(image-type-available-p 'jpeg)
(image-type-available-p 'tiff)
(image-type-available-p 'xbm)
(image-type-available-p 'xpm)

把以下dlls目录下面的DLL文件拷贝到EMACS安装目录的BIN目录下，就可以显示图片了。
jpeg62.dll libgcrypt-11.dll libgnutls-26.dll libpng14-14.dll libtasn1-3.dll libtiff3.dll libungif4.dll libXpm.dll xpm4.dll zlib1.dll

这些文件都可以在
http://gnuwin32.sourceforge.net/packages.html