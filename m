Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSLBWL4>; Mon, 2 Dec 2002 17:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbSLBWL4>; Mon, 2 Dec 2002 17:11:56 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:57870 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265066AbSLBWLz>; Mon, 2 Dec 2002 17:11:55 -0500
Date: Mon, 2 Dec 2002 22:18:57 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Tobias Rittweiler <inkognito.anonym@uni.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [STATUS] fbdev api.
In-Reply-To: <9814769328.20021202225728@uni.de>
Message-ID: <Pine.LNX.4.44.0212022214400.20834-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> JS> I have a new patch avaiable. It is against 2.5.50. The patch is at
> JS> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> JS> [...]
> JS> The diffstat is:
> 
> JS>  CREDITS                                |   10 
> 
> Hunk #1 succeeded at 2836 (offset -6 lines).
> 
> JS>  [...]
> JS>  arch/i386/vmlinux.lds.s                |  114
>                ^^^^^^^^^^^^^^
> really intended?
> 
> JS>  [...]
> JS>  drivers/char/tty_io.c                  |    7
> 
> Hunk #1 succeeded at 1503 (offset -6 lines).
> 
> JS>  [...]
> JS>  drivers/video/Kconfig                  |  411 --
> 
> Hunk #19 succeeded at 864 with fuzz 1 (offset -7 lines).

It does work but I made the patch against Linus tree with a few extra 
fixes due to the pci/quirks bug. I will post a exact patch.



