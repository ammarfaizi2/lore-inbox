Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283903AbRLADWA>; Fri, 30 Nov 2001 22:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283905AbRLADVu>; Fri, 30 Nov 2001 22:21:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:783 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283903AbRLADVe>; Fri, 30 Nov 2001 22:21:34 -0500
Date: Fri, 30 Nov 2001 19:15:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <20011130200239.A28131@hq2>
Message-ID: <Pine.LNX.4.33.0111301907010.1296-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Nov 2001, Victor Yodaiken wrote:
>
> > And don't EVER make the mistake that you can design something better than
> > what you get from ruthless massively parallel trial-and-error with a
> > feedback cycle. That's giving your intelligence _much_ too much credit.
>
> Linux is what it is because of design, not accident. And you know
> that better than anyone.

Let's just be honest, and admit that it wasn't designed.

Sure, there's design too - the design of UNIX made a scaffolding for the
system, and more importantly it made it easier for people to communicate
because people had a mental _model_ for what the system was like, which
means that it's much easier to discuss changes.

But that's like saying that you know that you're going to build a car with
four wheels and headlights - it's true, but the real bitch is in the
details.

And I know better than most that what I envisioned 10 years ago has
_nothing_ in common with what Linux is today. There was certainly no
premeditated design there.

And I will claim that nobody else "designed" Linux any more than I did,
and I doubt I'll have many people disagreeing. It grew. It grew with a lot
of mutations - and because the mutations were less than random, they were
faster and more directed than alpha-particles in DNA.

> The question is whether Linux can still be designed at
> current scale.

Trust me, it never was.

And I will go further and claim that _no_ major software project that has
been successful in a general marketplace (as opposed to niches) has ever
gone through those nice lifecycles they tell you about in CompSci classes.
Have you _ever_ heard of a project that actually started off with trying
to figure out what it should do, a rigorous design phase, and a
implementation phase?

Dream on.

Software evolves. It isn't designed. The only question is how strictly you
_control_ the evolution, and how open you are to external sources of
mutations.

And too much control of the evolution will kill you. Inevitably, and
without fail. Always. In biology, and in software.

Amen.

		Linus

