Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268337AbRGZQzK>; Thu, 26 Jul 2001 12:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbRGZQzA>; Thu, 26 Jul 2001 12:55:00 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:47702
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S268337AbRGZQyq>; Thu, 26 Jul 2001 12:54:46 -0400
Date: Thu, 26 Jul 2001 09:54:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726095452.L27780@work.bitmover.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu> <9jpftj$356$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9jpftj$356$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jul 26, 2001 at 04:18:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 04:18:59PM +0000, Linus Torvalds wrote:
> In article <E15PnTJ-0003z0-00@the-village.bc.nu>,
> Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
> >> Go tell your opinion to those people that refuse to wrap their
> >> rename/link calls with open()/fsync() calls to the respective parents,
> >> particularly Daniel J. Bernstein, Wietse Z. Venema, among others. I
> >> don't possibly know all MTAs.
> >
> >I've pointed things out to Mr Bernstein before. His normal replies are not
> >helpful and generally vary between random ravings and threatening to sue
> >people who publish things on web pages he disagrees with.
> 
> Now, now, Alan. He has strong opinions, I'll agree, but I've never see
> him threaten to _sue_.

In the for what it is worth department, I spent the day with Daniel after
the kernel summit meeting a while back, we talked file systems for about
6 or 7 hours.  While I'll plead guilty to getting mad at him (his ego
is up there with mine :-), I came away impressed with his knowledge.
I get the feeling that he thinks deeply about the problems he works on,
he's probably right a lot of the time, *and* as with many deep thinkers,
he has a problem communicating his ideas.

This is a common problem, and I'm not sure Daniel is fully aware of it.
One cannot expect other people to have done the same thinking and have
the same context, and when they do not, it is easy to get frustrated.
I think that some of Daniel's "ravings" are probably just frustration
that the other person "doesn't get it".

That doesn't mean that Daniel is the right hand of God or anything, I've
seen him do some stupid things but I've seen all of us do some stupid
things, so that doesn't mean much.  I think Daniel does way more smart
things than stupid things, and not all of us can claim that (sort of
like half of the drivers are below average, noone likes that idea either).

What I'm trying to say is that I think Daniel is one of the good guys,
even though his user interface could stand improvement (a common thing
amongst smart people) and it looks like it would be smart to figure out
how to work with him.

Just my opinion...
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
