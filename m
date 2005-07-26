Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVGZXin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVGZXin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVGZXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:38:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262294AbVGZXg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:36:28 -0400
Date: Tue, 26 Jul 2005 16:35:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
Cc: mkrufky@m1k.net, linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
Message-Id: <20050726163521.73c7ed08.akpm@osdl.org>
In-Reply-To: <20050727012558.5661d071.astralstorm@gorzow.mm.pl>
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
	<42E692E4.4070105@m1k.net>
	<20050726221506.416e6e76.astralstorm@gorzow.mm.pl>
	<42E69C5B.80109@m1k.net>
	<20050726144149.0dc7b008.akpm@osdl.org>
	<20050727004932.1b25fc5d.astralstorm@gorzow.mm.pl>
	<20050726161149.0c9c36fa.akpm@osdl.org>
	<20050727012558.5661d071.astralstorm@gorzow.mm.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl> wrote:
>
> On Tue, 26 Jul 2005 16:11:49 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > All done - let me know if it needs anything else.
> > 
> 
> You got me with a tarball w/o a directory inside. Now I have to clean up the mess.
> Not the first time in life. I think I'll never learn. :)

I did?

bix:/home/akpm/.mm> tar tvfj broken-out-2005-07-26-15-07.tar.bz2 | head
-rw-r--r-- akpm/akpm     35426 2005-07-26 15:10:32 series
-rw-r--r-- akpm/akpm    593326 2005-07-26 12:46:37 patches/linus.patch
-rw-r--r-- akpm/akpm      3076 2005-07-16 14:28:43 patches/i2c-mpc-restore-code-removed.patch
-rw-r--r-- akpm/akpm       888 2005-07-16 14:28:45 patches/really-__nocast-annotate-kmalloc_node.patch
-rw-r--r-- akpm/akpm      3071 2005-07-26 00:37:34 patches/mips-fbdev-kconfig-fix.patch
-rw-r--r-- akpm/akpm      4097 2005-07-26 00:37:34 patches/max_user_rt_prio-and-max_rt_prio-are-wrong.patch
-rw-r--r-- akpm/akpm      2053 2005-07-26 00:39:53 patches/md-when-resizing-an-array-we-need-to-update-resync_max_sectors-as-well-as-size.patch
-rw-r--r-- akpm/akpm       946 2005-07-26 00:39:55 patches/uml-readd-missing-define-to-arch-um-makefile-i386.patch

