Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbRFXWZx>; Sun, 24 Jun 2001 18:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265740AbRFXWZn>; Sun, 24 Jun 2001 18:25:43 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:3853 "EHLO mx3.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S264838AbRFXWZh> convert rfc822-to-8bit;
	Sun, 24 Jun 2001 18:25:37 -0400
Date: Mon, 25 Jun 2001 06:26:40 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: John Nilsson <pzycrow@hotmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
Message-ID: <Pine.LNX.4.33.0106250616290.204-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 24 Jun 2001, John Nilsson wrote:

> I have a Toshiba Portégé 3010CT laptop. That is:
> 266MHz Pentium-MMX
> 4GB HD with 512kb cache (which linux reduces to 0kb)
> 32 Mb EDO RAM

tons of info out there.

http://www.tce.co.jp/linux/
http://www.buzzard.org.uk/toshiba/
http://www.cs.utexas.edu/users/kharker/linux-laptop/
http://support.toshiba-tro.de/internet/info/linux/linleft.htm

I've a 3010CT too, and everything is working fine including X and the LAN
under linux.

> 8: A way to change kernel without rebooting. I have no diskdrive or cddrive
> in my laptop so I often do drastic things when I install a new distribution.

Look at loadlin + initrd. You'll have to reboot, but at least you don't
need a floppy and no CD. Store your test and stable kernels on dos C
drive, and boot up which ever one you like. I use a ramdisk to test my
kernels so that it does not affect my stable linux on my hard disk.

I do 80% of my stuffs on Linux including accessing mainframe from linux.

Jeff

