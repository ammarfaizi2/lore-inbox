Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264544AbRFMFht>; Wed, 13 Jun 2001 01:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264547AbRFMFhk>; Wed, 13 Jun 2001 01:37:40 -0400
Received: from hood.tvd.be ([195.162.196.21]:11595 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S264544AbRFMFhV>;
	Wed, 13 Jun 2001 01:37:21 -0400
Date: Wed, 13 Jun 2001 07:31:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Sergey Tursanov <__gsr@mail.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: PC keyboard rate/delay
In-Reply-To: <Pine.LNX.4.10.10106121056080.12879-100000@transvirtual.com>
Message-ID: <Pine.LNX.4.05.10106130730470.12278-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, James Simmons wrote:
> > Because (almost?) all m68k machines don't have PC style keyboard controllers,
> > so we _had_ to invent some other way to implement it in a portable (across all
> > m68k machines) way.
> 
> This stuff is such a mess :-( Sparc has its own routines as well. 

Ours is older :-)

> > <wishful thinking>
> > Of course it would be nice if all architectures would want to use it.
> > </wishful thinking>
> 
> It will for 2.5.X :-)

Good!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

