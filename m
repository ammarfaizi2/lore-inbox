Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314394AbSD0S70>; Sat, 27 Apr 2002 14:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSD0S70>; Sat, 27 Apr 2002 14:59:26 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:12967 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S314394AbSD0S7X>; Sat, 27 Apr 2002 14:59:23 -0400
Date: Sat, 27 Apr 2002 12:59:17 -0600
Message-Id: <200204271859.g3RIxHo16889@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Larry McVoy <lm@bitmover.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <20020422101750.D17613@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:
> On Sun, Apr 21, 2002 at 06:21:27PM +0200, Daniel Phillips wrote:
> > > It's not my call to make.
> > 
> > I know that.  I was wondering if *you personally* would have any objection.
> 
> Daniel, I won't be nagged into supporting your point of view, sorry.
> I didn't even know that the doc was in the tree until you raised the
> point.  I don't see a problem with it being in the tree and I do *not*
> support your attempts to remove it.
> 
> You seem to think it has some great value to BitMover to have it in
> the tree.  Sorry, that's not true.  It's true to some small extent, in
> that it may reduce the number of support queries that we get related to
> the kernel.  So we'd prefer it stayed in the tree.
> 
> Why don't you ask Jeff to stick in the doc saying something like
> 
>     BitKeeper is not free software.  You may use it for free, subject
>     to the licensing rules (bk help bkl will display them), but it is
>     not open source.  If you feel strongly about 100% free software
>     tool chain, then don't use BitKeeper.  Linus has repeatedly stated
>     that he will continue to accept and produce traditional "diff -Nur"
>     style patches.  It is explicitly not a requirement that you use
>     BitKeeper to do kernel development, people may choose whatever tool
>     works best for them.

I've added two subsections to the FAQ about this, which I hope will
avoid some future flamewars:
http://www.tux.org/lkml/#s1-20
http://www.tux.org/lkml/#s1-21

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
