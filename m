Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291311AbSAaVLM>; Thu, 31 Jan 2002 16:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291312AbSAaVLF>; Thu, 31 Jan 2002 16:11:05 -0500
Received: from mail.sonytel.be ([193.74.243.200]:46534 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291311AbSAaVKv>;
	Thu, 31 Jan 2002 16:10:51 -0500
Date: Thu, 31 Jan 2002 22:08:08 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>, mingo@elte.hu,
        Rob Landley <landley@trommello.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C59353F.3080208@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0201312205230.24581-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Martin Dalecki wrote:
> Alan Cox wrote:
> >>A "small stuff" maintainer may indeed be a good idea. The maintainer could
> >>be the same as somebody who does bigger stuff too, but they should be
> >>clearly different things - trivial one-liners that do not add anything
> >>new, only fix obvious stuff (to the point where nobody even needs to think
> >>about it - if I'd start getting any even halfway questionable patches from
> >>the "small stuff" maintainer, it wouldn't work).
> >>
> And then we are still just discussing here how to get things IN. But 
> there apparently currently is
> nearly no way to get things OUT of the kernel tree. Old obsolete drivers 
> used by some
> computer since archeologists should be killed (Atari, Amiga, support, 
> obsolete drivers and so on).
> Just let *them* maintains theyr separate kernel tree...

Come'on, m68k is not dead yet!

We do our best to keep the m68k tree in sync. In fact that's much less work
than feeding back our changes to Linus, since hacking code needs less retries
than sending patches :-)

(but we all know that since we're discussing it in this thread... ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

