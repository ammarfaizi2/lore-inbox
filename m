Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTDHThN (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTDHThN (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:37:13 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:29653 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S261649AbTDHThM (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:37:12 -0400
Date: Tue, 8 Apr 2003 21:48:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Buesch <freesoftwaredeveloper@web.de>
cc: =?iso-8859-2?q?Pawe=B3=20Go=B3aszewski?= <blues@ds.pg.gda.pl>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.67] gen_rtc compile error
In-Reply-To: <200304082120.39576.freesoftwaredeveloper@web.de>
Message-ID: <Pine.GSO.4.21.0304082147530.21559-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003, Michael Buesch wrote:
> On Tuesday 08 April 2003 20:37, Pawe³ Go³aszewski wrote:
> > When I try to build my kernel I get:
> >
> > [...]
> >
> > My kernel configuration:
> > http://piorun.ds.pg.gda.pl/~blues/config-2.5.67.txt
> 
> Battery status seems to be not available on all architectures.
> (I don't know the reason for this.)
> With this patch, it should compile (against 2.5.67):

Please use the patch I mailed to lkml last month, and which got reposted by
other people.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

