Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266211AbUGTT1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUGTT1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266179AbUGTTYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:24:31 -0400
Received: from witte.sonytel.be ([80.88.33.193]:22713 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266206AbUGTTNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:13:42 -0400
Date: Tue, 20 Jul 2004 21:13:34 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] JFFS2 compression dependency
In-Reply-To: <1090349312.4189.7.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0407202112510.24931@waterleaf.sonytel.be>
References: <200407201839.i6KIdt5h015565@anakin.of.borg>
 <1090349312.4189.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004, David Woodhouse wrote:
> On Tue, 2004-07-20 at 20:39 +0200, Geert Uytterhoeven wrote:
> > JFFS2: Advanced compression options for JFFS2 should depend on JFFS2
>
> Thanks. I think that's the third time it's been sent. Waiting at
> bk://linux-mtd.bkbits.net/mtd-2.6 to be pulled...

Oops, sorry. Forgot to check which issues were already reported on lkml...
Well, just ignore the duplicates ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
