Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBNQz7>; Wed, 14 Feb 2001 11:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBNQzs>; Wed, 14 Feb 2001 11:55:48 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:51448 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129078AbRBNQzp>; Wed, 14 Feb 2001 11:55:45 -0500
Date: Wed, 14 Feb 2001 10:55:42 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200102140609.f1E69Bc346946@saturn.cs.uml.edu>
In-Reply-To: <3A89F1A5.7050603@bellsouth.net> from "Louis Garcia" at Feb 13, 2001 09:47:01 PM
Subject: Re: Video drivers and the kernel
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <X5ggNB.A.j8E.Piri6@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Albert D. Cahalan" <acahalan@cs.uml.edu> on Wed, 14
Feb 2001 01:09:10 -0500 (EST)


> Both options cause political troubles. Currently the X server is
> shared with OS/2 and other crummy systems. If the Linux kernel had
> serious video drivers for PC hardware, then driver support for the
> other operating systems would mostly go away. Linux would become
> a better desktop OS, at the expense of various crummy systems.

First of all, I'm object to calling OS/2 a "crummy system".  There are still
some things that OS/2 can do better than Linux.  But I don't want to get into a
flame war.  

More importantly, just because the drivers move into the kernel doesn't mean
that other OS's can't be supported.  A video driver could be compiled for the
kernel on Linux, but be compiled as something else for other OS's.  In fact, on
OS/2, a special driver is provided with XFree86 that effectively allows the X
Server to run with the same capabilities as an OS/2 device driver.  In fact, by
strict standards, it's a security and reliability loophole, but it still works
pretty well.

So I wouldn't worry about OS/2.  If we can port your audio drivers, we can port
anything.

xBSD, on the other hand, ....


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

