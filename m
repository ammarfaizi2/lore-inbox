Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281471AbRKMFBd>; Tue, 13 Nov 2001 00:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281473AbRKMFBY>; Tue, 13 Nov 2001 00:01:24 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46729 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281471AbRKMFBI>; Tue, 13 Nov 2001 00:01:08 -0500
Date: Mon, 12 Nov 2001 22:00:32 -0700
Message-Id: <200111130500.fAD50Wi17879@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <3BF0A788.8CCBC91@mandrakesoft.com>
In-Reply-To: <200111130324.fAD3OE916102@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0111122249160.22925-100000@weyl.math.psu.edu>
	<200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca>
	<3BF09E44.58D138A6@mandrakesoft.com>
	<200111130437.fAD4b2j17329@vindaloo.ras.ucalgary.ca>
	<3BF0A788.8CCBC91@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Richard Gooch wrote:
> > > Among other reasons, because of long term maintenance.
> > >
> > > How do you expect others in the Linux kernel community to review
> > > your code, if it is widely considered difficult to read?  How do you
> > > expect people to maintain your code when are no longer around?  The
> > > Linux kernel will be around long after you and I and others leave
> > > kernel development.  Others need to read and maintain this code.
> > 
> > If and when I step down as maintainer (if I do so, I'll publically
> > pass the baton to the new maintainer), the new maintainer can indent
> > to their preference. Until that time, *I'm* the maintainer, and *I*
> > need to be able to read the code efficiently. It's the part of the
> > kernel I spend the most time in, after all.
> 
> You argue that others reviewing your code is worthless?
> That you are the only one reading your code?

I didn't say that at all! But since I'm the one maintaining that code,
it makes sense that it's easiest for me to read, since I'm the most
frequent reader (and writer).

But that's beside the point. Linus has stated that he doesn't want to
force coding style upon others, unless it's something that he has to
maintain. Since he doesn't maintain devfs, that doesn't apply.

If Linus makes the decision to change that policy, and *force* all
code into the one style, I'll have to put up with that, although I'll
grumble. And I'll scream blue murder if it's just *my* code that gets
changed; I note that not all of the kernel conforms to Linus'
preferred style. Right now I feel picked on.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
