Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288452AbSA3E0k>; Tue, 29 Jan 2002 23:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288460AbSA3E0a>; Tue, 29 Jan 2002 23:26:30 -0500
Received: from msp-26-179-145.mn.rr.com ([24.26.179.145]:35726 "HELO
	msp-26-178-183.mn.rr.com") by vger.kernel.org with SMTP
	id <S288452AbSA3E0W>; Tue, 29 Jan 2002 23:26:22 -0500
Date: Tue, 29 Jan 2002 22:26:20 -0600
From: Shawn <core@enodev.com>
To: Craig Christophel <merlin@transgeek.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130042620.GA28479@local.enodev.com>
In-Reply-To: <Pine.LNX.3.96.1020129173907.31511C-100000@gatekeeper.tmr.com> <20020130041456.B4F20B581@smtp.transgeek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130041456.B4F20B581@smtp.transgeek.com>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29, Craig Christophel said something like:
> > Linus, I think I hear people you said you trust telling you this... take
> > the little bits out of band and TRUST people to give you patches which go
> > in 2.5.x now, not when or if you get to it. Having you approve trivial
> > stuff is a waste of what you do best, and I think all the versions show
> > you're not even being effective at that. Don't you HATE looking at
> > spelling errors, off-by-one logic, corner cases, and stuff like that? Farm
> > it out and let other people do it, and work on the fun stuff.
> 
> 	aasn, (as a side note)  It's really hard to allow people to just change the 
> little peices.  The little peices soon become larger and more complex.  This 

I believe he was talking about some of the example one-liners cited
earlier. Not a significant chance of those getting "more complex" such
that they become cumbersome...

> is a really difficult transition in moving from (my personal perspective) an 
> exciting young code base to a maturing and well functioning/planned setup.  
> The only thing I have to say is that Linus had better pick his talent and 
> friends well, because even if the codebase does not split today, what is to 
> keep it from doing so in the future when even more complexities arise.  

The codebase has been, is now, and forever will be split, due to
differing goals, and the fact that one size does not fit all... Not to
mention personal taste. The splits will only be as large a practicality
allows, given the number of trees trying to sync from, or with -linus.
The -ac tree got pretty splorked off for a while, though.

By the way, Linus, Alan, Al Viro, Marcello, Ingo, Stephen, Rik, Dave,
Dave, any other Daves, Geert, Jens, Andre, Richard, hpa, Hans, and
everyone I can't think of, THANKS for making my machine run fast, die
hard, and just for putting out better code than a huge corporation can!

--
Shawn Leas
core@enodev.com

For my birthday I got a humidifier and a de-humidifier... I put them
in the same room and let them fight it out...
						-- Stephen Wright
