Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288684AbSADRAN>; Fri, 4 Jan 2002 12:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288686AbSADRAD>; Fri, 4 Jan 2002 12:00:03 -0500
Received: from mustard.heime.net ([194.234.65.222]:63666 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288684AbSADQ7v>; Fri, 4 Jan 2002 11:59:51 -0500
Date: Fri, 4 Jan 2002 17:59:32 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Error loading e1000.o - symbol not found
In-Reply-To: <E16MXpL-0004ld-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0201041758270.29475-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: unresolved symbol _mmx_memcpy
> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o failed
> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod e1000 failed
> >
> > What's this? Is _mmx_memcpy only valid on Intel architecture? Does Athlon
> > have any equivalent system call?
>
> Looks like you built the module against a different Athlon tree ?
>

What do you mean by a different Athlon tree?
I have only one kernel tree under /usr/src/, and I built the kernel and
rebooted first. I can even find _mmx_memcpy in System.map

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

