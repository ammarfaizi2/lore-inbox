Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRCHQYx>; Thu, 8 Mar 2001 11:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbRCHQYo>; Thu, 8 Mar 2001 11:24:44 -0500
Received: from aeon.tvd.be ([195.162.196.20]:30342 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S129191AbRCHQYe>;
	Thu, 8 Mar 2001 11:24:34 -0500
Date: Thu, 8 Mar 2001 17:21:32 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Steven Cole <scole@lanl.gov>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] remove CONFIG_NCR885E from Configure.help
In-Reply-To: <01030808522000.01048@spc.esa.lanl.gov>
Message-ID: <Pine.LNX.4.05.10103081720460.924-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Steven Cole wrote:
> It appears that use of CONFIG_NCR885E was removed in 2.4.2-ac2,
> in Config.in and the Makefile in drivers/net.
> 
> If it really is the case that CONFIG_NCR885E is history, then it
> should be history in Configure.help as well.

I'm still wondering whether there really are no other boards with a Sym53c885
than the Synergy PPC board (which is no longer supported).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

