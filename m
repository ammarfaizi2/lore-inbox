Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280967AbRK3TGB>; Fri, 30 Nov 2001 14:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283760AbRK3TFw>; Fri, 30 Nov 2001 14:05:52 -0500
Received: from bitmover.com ([192.132.92.2]:5303 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S280967AbRK3TFr>;
	Fri, 30 Nov 2001 14:05:47 -0500
Date: Fri, 30 Nov 2001 11:05:46 -0800
From: Larry McVoy <lm@bitmover.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Larry McVoy <lm@bitmover.com>, Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011130110546.V14710@work.bitmover.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Larry McVoy <lm@bitmover.com>,
	Henning Schmiedehausen <hps@intermeta.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <E169rmi-0000ko-00@starship.berlin> <20011130101308.S14710@work.bitmover.com> <E169scn-0000kt-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E169scn-0000kt-00@starship.berlin>; from phillips@bonn-fries.net on Fri, Nov 30, 2001 at 07:43:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 07:43:01PM +0100, Daniel Phillips wrote:
> On November 30, 2001 07:13 pm, Larry McVoy wrote:
> > On Fri, Nov 30, 2001 at 06:49:11PM +0100, Daniel Phillips wrote:
> > > On the other hand, the idea of a coding style hall of shame - publicly 
> > > humiliating kernel contributers - is immature and just plain silly.  It's 
> > > good to have a giggle thinking about it, but that's where it should stop.
> > 
> > If you've got a more effective way of getting people to do the right thing,
> > lets hear it.  Remember, the goal is to protect the source base, not your,
> > my, or another's ego.
> 
> Yes, lead by example, it's at least as effective.  

I'd like to see some data which backs up that statement.  My experience is
that that is an unsupportable statement.  You'd need to know how effective
the Sun way is, have seen multiple development organizations using that 
way and other ways, and have watched the progress.

I'm in a somewhat unique position in that I have a lot of ex-Sun engineers
using BitKeeper and I have a pretty good idea how fast they make changes.
It's a lot faster and a lot more consistent than the Linux effort, in fact,
there is no comparison.

I'm not claiming that the coding style is the source of their speed, but
it is part of the culture which is the source of their speed.

As far as I can tell, you are just asserting that leading by example is
more effective.  Am I incorrect?  Do you have data?  I have piles which
shows the opposite.

> Maybe humiliation works at 
> Sun, when you're getting a paycheck, but in the world of volunteer 
> development it just makes people walk.

Huh.  Not sure I agree with that either.  It's definitely a dicey area
but go through the archives (or your memory if it is better than mine)
and look at how the various leaders here respond to bad choices.  It's
basically public humiliation.  Linus is especially inclined to speak
his mind when he sees something bad.  And people stick around.

I think the thing you are missing is that what I am describing is a lot
like boot camp.  Someone with more knowledge and experience than you 
yells at your every mistake, you hate it for a while, and you emerge
from boot camp a stronger person with more skills and good habits as
well as a sense of pride.  If there was a way to "lead by example" and
accomplish the same goals in the same time, don't you think someone 
would have figured that out by now?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
