Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283565AbRK3IqY>; Fri, 30 Nov 2001 03:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283567AbRK3IqO>; Fri, 30 Nov 2001 03:46:14 -0500
Received: from mail.sonytel.be ([193.74.243.200]:8117 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S283565AbRK3IqB>;
	Fri, 30 Nov 2001 03:46:01 -0500
Date: Fri, 30 Nov 2001 09:44:57 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        linuxconsole-dev@lists.sourceforge.net,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hooks for new fbdev api
In-Reply-To: <Pine.LNX.4.10.10111291005200.2693-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0111300944380.14081-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, James Simmons wrote:
> > >From what you wrote I assume that cmap.start must be 0 and cmap.len
> > some length, and it must be always set, as otherwise it is impossible
> > to guess image/mask depth from it.
> 
> [snip]...
> 
> I figured the cursor stuff would be something to work out more. I
> shamefully stoled it from the sun fb implementation. I have another patch
> patch for fb.h which removes the cursor stuff until we work something out.
> 
> 
> Geert if I have your blessing on this I like to send it off to Linus.

You have ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

