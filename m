Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTLUTzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTLUTzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:55:35 -0500
Received: from pdbn-d9bb8708.pool.mediaWays.net ([217.187.135.8]:57861 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S263945AbTLUTzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:55:32 -0500
Date: Sun, 21 Dec 2003 20:55:28 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Stan Bubrouski <stan@ccs.neu.edu>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
Message-ID: <20031221195528.GA29261@citd.de>
References: <1071969177.1742.112.camel@cube> <20031221105333.GC3438@mail.shareable.org> <1072034966.1286.119.camel@duergar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072034966.1286.119.camel@duergar>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 02:29:27PM -0500, Stan Bubrouski wrote:
> On Sun, 2003-12-21 at 05:53, Jamie Lokier wrote:
> > Albert Cahalan wrote:
> > > What about the obvious Kconfig option?
> > > 
> > > config PATENT_1234567890
> > >         bool "Patent 1234567890"
> > >         default n
> > >         help
> > >           Say Y here if you have the right to use
> > >           patent 1234567890 (the foo patent). Some
> > >           countries do not recognise this patent, an
> > >           educational or research exemption may apply,
> > >           you may be the patent holder, the patent
> > >           may have expired, or you may have aquired
> > >           rights via licensing. Seek legal help if you
> > >           need advice concerning your rights. If unsure,
> > >           say N.
> > 
> > I expect this was said in jest, but it would be delightful to see this
> > done for real.  To the best of my knowlege it's uncharted territory,
> > so perhaps what you suggest _would_ be upheld in a court of law as
> > permissible?
> <SNIP>
> 
> No No No No No...do you really think including code for a patented
> algorithm(s) is a good idea?  You are still distributing the code and
> allowing people to illegally use it in countries where they are not
> allowed to.  In essence you are providing a catalyst for them to violate
> a patent and making yourself and other liable along the way.  US law is
> sick and fucked up, and if someone sues you for patent infringement
> you're most likely fucked, because you can never have enough money to
> defend yourself...for the sake of us stuck in this so-called free
> country (though we can be arrested and jailed without trial?) please do
> not include patented algoriths in Linux...

The question is "What toes are OK to step onto".

e.g.
To the best of my knowledge it should be illegal to distribute 2.6
kernel in France because AFAIK it is illegal to use encryption there.
(If not France, there are other countries that fit)
(And you remember that this same problem was only resolved a few years
ago for the U.S.! Otherwise the crypto-stuff would have been in kernel
for years!)

So the only question is "Is it OK to step on the U.S. toe?".
I guess there are other countries on this small planet (>200 IIRC) where
the current linux kernel has it's "problems(tm)" here and there.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

