Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVDVT7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVDVT7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVDVT7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 15:59:42 -0400
Received: from witte.sonytel.be ([80.88.33.193]:33435 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262122AbVDVT7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 15:59:40 -0400
Date: Fri, 22 Apr 2005 21:51:34 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       rth@twiddle.net, adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] Re: 2.6.12-rc3 compile failure in tgafb.c,
 tgafb not working anymore
In-Reply-To: <Pine.LNX.4.58.0504221051240.2344@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.62.0504221954410.24170@numbat.sonytel.be>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de>
 <20050422072858.GU607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi>
 <20050422144047.GY607@vega.lnet.lut.fi> <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
 <Pine.LNX.4.61L.0504221840180.27531@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58.0504221051240.2344@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2005, Linus Torvalds wrote:
> On Fri, 22 Apr 2005, Maciej W. Rozycki wrote:
> >  JFTR, a few of the TURBOchannel variations of the TGA are supported for 
> > MIPS, but regrettably the necessary code hasn't been ported from 2.4 to 
> > 2.6 yet.
> 
> Ok, so that would have increased the testing base by, what? One person or 
> two? I think we're still in single digits ;)

All the DEC UDB (`Multia') machines have builtin TGA.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
