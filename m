Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUBAKfW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 05:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUBAKfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 05:35:22 -0500
Received: from witte.sonytel.be ([80.88.33.193]:43205 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265253AbUBAKfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 05:35:17 -0500
Date: Sun, 1 Feb 2004 11:35:05 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Timothy Miller <miller@techsource.com>
cc: John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
In-Reply-To: <40193A67.7080308@techsource.com>
Message-ID: <Pine.GSO.4.58.0402011123140.20933@waterleaf.sonytel.be>
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004, Timothy Miller wrote:
> John Bradford wrote:
> >>The real question we have to ask ourselves is, what would be the market
> >>demand for a graphics card that is 3 generations behind the state of the
> >>art and over-priced, the only advantage being that it's a 100% open
> >>architecture?
> >
> >
> > Err, well there are always the server and embedded markets, if the
> > device was cheap enough.
>
> Ah, but it won't be.  Low-volume ASICs are expensive.  The chip itself
> would probably be around $150, not counting $100k NRE.  Then you have to
> pay for the board, make up for the NRE, and make some profit to make it
> worth while.  How much are YOU willing to pay?

Then why are companies doing ASICs with an OpenRISC core?

> Whatever we design is going to be EXPENSIVE.  So, regardless of the fact
> that an ATI All-in-Wonder Radeon 9000 is over-powered for job you
> describe, that board will be cheaper than what we could produce.

And it's probably overpowered when speaking about power consumption, too...

Now think of a SoC with an OpenRISC core and an integrated graphics
controller...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
