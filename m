Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbUJ1Lvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUJ1Lvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUJ1LsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:48:09 -0400
Received: from witte.sonytel.be ([80.88.33.193]:12698 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262976AbUJ1Lks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:40:48 -0400
Date: Thu, 28 Oct 2004 13:40:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Giuliano Pochini <pochini@denise.shiny.it>,
       Timothy Miller <miller@techsource.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
In-Reply-To: <20041028093752.GB13523@hh.idb.hist.no>
Message-ID: <Pine.GSO.4.61.0410281339510.7058@waterleaf.sonytel.be>
References: <4176E08B.2050706@techsource.com> <1098442636l.17554l.0l@hh>
 <20041025152921.GA25154@thundrix.ch> <417D216D.1060206@techsource.com>
 <Pine.LNX.4.58.0410251825480.16966@denise.shiny.it> <20041028093752.GB13523@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Helge Hafting wrote:
> Or one could go the other way - if we use 32 bits, then
> consider 10 bits per color.  I've always wondered about the purpose
> of a 8-bit alpha channel.  what exactly is supposed to show
> in "transparent" places?  Transparency makes sense when talking about 
> windows - you see the underlying window through a transparent spot.
> But this is the frame buffer we're talking about - what is
> supposed to be behind that?  Another frame buffer?

Possibly. Or a life video plane.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
