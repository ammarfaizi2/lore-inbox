Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265789AbRFXXOb>; Sun, 24 Jun 2001 19:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265788AbRFXXOW>; Sun, 24 Jun 2001 19:14:22 -0400
Received: from Expansa.sns.it ([192.167.206.189]:1297 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S265787AbRFXXOL>;
	Sun, 24 Jun 2001 19:14:11 -0400
Date: Mon, 25 Jun 2001 01:14:07 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: John Nilsson <pzycrow@hotmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
Message-ID: <Pine.LNX.4.33.0106250107450.1314-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Nilson wrote:

> 2: Compile time optimization options in Make menuconfig
???? I do not understand the point.

> 3: Lilo/grub config in make menuconfig
Unusefull and dangerous.

> 4: make bzImage && make modules && make modules install && cp
> arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig
To compile a kernel someone should be able to run correctly make. Don't
you think so? Also my girlfriend, who never saw a Unix system before,
after a couple days spended reading during free time some documentation
and help files (4 hours in two days I think) has been able to compile and
install a new kernel.

> 6: Wouldn't it be easier for svgalib/framebuffer/GGI/X11 and others if the
> graphiccard drivers where kernel modules?
This is an old discussion. I hope it will never be. (just my own 2 cents).

> 8: A way to change kernel without rebooting. I have no diskdrive or cddrive
> in my laptop so I often do drastic things when I install a new distribution.
Is it possible at all??

Luigi

