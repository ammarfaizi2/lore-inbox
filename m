Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbRDQFku>; Tue, 17 Apr 2001 01:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132555AbRDQFkk>; Tue, 17 Apr 2001 01:40:40 -0400
Received: from aeon.tvd.be ([195.162.196.20]:25135 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S132553AbRDQFkV>;
	Tue, 17 Apr 2001 01:40:21 -0400
Date: Tue, 17 Apr 2001 07:39:14 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac7
In-Reply-To: <E14p860-00008u-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10104170738380.28549-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, Alan Cox wrote:
> o	Fix the Zoran driver build			(me)
> 	| This is still not up to date with the master copy
> 	| that is intentional - first things first.

Probably that's why drivers/media/video/Makefile contains references to
zoran.o, while zoran.c was ditched?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

