Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291232AbSBLWyf>; Tue, 12 Feb 2002 17:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291233AbSBLWyZ>; Tue, 12 Feb 2002 17:54:25 -0500
Received: from bitmover.com ([192.132.92.2]:61886 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291232AbSBLWyN>;
	Tue, 12 Feb 2002 17:54:13 -0500
Date: Tue, 12 Feb 2002 14:54:12 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Lord <lord@regexps.com>
Cc: tytso@mit.edu, lm@bitmover.com, jmacd@CS.Berkeley.EDU, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020212145412.E25559@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Lord <lord@regexps.com>, tytso@mit.edu, lm@bitmover.com,
	jmacd@CS.Berkeley.EDU, jaharkes@cs.cmu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com> <20020211002057.A17539@helen.CS.Berkeley.EDU> <20020211070009.S28640@work.bitmover.com> <20020211141404.A21336@work.bitmover.com> <200202120517.VAA21821@morrowfield.home> <20020211225935.B5514@thunk.org> <200202122028.MAA24835@morrowfield.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202122028.MAA24835@morrowfield.home>; from lord@regexps.com on Tue, Feb 12, 2002 at 12:28:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	2. On your laptop, store only the repository you'll need for
>            day to day work, plus a very sparsely populated revision
>            library
> 
> Having a huge revision library is a win if what you're doing is
> fielding patches [etc]

I think that the point is that when you put stuff on your laptop, you'd
dearly love not realize that you forgot something you need when you are
either not connected or are connected only via a modem.  If you can store
the kernel history in 80-90MB and you have all the versions you'll ever
want, that's a win compared to storing a few versions and then realizing
the one you want isn't there.

I also think that the term "huge revision library" doesn't make sense
to all systems.  Some systems can fit that "huge library" in less space
than the checked out files, so why limit yourself?

Note that this is explictly not a BK thing, it's a general thing.
I want whatever system I use to limit my choices as little as possible.
No system is perfect, it's more of an optimization over the posssible
limitations.  In this particular respect, I can say that I've found it
very useful to carry around all the history when traveling, it means
there is no difference between working at home or on the road, other
than performance of my crappy laptop.

And it's not like this makes arch bad, this is one place where it isn't as
good as some other choices.  But arch has other areas where it is better,
it is less pedantic than most systems about what it will try and apply.
It's the uber patch library if you ask me, and that has real value.
Why the patchbot people haven't picked up on that is beyond me, they're
off trying to write something "simple", which I think you'll agree is
a strange, there is nothing simple about this problem space.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
