Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUIZT5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUIZT5I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUIZT5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 15:57:08 -0400
Received: from witte.sonytel.be ([80.88.33.193]:21465 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262406AbUIZT5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 15:57:05 -0400
Date: Sun, 26 Sep 2004 21:56:59 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tonnerre <tonnerre@thundrix.ch>
cc: Olivier Galibert <galibert@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: __initcall macros and C token pasting
In-Reply-To: <20040926172429.GA15441@thundrix.ch>
Message-ID: <Pine.GSO.4.61.0409262155040.8756@waterleaf.sonytel.be>
References: <9e47339104092510574c908525@mail.gmail.com>
 <20040925183234.GU23987@parcelfarce.linux.theplanet.co.uk>
 <9e473391040925121774e7e1e1@mail.gmail.com> <20040926172104.GA44528@dspnet.fr.eu.org>
 <20040926172429.GA15441@thundrix.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2004, Tonnerre wrote:
> Actually, lots  of drivers  that *are* in  the kernel are  pretty much
> broken.

I don't disagree with that...

> And I don't  think putting more drivers into  the mainline kernel will
> fix this problem.

But the One True Path to guaranteed brokenness somewhere in time leads through
drivers that are not in the standard kernel tree...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
