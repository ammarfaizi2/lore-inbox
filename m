Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314664AbSDTTTy>; Sat, 20 Apr 2002 15:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314686AbSDTTTx>; Sat, 20 Apr 2002 15:19:53 -0400
Received: from dsl-213-023-039-128.arcor-ip.net ([213.23.39.128]:29835 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314664AbSDTTTv>;
	Sat, 20 Apr 2002 15:19:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Fri, 19 Apr 2002 21:19:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E16ya3u-0000RG-00@starship> <E16ycuh-0000Wg-00@starship> <20020420194851.A8051@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ydvD-0000Zu-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 20:48, Russell King wrote:
> On Fri, Apr 19, 2002 at 08:15:14PM +0200, Daniel Phillips wrote:
> > All of what you said, 100% agreed, and insightful, in particular:
> > 
> > On Saturday 20 April 2002 19:53, Eric W. Biederman wrote:
> > > I can see the potential for this to break down.  However we should
> > > not be crying wolf until this actually does break down.
> > 
> > Do we want it to break down first?  I don't want that.
> 
> Actually, you yourself have probably sewn the first seeds of the community
> breaking down.  Lets take a moment to put some thought in at this point
> and review what's happened today.
> 
> 1. The Current Situation
> 
>    - Linus uses BK
>    - Linus makes his BK tree available.
>    - Linus makes GNU patches available.
>    - Linus accepts requests to pull from BK trees.
>    - Linus accepts GNU patches to apply to his BK tree.
> 
> 2. The effect of today
> 
>    - You've highlighted a problem
>    - David Woodhouse and Rik van Riel have written a tool to grab Linus'
>      BK tree and turn it into a patch on a per-hourly basis
> 
> Now look back at Linus' actions above.  There is now redundancy.  Linus
> doesn't have to put out GNU patches anymore because someone else is
> doing that for him...  which means Linus works more efficiently.
> 
> So it's highly likely that in the future, we'll have:
> 
>    - Linus uses BK
>    - Linus makes his BK tree available
>    - Linus accepts requests to pull from BK trees.
>    - Linus accepts GNU patches to apply to his BK tree.
>    - "Select few" pull his BK tree and create GNU patches for others
>      to use.

Use for what?  I'm not clear on this concept.

> Oops.  We've just split the community further, which is *completely* the
> opposite of what you wanted to achieve.  I wonder what the next stage
> will be...

Now you're crying wolf.  Since when has developing and trying out tools
been bad?

> Like I said to you on IRC before you posted the message - you want
> to fix the problem at the root (ie, Linus) rather than your apparant
> problem with the "two communities."  And how do you do that?  You
> discuss it with the person concerned.  (And you can see the results
> of that discussion earlier in this thread.)

Sorry, the only way I know of debating is in public.  Perhaps I can
learn another way, but I'm not sure I want to.

> This way, those that want to use "a distributed source control system
> of some type" can do so, and those that want to use the GNU patch/diff
> method can also continue to, but with The Latest Tree available.
> Which has got to be an advantage for *everyone*.
> 
> I'm sorry, I have no cares for people who have been constantly whinging
> at the users of BK who don't go out of their way to find out where the
> real problem is and attempt to fix that, rather than harp on about how
> other people shouldn't be using a non-free tool.

Please show me where I said anyone should not use Bitkeeper.

> Oh, and before anyone says that I'm another one who uses BK, yes I do
> use BK, but only as a method of getting ARM specific changes into Linus.
> Any generic kernel changes I have still go to linux-kernel, Linus and
> any relevant other people as a GNU patch.  The first time these patches
> see BK is when they hit Linus' BK tree.  They don't come from BK either.
> 
> I, therefore, can claim to work in both domains in parallel.
> 
> But no, in your eyes, I'm just another stupid BK person who's contributing
> to the downfall of Linux, and is in the "in" club.

Not at all, you're just the ARM guy. <- funny, laugh

-- 
Daniel
