Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312449AbSDEKN6>; Fri, 5 Apr 2002 05:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312446AbSDEKNs>; Fri, 5 Apr 2002 05:13:48 -0500
Received: from mail.sonytel.be ([193.74.243.200]:57761 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S312449AbSDEKNg>;
	Fri, 5 Apr 2002 05:13:36 -0500
Date: Fri, 5 Apr 2002 12:12:02 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Larry McVoy <lm@bitmover.com>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0204041720210.1546-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0204051211170.10408-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Linus Torvalds wrote:
> On Thu, 4 Apr 2002, Albert D. Cahalan wrote:
> > 
> > So then something like this...
> > 
> > alias ls='/bin/ls --ignore=SCCS'
> 
> Oh, that's very useful. Considering that everything else still finds them, 
> like find, shell autocompletion etc.
> 
> The only thing "--ignore=xxx" is useful for is hackers that want to break 
                                                 ^^^^^^^
> into your system and hide their files.

Ugh, this is linux-kernel! (cfr. signature)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

