Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbTL0LSy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 06:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbTL0LSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 06:18:54 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:8663 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265362AbTL0LSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 06:18:53 -0500
Date: Sat, 27 Dec 2003 19:19:16 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clean up fs/devfs/base.c
In-Reply-To: <Pine.LNX.4.44.0312261057100.4600-100000@raven.themaw.net>
Message-ID: <Pine.LNX.4.44.0312271916050.3256-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Ian Kent wrote:

> On Wed, 24 Dec 2003, Andrew Morton wrote:
> 
> > 
> > Yup, just whitespace fixes please.  I don't think I have the energy for a
> > big cleanup exercise right now, and it's not really appropriate.
> > 
> 
> OK. Got side tracked for a while.
> 
> White space only (just about) patch is on kernel.org at:
> 
> /pub/linux/kernel/perope/raven/devfs/linux-2.6.0-devfs-1.patch
> 
> It compiles, links and basic functionality tested OK with devfsd 
> 1.3.25, against 2.6.0.
> 

Have done a 2nd pass of devfs for 'almost white space only' changes.
It is in linux-2.6.0-devfs-2.patch. I have tested it as I did the first. 
It should be applied over the first.

Have run out of time now so that will have to be it for now.

Ian


