Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUI0Q1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUI0Q1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUI0Q1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:27:46 -0400
Received: from witte.sonytel.be ([80.88.33.193]:8400 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266486AbUI0Q1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:27:43 -0400
Date: Mon, 27 Sep 2004 18:27:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm4
In-Reply-To: <200409271206.01753.gene.heskett@verizon.net>
Message-ID: <Pine.GSO.4.61.0409271825560.17228@waterleaf.sonytel.be>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409271131.27329.gene.heskett@verizon.net>
 <200409270852.44366.lkml@lpbproductions.com> <200409271206.01753.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Gene Heskett wrote:
> On Monday 27 September 2004 11:52, Matt Heler wrote:
> >On Monday 27 September 2004 8:31 am, Gene Heskett wrote:
> >> ones to be effected, so lets compare notes:
> >>
> >> AMD Athlon 2800xp, biostar N7-NCD-Pro motherboard with an nforce2
> >> chipset, and using the forcedeth driver for eth0.  A gigabyte of
> >> DDR400 rated ram running in DDR333 dual channel mode, the 2800xp
> >> Athlon can't handle the DDR400 fsb correctly. No acpi is enabled,
> >> and apm only for shutdown control & rtc handling.
> >
> >Simular system here. Athlon 3000xp , with nforce2 chipset.
> 
> Can your athlon 3000xp do the DDR400 setting for the fsb?

JFYI, my XP2800+ with VIA KT600 cannot handle 2 DDR400 DIMMs neither, so I run
them at 333. But according to memtest86, the speed difference is small (< 4%).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
