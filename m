Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281642AbRLAMl0>; Sat, 1 Dec 2001 07:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284092AbRLAMlQ>; Sat, 1 Dec 2001 07:41:16 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:42000 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S281642AbRLAMk7>;
	Sat, 1 Dec 2001 07:40:59 -0500
Date: Sat, 1 Dec 2001 05:34:34 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011201053434.A31278@hq2>
In-Reply-To: <20011130214448.A28617@hq2> <Pine.LNX.4.33.0111302048200.1459-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111302048200.1459-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 09:15:50PM -0800, Linus Torvalds wrote:
> 
> On Fri, 30 Nov 2001, Victor Yodaiken wrote:
> >
> > Ok. There was no design, just "less than random mutations".
> > Deep.
> 
> I'm not claiming to be deep, I'm claiming to do it for fun.
> 
> I _am_ claiming that the people who think you "design" software are
> seriously simplifying the issue, and don't actually realize how they
> themselves work.

Just to make sure we are speaking the same language, here is what the
Oxford English Dictionary sez
	Design: (1) a plan or scheme conceived in the mind; a project.
	        ...
		(2) a purpose, an intention, an aim
		...
		(3) an end in view, a goal
		...
		(4) A preliminary sketch, a plan or pattern

For the verb we get things like: "draw, sketch, outline, delineate"

> 
> > There was a overall architecture, from Dennis and Ken.
> 
> Ask them. I'll bet you five bucks they'll agree with me, not with you.
> I've talked to both, but not really about this particular issue, so I
> might lose, but I think I've got the much better odds.

You're on.  Send me the $5.
Here's what Dennis Ritchie wrote in his preface to the re-issued Lions
book:
	"you will see in the code an underlying structure that has
	lasted a long time and has managed to accomodate vast changes
	in the computing environment"


> If you want to see a system that was more thoroughly _designed_, you
> should probably point not to Dennis and Ken, but to systems like L4 and
> Plan-9, and people like Jochen Liedtk and Rob Pike.

You appear to be using "design" to mean "complete specification". 
See above.

> 
> And notice how they aren't all that popular or well known? "Design" is
> like a religion - too much of it makes you inflexibly and unpopular.

Memory fades with age, as I know from sad experience, but try to
remember who wrote things like:

	|
	|However, I still would not call "pthreads" designed. 
	|
	|Engineered. Even well done for what it tried to do. But not "Designed".
	|
	|This is like VMS. It was good, solid, engineering. Design? Who needs
	|design? It _worked_.
	|
	|But that's not how UNIX is or should be.  There was more than just
	|engineering in UNIX.  There was Design with a capital "D".  Notions of
	|"process" vs "file", and things that transcend pure engineering.
	|Minimalism.
	|
	|In the end, it comes down to aesthetics.  pthreads is "let's solve a
	|problem".  But it's not answering the big questions in the universe. 
	|It's not asking itself "what is the underlying _meaning_ of threads?".
	|"What is the big picture?".

Some academic twit, no doubt, with no understanding or experience in
actually making a blue collar OS really work.
The same fool once wrote:

> Think about WHY our system call latency beats everybody else on the
> planet. Think about WHY Linux is fast. It's because it's designed
> right.


Please send the $5 soon.

