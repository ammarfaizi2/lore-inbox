Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261656AbSJFQMa>; Sun, 6 Oct 2002 12:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbSJFQMa>; Sun, 6 Oct 2002 12:12:30 -0400
Received: from bitmover.com ([192.132.92.2]:40333 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261656AbSJFQM2>;
	Sun, 6 Oct 2002 12:12:28 -0400
Date: Sun, 6 Oct 2002 09:18:01 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: BK license questions and answers
Message-ID: <20021006091801.A29687@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This thread has raised a pile of issues, not to mention hackles, so I
went through and extracted the questions that I saw as needing serious
answers.  Other than answering these questions, I'd like stay out of
this "discussion", it seems that all I ever do is end up looking like a
nutcase and while that may be fun for you, I don't particularly enjoy it.

> I'm at a University and someone might be hacking on CVS here, do I
> no longer have a license to use BK?

We wanted to allow your sort of use but all the legal language which
would do so also opened up loopholes for the bad guys.  So we went with
the more restrictive language.  We're not that thrilled with it either
but we had to do something to protect ourselves, we're seeing more and
more people attempting to steal our intellectual property.

It is the corporate position of BitMover that the use described does not
violate the spirit of the license and we would not attempt to enforce the
clause in that case or other similar cases.  The clause clearly targets
competitors and this simply doesn't raise to the level of competition.

> I want to see the commit messages on the lkml.

No problem, get Linus to check in a commit trigger.  bk help triggers.

> I want everything available via regular patches on bkbits.net

We won't do this because of the excessive amounts of bandwidth that
it would take.  We're moving bkbits.net to rackspace.com and we're
limited to 30GB/month.  If you want this service at bkbits.net (and we
certainly understand why you would) we can try and work something out
with rackspace.  We'll work that issue and report back.

Alternatively, there are several people who do the changeset -> patch 
exports.  

> Why did so-and-so get flamed when he asked for RPMs?  Is BitMover going
> to be less friendly going forward?

We, especially I, are human.  Contrary to popular opinion, doing what we
do for the kernel team is not easy, doesn't generate boatloads of money,
it's just a lot of hard work.  Try and imagine doing the same work and 
then having people yell at you constantly, telling you that if they were
doing what you were doing they could do it in less time, produce a better
product, and do it with a GPLed source base.  It's not much fun being on
the receiving end of that and we've been hearing that for 5 years.  

It's worth pointing out that it is almost always the non-users who have
a less than thrilling interaction with us.  We work hard to help people
using our product, our response time is fantastic, we're here to help
and that isn't going to change.  We're engineers, we live to help other
engineers, that's the fun part.

I can't promise that we'll be friendly to people who are antagonistic
with us.  We'll try.  It would be nice if they were trying to be friendly
as well.

> Is BitMover going to sell out?

We've been approached several times with acquisition offers as well as
VC offers.  While it is possible we would sell out, we won't do so if it
means diluting the quality of the product, the quality of our support,
dropping the kernel team, or changing the licensing scheme.  The reason
we have turned down acquisition attempts in the past was that we believed
we would not be able to support you the way we currently support you.
We've been making decisions all along to make sure that we have and can
maintain the control required to do what it takes to support the kernel
team and other open source developers and we'll continue to do that.

> Are the commit messages and other BK metadata GPLed?

That isn't up to BitMover, that is up to Linus.  Look at clause 3(b).
Linus, as the creator and owner of that repository, can put anything he
wants in BitKeeper/etc/REPO_LICENSE so long as it doesn't conflict with
the BKL.  He can say that all the metadata is GPLed if that's what the
world wants.  It's his issue, not ours.

This clause is very powerful, it gives Linus the right to place or remove
any restrictions he wants on the use of BK to access the repository.
If you don't agree with his license, the BKL is automatically not granted.
He could use the BKL to enforce the GPL if he wanted to.

> Is BitMover the only place which can legally host BK kernel
> repositories?

See the answer to the previous question.  Linus could make it such that
BitMover is the only place which *can't* legally host the BK kernel 
repositories if he wanted to do so.  Other than that, anyone can host
anything they want anywhere they want so long as they are obeying the
terms of the BKL; there is nothing in the BKL which precludes others
from hosting the repositories.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
