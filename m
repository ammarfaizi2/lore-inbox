Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbTADWDR>; Sat, 4 Jan 2003 17:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbTADWDR>; Sat, 4 Jan 2003 17:03:17 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:13309 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261545AbTADWDQ>;
	Sat, 4 Jan 2003 17:03:16 -0500
Date: Sat, 4 Jan 2003 23:11:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCHSET] Multiarch kconfig cleanup
In-Reply-To: <1041719964.2555.3.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0301042310210.10296-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2003, Alan Cox wrote:
> On Sat, 2003-01-04 at 20:24, Geert Uytterhoeven wrote:
> > > If I had my druthers, I would s/pcnet_cs/ne2k_cs/ too...  hmmmmmm  :)
> > 
> > And I guess you want to rename mac8390 (which just got renamed from daynaport
> > :-) to ne2k-nubus, too?
> 
> 8390 is the better name. ne2000 and ne/2 are specific product names.

So zorro8390 would be better than ne2k-zorro?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

