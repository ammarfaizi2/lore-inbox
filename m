Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266129AbRG1BjZ>; Fri, 27 Jul 2001 21:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbRG1BjR>; Fri, 27 Jul 2001 21:39:17 -0400
Received: from [209.195.52.30] ([209.195.52.30]:26654 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S266129AbRG1BjK>;
	Fri, 27 Jul 2001 21:39:10 -0400
Date: Fri, 27 Jul 2001 17:23:07 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <cw@f00f.org>, <ppeiffer@free.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT133A / athlon / MMX
In-Reply-To: <E15QEP3-0006TF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0107271718550.29714-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I have a 1u box at my des that has two MSI boards in it with 1.2G athlons.
at the moment they are both running 2.4.5 (athlon optimized), one box has
no problems at all while the other dies (no video, no keyboard, etc)
within an hour of being booted.

systems have no sound enabled, 512MB ram, 20G ata100 drives. D-Link quad
fast ethernet cards.

if you have any patch you would like me to test on these boxes let me know
(I am arranging to ship this one and three others like it that each have
one working and one failing system in them back to the factory to get the
MLB swapped out on the one that is failing.

David Lang


 On Fri, 27 Jul 2001, Alan Cox wrote:

> Date: Fri, 27 Jul 2001 21:40:09 +0100 (BST)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: cw@f00f.org
> Cc: alan@lxorguk.ukuu.org.uk, ppeiffer@free.fr, linux-kernel@vger.kernel.org
> Subject: Re: VIA KT133A / athlon / MMX
>
> > On Fri, Jul 27, 2001 at 09:19:21PM +0100, Alan Cox wrote:
> >     Its heavily tied to certain motherboards. Some people found a
> >     better PSU fixed it, others that altering memory settings
> >     helped. And in many cases, taking it back and buying a different
> >     vendors board worked.
> >
> > Does anyone know *why* stuff breaks? surely VIA do as they have a fix
> > for (some, all?) cases of breakage?
>
> At the moment the big problem is I don't have enough reliable info to
> see patterns that I can give to VIA for study. VIAs fixes for board problems
> are for the fifo problem normally seen with the 686B and SB Live but
> sometimes in other cases.
>
> (and it seems also we have a few via + promise weirdnesses on all sorts of
>  boards not yet explained)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
