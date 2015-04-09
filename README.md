br2-flops.ru
============

This is project-specific overlay of [Buildroot](http://buildroot.uclibc.org/).

cNoNim.Name
-----------

I use Buildroot for personal VPS server hosted on FLOPS.ru.

Getting Buildroot
-----------------

You should download [latest daily snapshot](http://buildroot.uclibc.org/downloads/snapshots/buildroot-snapshot.tar.bz2) or make a clone of git [repository](git://git.buildroot.net/buildroot). Refer to the [Download page](http://buildroot.uclibc.org/download.html) of the Buildroot website for more details.

Installation
------------

Project supports building out of Buildroot tree. Everything built by Buildroot is stored in the directory `output` in the project tree. To use it, you can use the following make command:

	make BR2_EXTERNAL=$PWD O=$PWD/output -C <path to buildroot> flops.ru_defconfig

For ease of use, Buildroot generates a Makefile wrapper in the output directory - so after the first run, you can simple run:

	make -C output <target>

And follow [Buildroot documentation](http://buildroot.uclibc.org/docs.html).
