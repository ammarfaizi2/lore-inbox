Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271189AbRHQU0S>; Fri, 17 Aug 2001 16:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271584AbRHQU0J>; Fri, 17 Aug 2001 16:26:09 -0400
Received: from [194.213.32.142] ([194.213.32.142]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S271333AbRHQUZ5>;
	Fri, 17 Aug 2001 16:25:57 -0400
Date: Thu, 16 Aug 2001 23:28:15 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Manuel McLure <manuel@mclure.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Message-ID: <20010816232814.A38@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0108121509310.974-100000@penguin.transmeta.com> <E15W3ZC-0006IC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15W3ZC-0006IC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Aug 12, 2001 at 11:18:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The problem with backing it out is that apparently nobody has tried to
> > really maintain it for a year, and if it gets backed out nobody will even
> > bother to try to fix it. So I'll let it be for a while, at least.
> 
> I thought this was a stable kernel tree not 2.5 ?

Oops while *using* the driver seem to be much less severe than random
lockups when *NOT* using driver. According to ESR, 2.4.7 is doing the 
latter.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

