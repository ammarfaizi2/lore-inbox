Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262082AbREQRcE>; Thu, 17 May 2001 13:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbREQRbo>; Thu, 17 May 2001 13:31:44 -0400
Received: from hood.tvd.be ([195.162.196.21]:40181 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S262082AbREQRbd>;
	Thu, 17 May 2001 13:31:33 -0400
Date: Thu, 17 May 2001 19:29:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Tim Jansen <tim@tjansen.de>, t.sailer@alumni.ethz.ch,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105171009180.13202-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.05.10105171929150.15637-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, James Simmons wrote:
> > No, there is another addressing scheme that can be for devices without serial 
> > number: the vendor and product ids. Most people do not have two devices of 
> > the same kind, so you often do not need the topology at all.
> 
> I wouldn't make that assumpation. I have two PS/2 keybaords attached to my
> system and they don't have serial ids nor do they have vendor or product
> ids.

Yes. And it's the hardcore users who have multiple devices of the same kind.
Think e.g. RAID.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

