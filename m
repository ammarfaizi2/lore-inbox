Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUCWQOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 11:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbUCWQOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 11:14:18 -0500
Received: from witte.sonytel.be ([80.88.33.193]:30915 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262744AbUCWQOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 11:14:14 -0500
Date: Tue, 23 Mar 2004 17:13:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan De Luyck <lkml@kcore.org>
cc: Sven Luther <sven.luther@wanadoo.fr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kronos <kronos@kronoz.cjb.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
In-Reply-To: <200403231701.19786.lkml@kcore.org>
Message-ID: <Pine.GSO.4.58.0403231712560.8977@waterleaf.sonytel.be>
References: <20040320174956.GA3177@dreamland.darkstar.lan>
 <200403231211.09334.lkml@kcore.org> <20040323122627.GA22830@lambda>
 <200403231701.19786.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004, Jan De Luyck wrote:
> On Tuesday 23 March 2004 13:26, Sven Luther wrote:
> > > - From a users point of view: if there are only to be framebuffer devices
> > > listed in this class, why not call it just what it is: "Framebuffer" ?
> > > Naming it after something it is only in a broad sense makes no sense to
> > > me. I'd be looking in /sys/.../framebuffer instead of /sys/.../graphics
> > > or /display.
> >
> > Notice that /display is what is used by most OF implementations, so this
> > kinda makes sense. I would vote like BenH on this if i was consulted.
>
> OF implementations?

Open Firmware

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
