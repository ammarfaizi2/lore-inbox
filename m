Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269463AbRHLWLL>; Sun, 12 Aug 2001 18:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269457AbRHLWLB>; Sun, 12 Aug 2001 18:11:01 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:3852 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269455AbRHLWKs>; Sun, 12 Aug 2001 18:10:48 -0400
Date: Sun, 12 Aug 2001 15:10:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Manuel McLure <manuel@mclure.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
In-Reply-To: <E15W1eR-000691-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108121509310.974-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Aug 2001, Alan Cox wrote:
>
> so I think Linus should do the only sane thing - back it out. I'm backing
> it out of -ac. Of my three boxes, one spews noise, one locks up smp and
> one works.

The problem with backing it out is that apparently nobody has tried to
really maintain it for a year, and if it gets backed out nobody will even
bother to try to fix it. So I'll let it be for a while, at least.

		Linus

