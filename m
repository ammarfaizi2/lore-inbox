Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281468AbRKMEiL>; Mon, 12 Nov 2001 23:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281469AbRKMEhz>; Mon, 12 Nov 2001 23:37:55 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:41353 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281468AbRKMEhj>; Mon, 12 Nov 2001 23:37:39 -0500
Date: Mon, 12 Nov 2001 21:37:02 -0700
Message-Id: <200111130437.fAD4b2j17329@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <3BF09E44.58D138A6@mandrakesoft.com>
In-Reply-To: <200111130324.fAD3OE916102@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0111122249160.22925-100000@weyl.math.psu.edu>
	<200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca>
	<3BF09E44.58D138A6@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Richard Gooch wrote:
> > Alexander Viro writes:
> > > On Mon, 12 Nov 2001, Richard Gooch wrote:
> > > > Dave Jones writes:
> > > > > How about running mtrr.c & devfs code through scripts/Lindent
> > > > > sometime btw?
> 
> Go ahead and Lindent mtrr.c, it hasn't been touched by rgooch in a
> while...

Hey!

> > > > That would be a step backwards: I wouldn't be able to read my own code
> > > > then.
> > >
> > > You mean that you are unable to read any of the core kernel source?
> > > That would explain a lot...
> > 
> > Were you born rude, or did you have to practice it?
> 
> I would argue both ;-)  He is a Usenet denizen after all.
> (takes one to know one... I'm one as well :))

I gave up Usenet years ago, about when the signal to noise ratio fell
under 0.1% and I got tired of wasting time wading through the flames.

Now, on to your points about coding style. I'll say this once only. I
don't want to waste time with an argument about this.

> He and davej still have a point.  Your code formatting is
> non-standard, and is difficult to read.  A document exists
> CodingStyle which explains a good style, and further -why- it is a
> good style.

And one of the very first things that document says that coding style
is very personal and he doesn't want to force his views on others.
So, as a symbolic gesture, I printed out and burned that document.

> Among other reasons, because of long term maintenance.
> 
> How do you expect others in the Linux kernel community to review
> your code, if it is widely considered difficult to read?  How do you
> expect people to maintain your code when are no longer around?  The
> Linux kernel will be around long after you and I and others leave
> kernel development.  Others need to read and maintain this code.

If and when I step down as maintainer (if I do so, I'll publically
pass the baton to the new maintainer), the new maintainer can indent
to their preference. Until that time, *I'm* the maintainer, and *I*
need to be able to read the code efficiently. It's the part of the
kernel I spend the most time in, after all.

And the coding style used elsewhere in the kernel is revolting to
me. More importantly, it's harder for me to parse than my own style.
I shouldn't have to constantly stumble over an appalling coding style
in my own code!

"He who writes the code gets to choose".

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
