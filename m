Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281748AbRLBSPs>; Sun, 2 Dec 2001 13:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281739AbRLBSPi>; Sun, 2 Dec 2001 13:15:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:65183 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S276591AbRLBSPV>;
	Sun, 2 Dec 2001 13:15:21 -0500
Date: Sun, 2 Dec 2001 21:12:58 +0100 (CET)
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
Message-ID: <Pine.LNX.4.33.0112022102150.19739-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2 Dec 2001, Rik van Riel wrote:

> Note that this screams for some minimal kind of modularity on the
> source level, trying to limit the "magic" to as small a portion of the
> code base as possible.

Linux is pretty modular. It's not dogmatically so, nor does it attempt to
guarantee absolute or externally visible modularity, but most parts of it
are pretty modular.

> Also, natural selection tends to favour the best return/effort ratio,
> not the best end result. [...]

there is no 'effort' involved in evolution. Nature does not select along
the path we went. It's exactly this property why it took 5 billion years
to get here, while Linux took just 10 years to be built from grounds up.
The fact is that bacteria took pretty random paths for 2 billion years to
get to the next level. That's alot of 'effort'. So *once* we have
something that is better, it does not matter how long it took to get
there.

( This kind of 'development effort' is not the same as 'robustness', ie.
the amount of effort needed to keep it at the complexity level it is,
against small perturbations in the environment - but that is a different
kind of effort. )

> [...] Letting a kernel take shape due to natural selection pressure
> could well result in a system which is relatively simple, works well
> for 95% of the population, has the old cruft level at the upper limit
> of what's deemed acceptable and completely breaks for the last 5% of
> the population.

no. An insect that is 95.1% effective digesting banana leafs in the jungle
will completely eradicate a competing insect that is 95.0% effective
digesting banana leaves, within a few hundred generations. (provided both
insects have exactly the same parameters otherwise.) And it does not
matter whether it took 100 million years to get to 95.1%, or just one
lucky set of alpha particles hitting a specific DNA part of the original
insect.

	Ingo

