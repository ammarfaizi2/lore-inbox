Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbTADUPi>; Sat, 4 Jan 2003 15:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTADUPi>; Sat, 4 Jan 2003 15:15:38 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:35312 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261371AbTADUPh>;
	Sat, 4 Jan 2003 15:15:37 -0500
Date: Sat, 4 Jan 2003 21:24:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCHSET] Multiarch kconfig cleanup
In-Reply-To: <3E14C6D4.1040506@pobox.com>
Message-ID: <Pine.GSO.4.21.0301042122590.10261-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, Jeff Garzik wrote:
> Geert Uytterhoeven wrote:
> > linux-m68k: Should we kill CONFIG_NE2K_ZORRO, or kill CONFIG_ARIADNE2 and
> > rename the driver to ne2k-zorro.c?
> 
> I'm not linux-m68k, but let me add my small voice in preference to the 
> latter, using ne2k-zorro as the name across the board.
> 
> If I had my druthers, I would s/pcnet_cs/ne2k_cs/ too...  hmmmmmm  :)

And I guess you want to rename mac8390 (which just got renamed from daynaport
:-) to ne2k-nubus, too?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

