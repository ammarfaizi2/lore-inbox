Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWCLVrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWCLVrr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWCLVrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:47:47 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:15563 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932261AbWCLVrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:47:46 -0500
From: Grant Coady <gcoady@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sam@ravenborg.org
Subject: Re: 2.6.16-rc6-mm1
Date: Mon, 13 Mar 2006 08:47:21 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <3j5912trf1d2rnjop60a9kfttjblabfiuo@4ax.com>
References: <20060312031036.3a382581.akpm@osdl.org>
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2006 03:10:36 -0800, Andrew Morton <akpm@osdl.org> wrote:

>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/

grant@sempro:~/linux/linux-2.6.16-rc6-mm1a$ make help
Cleaning targets:
  clean           - remove most generated files but keep the config
  mrproper        - remove all generated files + config + various backup files

Configuration targets:
  config          - Update current config utilising a line-oriented program
  menuconfig      - Update current config utilising a menu based program
  xconfig         - Update current config utilising a QT based front-end
  gconfig         - Update current config utilising a GTK based front-end
  oldconfig       - Update current config utilising a provided .config as base
  randconfig      - New config with random answer to all options
  defconfig       - New config with default answer to all options
  allmodconfig    - New config selecting modules when possible
  allyesconfig    - New config where all options are accepted with yes
  allnoconfig     - New config where all options are answered with no

Other generic targets:
  all             - Build all targets marked with [*]
* vmlinux         - Build the bare kernel
* modules         - Build all modules
  modules_install - Install all modules to INSTALL_MOD_PATH (default: /)
  dir/            - Build all files in dir and below
  dir/file.[ois]  - Build specified target only
  dir/file.ko     - Build module including final link
  rpm             - Build a kernel as an RPM package
  tags/TAGS       - Generate tags file for editors
  cscope          - Generate cscope index
  kernelrelease   - Output the release version string
  kernelversion   - Output the version stored in Makefile

Static analysers
  buildcheck      - List dangling references to vmlinux discarded sections
                    and init sections from non-init sections
  checkstack      - Generate a list of stack hogs
  namespacecheck  - Name space analysis on compiled kernel

Kernel packaging:
make[1]: *** No rule to make target `FORCE', needed by `help'.  Stop.
make: *** [help] Error 2

'make help' completes on 2.6.16-rc6

Grant.
