Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264829AbRFXWOb>; Sun, 24 Jun 2001 18:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264828AbRFXWOV>; Sun, 24 Jun 2001 18:14:21 -0400
Received: from dial-10-194-apx-01.btvt.together.net ([209.91.3.194]:30082 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S264829AbRFXWOE>; Sun, 24 Jun 2001 18:14:04 -0400
Date: Sun, 24 Jun 2001 18:11:34 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: <wstearns@sparrow.websense.net>
Reply-To: William Stearns <wstearns@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Nilsson <pzycrow@hotmail.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <E15EHkU-0000Wu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106241806460.3807-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, John, Alan,

On Sun, 24 Jun 2001, Alan Cox wrote:

> > 4: make bzImage && make modules && make modules install && cp
> > arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig
>
> So really you want an outside GUI tool that lets you reconfigure build and
> install kernels. Yeah I'd agree with that. Someone just needs to write the
> killer gnome/kde config tool. I've got C code for parsing/loading config.in

	Buildkernel, at http://buildkernel.stearns.org .  It handles the
entire build process, from finger to lilo.
	Not a gui, alas, but certainly reduces the amount of effort
involved.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"She worked with a subdued intensity... She once told me that the
only way to know when you have done something truly great is when your
spine tingles."
	- on Alice Kober, cryptanalist, in The Code Book, Simon Singh.
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------


