Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284684AbRLDAVI>; Mon, 3 Dec 2001 19:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284680AbRLDAPE>; Mon, 3 Dec 2001 19:15:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37285 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284395AbRLCKGn>;
	Mon, 3 Dec 2001 05:06:43 -0500
Date: Sun, 2 Dec 2001 21:35:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Victor Yodaiken <yodaiken@fsmlabs.com>,
        Andrew Morton <akpm@zip.com.au>, Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <Pine.LNX.4.33L.0112021528300.4079-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0112022117240.20031-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2 Dec 2001, Rik van Riel wrote:

> I think you've pretty much proven how well random
> development works.

i think it's fair to say that we should not increase entropy artificially,
eg. we should not apply randomly generated patches to the kernel tree.

the point is, we should accept the fact that while this world appears to
be governed by rules to a certain degree, the world is also chaotic to a
large degree, and that a Grand Plan That Explains Everything does not
exist. And even if it existed, we are very far away from achieving it, and
even if some friendly alien dropped it on our head, we'd very likely be
unable to get our 5 billion brain cells into a state that is commonly
referred to as 'fully grokking it'.

and having accepted these limitations, we should observe the unevitable
effects of them: that any human prediction of future technology
development beyond 5 years is very, very hypothetical, and thus we must
have some fundamental way of dealing with this unpredictability. (such as
trying to follow Nature's Smart Way Of Not Understanding Much But Still
Getting Some Work Done - called evolution.)

	Ingo

