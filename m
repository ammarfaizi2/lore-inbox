Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283929AbRLAExx>; Fri, 30 Nov 2001 23:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283944AbRLAExa>; Fri, 30 Nov 2001 23:53:30 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:46607 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S283942AbRLAEvN>;
	Fri, 30 Nov 2001 23:51:13 -0500
Date: Fri, 30 Nov 2001 21:44:48 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011130214448.A28617@hq2>
In-Reply-To: <20011130200239.A28131@hq2> <Pine.LNX.4.33.0111301907010.1296-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111301907010.1296-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 07:15:55PM -0800, Linus Torvalds wrote:
> And I will claim that nobody else "designed" Linux any more than I did,
> and I doubt I'll have many people disagreeing. It grew. It grew with a lot
> of mutations - and because the mutations were less than random, they were
> faster and more directed than alpha-particles in DNA.

Ok. There was no design, just "less than random mutations". 
Deep. 

There was a overall architecture, from Dennis and Ken. There
where a couple of good sound design principles, and there were a 
couple of people with some sense of how it should work together.
None of that is incompatible with lots of trial and error and learn
by doing.

Here's a characteristic good Linux design method ,( or call it "less than random
mutation method" if that makes you feel happy): read the literature,
think hard, try something, implement
it, find it doesn't do what was hoped and tear the whole thing down.
That's design. Undesigned systems use the method of: implement some crap and then try to
engineer the consequences away. 

> 
> > The question is whether Linux can still be designed at
> > current scale.
> 
> Trust me, it never was.

Trust you? Ha.

> And I will go further and claim that _no_ major software project that has
> been successful in a general marketplace (as opposed to niches) has ever
> gone through those nice lifecycles they tell you about in CompSci classes.

That's classic:
	A) "trust me"
	B) now here's a monster bit of misdirection for you to choke on.

Does anyone believe in those stupid software lifcycles?
No.
So does it follow that this has anything to do with design?
No.


> Have you _ever_ heard of a project that actually started off with trying
> to figure out what it should do, a rigorous design phase, and a
> implementation phase?
> 
> Dream on.

I've seen better arguments in slashdot. 

There was no puppet master - ok.
There was no step by step recipe that showed how it should all work - ok
There was no design involved - nope.

