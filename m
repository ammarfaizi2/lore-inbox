Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291840AbSBHVfq>; Fri, 8 Feb 2002 16:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291846AbSBHVfh>; Fri, 8 Feb 2002 16:35:37 -0500
Received: from bitmover.com ([192.132.92.2]:898 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291840AbSBHVfX>;
	Fri, 8 Feb 2002 16:35:23 -0500
Date: Fri, 8 Feb 2002 13:35:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020208133522.G25595@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@suse.cz>, Tom Lord <lord@regexps.com>,
	jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com> <20020208153307.GA122@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020208153307.GA122@elf.ucw.cz>; from pavel@suse.cz on Fri, Feb 08, 2002 at 04:33:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 04:33:08PM +0100, Pavel Machek wrote:
> I know less than 10 such systems, not 300. And now arch is one of
> them.

http://www.cmtoday.com/yp/ is a starting point to get a baseline for
all of them.  It's by no means a complete list, but it's a lot bigger
than 10.

> What was the point of this mail?
> 
> Are you concerned that arch is free software and bk is not?
> 
> arch _has_ chance; Tom is probably not going to make million dollars,
> but if someone has a choice between using non-free software and arch,
> maybe he will just spend his time improving arch.

The point is that you don't make systems like this by having people "spend
their time improving arch" for free.  If that worked, then CVS would
be the ultimate SCM system.  CVS has been here for close to 2 decades I
think, right?  Wasn't the first release 1986?  OK, 15 years.  So 15 years
ago, CVS was where arch is today in terms of maturity.  There is no reason
that you couldn't take CVS and make it work.  It's just work to do so.
We've had 15 years to have that happen and it didn't.  What makes you
think it will be different this time around?

The problem with this space, and it is constantly annoying to me, is
that people think it is easy.  "I can just write some scripts and wrap
them around RCS or SCCS or diff&patch, I can do a better job than those
losers over at Rational (or Perforce or AccuRev or BitMover or Collab.net
or ...)".

And guess what?  In very short order, you can have something that
does something.  Even something useful.  Then it starts to get hard.
Then it starts to get harder.  If you really want to solve the problem,
it's really really hard, harder than, say, multithreading a kernel.
I can hear you screaming BS, no way is it harder than what I do, which
is exactly what I find annoying - I've done what you do, you haven't
done what I do, so why is it that you know that I'm wrong?  Don't know,
but you're sure I'm wrong.

So the point is that it is a hard problem space, it takes a lot of time,
thought, and quality programming to get it right, and it's not fun.  The
easy part is a blast.  I have some fun most days.  But the majority of
my day is not fun.  And if you were solving the same problems it wouldn't
be any more fun for you.  Only the fun part is fun, and that's the small
part of the problem space.  So you have a not-so-fun space, a fairly 
small market of people to pay for the not-so-fun parts, and a lot of
competition.

Result?  Arch is cool, it's got a good model for distribution, it needs 
a huge amount of work to make it a reasonable answer, and noone is going
to pay for that work.  So you take what you have now, and realize that if
it works for you now or is close, then arch is the answer you want, you
can't beat the price.  If it isn't close to what you want, then I question
the chances it has of getting there.

That's all.  This whole mail could have been "if it works for you, great.
If if doesn't and you can fix it, great.  If you can't, don't hold your
breath".
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
