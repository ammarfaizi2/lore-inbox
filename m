Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264449AbRFIJbl>; Sat, 9 Jun 2001 05:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264450AbRFIJbb>; Sat, 9 Jun 2001 05:31:31 -0400
Received: from [194.102.102.3] ([194.102.102.3]:13063 "HELO ns1.Aniela.EU.ORG")
	by vger.kernel.org with SMTP id <S264449AbRFIJbL>;
	Sat, 9 Jun 2001 05:31:11 -0400
Date: Sat, 9 Jun 2001 12:30:38 +0300 (EEST)
From: "L. K." <lk@Aniela.EU.ORG>
To: Leif Sawyer <lsawyer@gci.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: temperature standard - global config option?
In-Reply-To: <BF9651D8732ED311A61D00105A9CA315053E0AFB@berkeley.gci.com>
Message-ID: <Pine.LNX.4.21.0106091224120.5416-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > From: L. K. [mailto:lk@Aniela.EU.ORG]
> > I really do not belive that for a CPU or a motherboard +- 1 
> > degree would make any difference.
> 
> You haven't pushed your system, or run it in a hostile
> environment then.  There are many places where systems are run
> right up to the edge of thermal breakdown, and it's a firm
> requirement to know exactly what that edge is.
> 
 I didn't pushed my system because I belive it performs well without
overclocking. There are a lot of chances to fry the chip, and for this
reason I use my system at the frequency my manufacturer gave it to me.


>  
> > If a CPU runs fine at, say, 37 degrees C, I do not belive it 
> > will have any problems running at 38 or 36 degrees. I support
> > the ideea of having very good sensors for temperature
> > monitoring, but CPU and motherboard temperature do not depend
> > on the rise of the temperature of 1 degree, but when the
> > temperature rises 10 or more degrees. I hope you understand
> > what I want to say.
> 
> I have a CPU that runs great up to 43C, and shuts down hard at 44C
> so I obviously want to know how close I am to that.  I don't want
> rounding errors to get in the way, and I don't want changes
> between kernel revs to affect it either.
> 

It might be as you say, but I really do not belive that your chip will fry
at 44C. I never seen a chip that fried becasue the temperature was 1
degree greater that the one it supposed to work at. And I worked with a
lot of CPU's and motherboards.


> If we've got the bitspace, keep the counters as granular as
> possible within the useable range that we're designing for.
> 
> counter = .01 * degrees kelvin
> 

I said, and now I'll say it again: I support the ideea of having very high
precission, BUT this is not the case for personal computer, this may
concern high-end systems that must run in a controlled environment at a
fixed temperature.

> 
> 


