Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274366AbRITIJ1>; Thu, 20 Sep 2001 04:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274365AbRITIJS>; Thu, 20 Sep 2001 04:09:18 -0400
Received: from mail.sonytel.be ([193.74.243.200]:22260 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S274361AbRITIJI>;
	Thu, 20 Sep 2001 04:09:08 -0400
Date: Thu, 20 Sep 2001 10:08:03 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev config fixes (ac edition)
In-Reply-To: <E15jnOr-0003iD-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0109201007210.14835-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Alan Cox wrote:
> > Fix fbdev config glitches that were introduced recently:
> >   - Remove duplicate CONFIG_* section for DECstation
> >   - Remove duplicate initialization code for pmagbafb, pmagbbfb, and maxinefb
> 
> Please send those to Ralf@gnu.org not me

Will do. Note that the duplicates are not in Ralf's tree.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

