Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWJPSAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWJPSAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWJPSAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:00:21 -0400
Received: from witte.sonytel.be ([80.88.33.193]:19607 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1161050AbWJPSAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:00:20 -0400
Date: Mon, 16 Oct 2006 20:00:15 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Gross, Mark" <mark.gross@intel.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: RE: config TELCLOCK
In-Reply-To: <5389061B65D50446B1783B97DFDB392D030B5000@orsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.62.0610161959490.18451@pademelon.sonytel.be>
References: <5389061B65D50446B1783B97DFDB392D030B5000@orsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006, Gross, Mark wrote:
> Sure, the telcom clock is currently only on the MPCBL0010.  
> http://www.intel.com/design/telecom/products/cbp/atca/9445/overview.htm
> 
> It's i386/x86_64 capable platform.
> 
> Does this help?

Thanks! That's exactly what I wanted to know. I'll send a patch.

> >-----Original Message-----
> >From: geert@linux-m68k.org [mailto:geert@linux-m68k.org]
> >Sent: Sunday, October 15, 2006 2:51 AM
> >To: Gross, Mark
> >Cc: Linux Kernel Development
> >Subject: config TELCLOCK
> >
> >	Hi Mark,
> >
> >Can you tell us on which platforms the `Telecom clock driver for
> MPBL0010 ATCA
> >SBC' is used, so we can add proper dependencies to
> drivers/char/Kconfig?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
