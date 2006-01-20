Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWATIxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWATIxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWATIxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:53:51 -0500
Received: from witte.sonytel.be ([80.88.33.193]:11152 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750751AbWATIxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:53:50 -0500
Date: Fri, 20 Jan 2006 09:52:29 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jes Sorensen <jes@sgi.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       linux-m68k@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: License oddity in some m68k files
In-Reply-To: <yq0d5in72vw.fsf@jaguar.mkp.net>
Message-ID: <Pine.LNX.4.62.0601200946110.29240@pademelon.sonytel.be>
References: <20060119180947.GA25001@kroah.com> <1137706812.8471.51.camel@localhost.localdomain>
 <yq0d5in72vw.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, Jes Sorensen wrote:
> >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> Alan> On Iau, 2006-01-19 at 10:09 -0800, Greg KH wrote:
> >> Someone recently pointed out to me the following wording on some of
> >> the m68k files that reads:
> >> 
> >> | Copyright (C) Motorola, Inc. 1990 | All Rights Reserved
> 
> Alan> You'll need to dig back through the archives but this was
> Alan> discussed and resolved when the M68K merge was done or shortly
> Alan> afterwards. There is no obvious problem with the licenses
> Alan> either. I believe Jes Sorensen did the merge in question.
> 
> Actually, I think the fpsp040 stuff goes back way further than
> that. To the days when Hamish was in charge.

Indeed. '040 support was added in early 1994. I still remember running
uncached on '040, yielding 1.5 BogoMIPS ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
