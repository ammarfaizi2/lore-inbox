Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbREPH0n>; Wed, 16 May 2001 03:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbREPH0e>; Wed, 16 May 2001 03:26:34 -0400
Received: from hood.tvd.be ([195.162.196.21]:34038 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S261806AbREPH0X>;
	Wed, 16 May 2001 03:26:23 -0400
Date: Wed, 16 May 2001 09:24:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.05.10105160923370.23225-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Linus Torvalds wrote:
> On Tue, 15 May 2001, Jonathan Lundell wrote:
> > 2 (disk domain). I have multiple spindles on multiple SCSI adapters. 
> 
> So? Same deal. You don't have eth0..N, you have disk0..N. 
> 
> What's the problem? It's _repeatable_, in that as long as you don't change
> your disks, they'll show up the same way. But the 0..N doesn't imply that
> the disks are anywhere special.

Are FireWire (and USB) disks always detected in the same order? Or does it
behave like ADB, where you never know which mouse/keyboard is which
mouse/keyboard?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

