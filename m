Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267670AbTACVSH>; Fri, 3 Jan 2003 16:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267669AbTACVSH>; Fri, 3 Jan 2003 16:18:07 -0500
Received: from bitmover.com ([192.132.92.2]:12223 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267670AbTACVSE>;
	Fri, 3 Jan 2003 16:18:04 -0500
Date: Fri, 3 Jan 2003 13:26:31 -0800
From: Larry McVoy <lm@bitmover.com>
To: Richard Stallman <rms@gnu.org>
Cc: mark@mark.mielke.cc, billh@gnuppy.monkey.org, paul@clubi.ie,
       riel@conectiva.com.br, Hell.Surfers@cwctv.net,
       linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in non-free drivers?
Message-ID: <20030103212631.GD24896@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Richard Stallman <rms@gnu.org>, mark@mark.mielke.cc,
	billh@gnuppy.monkey.org, paul@clubi.ie, riel@conectiva.com.br,
	Hell.Surfers@cwctv.net, linux-kernel@vger.kernel.org
References: <20030102013736.GA2708@gnuppy.monkey.org> <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org> <20030102055859.GA3991@gnuppy.monkey.org> <20030102061430.GA23276@mark.mielke.cc> <E18UIZS-0006Cr-00@fencepost.gnu.org> <20030103075134.GA31357@mark.mielke.cc> <E18UYSe-0004v1-00@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18UYSe-0004v1-00@fencepost.gnu.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Long rant but it's a worthwhile read if you want to know why I don't
agree with Richard.  

> You seem to be saying that we should sit back and let these inevitable
> forces either convince all companies to make software free--or not.
> If we had such a passive attitude, no free system would exist.
> GNU/Linux exists because of people who were willing to work to have
> freedom.  Freedom does not yet prevail, and we have plenty more work
> to do to make that happen.  And after we fully have freedom, we will
> still have to work, to make sure we don't lose it.

The problem with your point of view is that you are assuming that somehow
progress will continue to be made once you have that freedom.  Let's just
look at that for a minute and see if that makes sense.

Postulate that all the software in the world is GPLed.  All of it.  That's 
your goal as far as I can make out, but let's not argue about if it is or
is not, it doesn't matter.

Anyone who wants to build on that software can, there is almost perfect
code reuse.  Again, something I think you want, certainly a nice idea.

Because all the software is freely available, this sets an upper bound
on how much any company can charge for it.  If the amount they charge
for gathering it up and making a distribution, for example, is low
enough that other people look at it and think that's too little money
for that much work, then their prices will hold.  On the other hand,
if they are charging twice that, another company can spring up which
grabs the software and sells it for the lower price, a price low enough
that no cheaper company can come in.  Obviously, the first company either
drops their prices or goes out of business.

I think this too is what you want, it seems great, people are paying a
small amount of money to get the software, a much, much smaller amount
than they would be paying if the software were closed.  Case in point:
Microsoft.  Nobody would be paying what they charge if they didn't have
to do so.  But people would certainly pay $20 or $50 for a CD full of
Windows + Office + whatever.  But not much more and they'd pay for one CD
and then install it many many times, so the effective revenue per machine
would be less than one cent in an organization of any size.

So what's wrong with that picture, it seems fantastic?  A world where we
can all share each other's work, the prices are low, anyone can tinker,
anyone can package, sounds great.  

The problem is that the amount of money being generated is very small
compared to what software companies get under the closed source model.
So what?  What's wrong with that?  Well, under that model, none of the
software companies can afford to pay for any development out of the
distribution revenue, if they were charging more than it took to pay for
the people to build the distribution then someone would undercut them,
there is nothing they can do to prevent that.  That same argument works
for the support model or anything else.  It doesn't matter what model
you pick, if you charge more than it costs to do the work plus a very
slim profit margin, that presents an attractive opportunity for someone
else to set up shop.

We can argue about this until the cows come up but it's simple economics.
If there is no barrier to entry and a supplier is charging more it
costs, a cheaper supplier will enter the market and force the price down.
Even the most green MBA understands this and I don't think I need to tell
you that the VC's all understand this.  For the sake of discussion, let's
assume that you agree with that statement (if you don't, don't bother
to argue with me, I'll ignore you, I'm not here to teach basic economics).

So we've established that in an all free world, even though some money
will change hands, it can't be significantly more than what it costs 
to perform whatever service is being provided.  In other words, there 
is no extra money.

Is that a problem?  I think so.  If you look at the history of the free
software movement, it has been a history of imitation rather than one of
innovation (sorry to sound like Bill Gates but he has a point here).
Almost everything done in the free software world is a rewrite of
something that already existed.  The GNU folks have made it clear for
years that what they wanted are free versions of the applications they
consider to be useful.  They don't spend much time talking about anything
innovative, they talk about filling in the gaps where there is no free
version of Word or whatever.  Over and over, RMS says "you would better
to not use $APP but instead dedicate some time to rewriting $APP so we
have a free version".  That's not innovation, that's imitation.

Leaving aside the inevitable argument about whether or not the free
software world is or is not innovative, let's look at what it takes
to produce new things.  The problem is that none of us have a real
crystal ball.  We don't know which ideas will take hold in the market
and which won't.  We can guess and maybe get lucky, but in general the
guesses are wrong much more than they are right.  Look at the history
of startups.  With all the screening that VC's do, all the due diligence,
we still have failures of at least 9/10 and these days more like 99/100.
For every Ebay or Google there are hundreds of startups which started
about the same time as Ebay or Google but are are long and forgotten.

If we look at the entire software development world as one big system,
what history shows us is that the vast majority of the effort is wasted,
only 1% of it succeeds (1%, 10%, pick your number, the vast majority of
it fails).

Let's say it is 10% of it that succeeds.  Under the world RMS is proposing,
not only is there no money to pay for the startup costs of that 10%, there
is no money to pay for the 90% that doesn't succeed.  Not from within the
system, the only way that money can exist is if it is from people outside
of the software world, every penny in the software world is spoken for.

Let's say that I'm wrong, we can come up with enough extra money to pay
for the 10% which is going to succeed.  The problem is that we don't
know in advance wich 10% will succeed, which means that we are really
only funding 1/10th of the startups.  Which slows down innovation to
1/10th the speed.

I don't know about you, but that's not a world I want to live in.  Google
wouldn't exist in Richard's world, I know that for a fact.  Sergey and
Larry would have gone into some other field, they are ambitious people.
Ditto for Ebay, Amazon, and any number of other companies which have
become institutions.

You may or may not still be reading, you may or may not agree, but my
view is that Richard's proposed world is a very bleak sort of place.
There won't be any companies coming out with new ideas to copy, there
won't be the frenetic pace of innovation, it will be a sort of gray
place, like selling washing machines.  I don't know about you, but I
like the world we live in.  Yeah, the fact that Microsoft has the money
really sucks but if that's the price I have to pay to get things like
Google and Ebay and Amazon and Shutterfly and <fill in your favorite
new software company here>, that's OK with me.  You might want think
about whether you would trade all of that for Richard's utopian world.
Maybe you would, I wouldn't and I don't think very many other people
would either.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
