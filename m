Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281652AbRLANV1>; Sat, 1 Dec 2001 08:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284097AbRLANVK>; Sat, 1 Dec 2001 08:21:10 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:47120 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S281652AbRLANUz>;
	Sat, 1 Dec 2001 08:20:55 -0500
Date: Sat, 1 Dec 2001 06:14:31 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011201061431.B31278@hq2>
In-Reply-To: <20011130214448.A28617@hq2> <E16A5xV-0006UL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16A5xV-0006UL-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 08:57:17AM +0000, Alan Cox wrote:
> > Here's a characteristic good Linux design method ,( or call it "less than random
> > mutation method" if that makes you feel happy): read the literature,
> > think hard, try something, implement it
> 
> That assumes computer science is a functional engineering discipline. Its
> not, at best we are at the alchemy stage of progression. You put two things
> together it goes bang and you try to work out why.

Recently, our correspondent from Wales wrote:
	... the changes have been done and
	tested one at a time as they are merged. Real engineering process is the
	only way to get this sort of thing working well.

I really dislike this "alchemy" stuff. It's demeaning and misleading.
All the alchemists ever managed to create were cases of mercury
poisoning.


> In many of these fields there is no formal literature. The scientific paper
> system in computer science is based on publishing things people already
> believe. Much of the rest of the knowledge is unwritten or locked away in
> labs as a trade secret, and wil probably never be reused.
> 
> Take TCP for example. The TCP protocol is specified in a series of
> documents. If you make a formally correct implementation of the base TCP RFC
> you won't even make connections. Much of the flow control behaviour, the
> queueing and the detail is learned only by being directly part of the
> TCP implementing community. You can read  all the scientific papers you
> like, it will not make you a good TCP implementor. 

And you can hack away all you want, you'll never get TCP to work either.
This stuff is a mixture of theory and practice and
whether your theory is picked up from years of experience, boozy
arguments, and thinking, or from a strictly supervised
tour of the library it's theory all the same. 
CS is like any other skilled field. There's a difference between a guy
who knows how to hammer and a master carpenter. 

