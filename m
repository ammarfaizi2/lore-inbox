Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314547AbSD0Uga>; Sat, 27 Apr 2002 16:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314598AbSD0Ufe>; Sat, 27 Apr 2002 16:35:34 -0400
Received: from bitmover.com ([192.132.92.2]:42965 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314547AbSD0Uen>;
	Sat, 27 Apr 2002 16:34:43 -0400
Date: Sat, 27 Apr 2002 13:34:42 -0700
From: Larry McVoy <lm@bitmover.com>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OFF TOPIC] BK license change
Message-ID: <20020427133442.A31314@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020421095715.A10525@work.bitmover.com> <20020422143527.K18800@work.bitmover.com> <20020425150158.A88@toy.ucw.cz> <878z79fpzv.fsf@CERT.Uni-Stuttgart.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies in advance for contributing to this thread, but I think this
is a fairly calm and reasonable response which sums up our position.
You may not like it, but it may help to understand it.

On Sat, Apr 27, 2002 at 11:30:12AM +0200, Florian Weimer wrote:
> Pavel Machek <pavel@suse.cz> writes:
> > Oh and btw how can you change licence retroactively? Those "abusers" have
> > right to continue to use old versions under old licences...
> 
> BK licenses become invalid as soon as a new BK version is released
> which contains bug fixes or behaves differently in any way.

The license says that you have to upgrade if your version will not pass
the current regressions.  In other words, if we have fixed a problem,
written a test case for it, shipped the fixed version and the test case,
then yes, you need to upgrade.  If it was important enough that we wrote
a test case for it, it's probably something you'll end up hitting sooner
or later.


This is not directed at Florian, but to the whole list:

Another thing to think about is that we need to get something from the
people who use it for free.  We support them, that support costs money,
and if we get nothing back, we're pretty much doomed compared to any
other company.  What we are asking back is that you test the latest and
greatest.  Our business model is that we give and get to/from everyone.
The free users get an expensive product for free, but they have to
give back by helping shake out the bugs from the current release.
The paying users have the right to sit on an old version, but they give
back by paying.

It's really just an optimization problem.  What we've done is to optimize
for the most that we can do for the most people.  I'm well aware that
some free software folks hate that it isn't open source, that's just
not realistic for this sort of product.  

It seems like every couple of weeks someone says they don't like the BK
license and they are going to rewrite BitKeeper.  I have two thoughts
on that: (A) I doubt it will happen, it's more work than it looks like.
If you want to spend a few years working 7 days a week, be my guest.
Most people don't have the stomach for it. (B) If someone did write
a decent open source replacement, that would actually be OK with me.
All of the people who work at BitMover are capable of doing work on much
more lucrative endeavors.

In short: go build a better answer, and until you do it, how about 
easing off on the "BK is evil corporate software" mantra a bit?  It's
not evil corporate software, it's software built by people from your
community, for your community, in the most acceptable we could find 
which was self sustaining.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
