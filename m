Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbTFTUvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264666AbTFTUvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:51:12 -0400
Received: from emf.emf.net ([205.149.0.20]:16132 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S264651AbTFTUuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:50:44 -0400
Date: Fri, 20 Jun 2003 14:04:45 -0700 (PDT)
From: Tom Lord <lord@emf.net>
Message-Id: <200306202104.OAA21921@emf.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[BTW, see http://arch.quackerhead.com/~lord/ for information about 
 the latest, faster, no-shell-code-involved (re-)implementation of 
 arch.]


	Larry McVoy being right again:

        > So where is the money going to come from to create the new
        > stuff?  That's what I've been trying to get people to see.
        > I'm not against open source, I'm against a grayish world
        > that simply can't support the creation of new stuff.  That
        > looks bleak and boring.  I don't know what people are going
        > to create in the future but I do know that I want to see it.


It's even worse than that, Larry.

Unless MSFT stops innovating, they will remain what they are now: the
primary, almost exclusive source of "new things to copy", especially
in application and entertainment software.

So what?  Well, you also claim:

	> Creating new software:       $$$$$$$$$$
	> Copying existing software:       $


and you know, if you're talking about the core shell utils, or even a
unix kernel, I think you're right.  But that ratio isn't always right.

Let's say we have two parties: The Innovator, and The Copier, where
the Innovator has a lot more money to spend on innovation.  

All that The Innovator has to do to hurt The Copier is choose software
architectures and software engineering techniques that tend to yield
highly parallelized development of components that are nevertheless
deeply interdependent.  The Innovator puts a large command-and-control
army of hackers to the task of making a rats nest, and then adds on a
few more bucks to hire good software engineering "generals" to make
sure that, nevertheless, more-or-less functioning products get out the
door.

The Innovator does a _little_ innovation (original, high-level
design), but orients that innovation towards making products that
require a _huge_ amount of highly coordinated grunt-work.

What, then, is The Copier to do?  Copying that tiny bit of innovation
is easy.  It's so easy that The Innovator can make it 0 cost ("Here's
the spec for the mono VM, knock yourself out.")  Copying the
grunt-work, though: that's going to cost just about as much to the
Copier as it cost the Innovator.


	Creating new monolithic-behemoth software:  $$$$$$$$$$
	Copying monolithic-behmoth software:        $$$$$$$$$$


We've seen that play out in desktop software, Java implementations and
Java libraries, web browsers, and Mono.  It's the reason we don't see
any serious effort to clone MSFT operating systems.  It's the
engineering underpinning of the legal wrangling with MSFT over browser
integration and secret APIs.   We see this in the license restrictions 
on BK that prevent free software implementors of competing systems from
using BK gratis.

And it gets worse still: because the way the larger free software
companies (company?) are shaping up -- highly coordinated parallelized
development is taking a back seat to deriving exclusive benefit of
parallelized development.   We can't even seem to get right things as
basic and trivial as propogating bug-fixes in tar from commercial
linux distros back to the version you get from ftp.gnu.org.  
So for these huge copying efforts, perhaps it's really more like:

	Creating new monolithic-behemoth software:  $$$$$$$$$$
	Copying monolithic-behmoth software:        $$$$$$$$$$$$$$$$$$$$

or even:

	Creating new monolithic-behemoth software:  $$$$$$$$$$
	Copying monolithic-behmoth software:        +inf

because if we were all really pulling together as a team, suddenly the
value of a commercial distribution, as it is currently realized, would
dry up.

The hope for fixing the way innovation takes place in the free
software world, the hope for abandoning the role of The Copier, 
is something you stated yourself:

   > The much shorter version is that there is a fundamental principle
   > in business: the health of your suppliers is critical.

A program of effective and sustainable innovtation is critical to the
health of a technology supplier.   You know this.  I know this.  The
customers presumably know it as well but, at least in your experience, 
aren't really qualified to understand the implications:

   > Another way to put it is they don't really buy products based on
   > how good they are, the IT guys frequently are nowhere near
   > qualified to determine if a product is good enough.  So they buy
   > products based on knowing that the vendor is healthy, there is a
   > revenue stream going to that vendor, there are lots of other
   > people buying the product, so if the product sucks in version
   > 3.x, that's not the end of the world, the vendor will fix it in
   > 4.x and it will still be a good choice.

and that's not an unreasonable way to _partially_ evalutate
tech-supplier health, but it surely is far from the whole story.

-t

