Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUDVRSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUDVRSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUDVRSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:18:05 -0400
Received: from wilma.widomaker.com ([204.17.220.5]:9227 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S264585AbUDVRR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:17:56 -0400
Date: Thu, 22 Apr 2004 12:19:58 -0400
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [somewhat OT] binary modules agaaaain
Message-ID: <20040422161957.GF16810@widomaker.com>
References: <Pine.LNX.4.33.0404191651300.1869-100000@pcgl.dsa-ac.de> <200404201611.07832.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404201611.07832.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, 20 Apr 2004 @ 16:11 +0200, Bartlomiej Zolnierkiewicz said:

> > A binary module is "considered good" if
> 
> This is a false assumption IMO no binary only modules can be "good".

True, but non-working hardware is even worse.

> I think that binary modules are evil because:
> 
> - they slow down development (indirectly - think about it)

I don't think this is true at all.

> - some vendors claim Linux support
>   while they only provide binary only modules

If they provide a binary for Linux, then they can claim Linux support.

We may not like it, but it is a legitimate claim.

> - less informed users tend to put blame on kernel or distribution
>   not the binary only module (!)

True, but this is just noise in the signal in terms of what the less
informed users think.

> I'm not a fanatic :-), I can see good sides of binary only modules:
> 
> - additional hardware and features is supported
> 
> - wider usage of Linux

- some driver code is tied up in legal issues that are not currently
  solvable

- For some hardware, only the company has enough knowledge to write
  a decent driver.  I can't blame a company for wanting to control
  the drivers for their hardware for quality reasons.

- As a user, I need to get work done, not play politics with my
  hardware.  I prefer open solutions, but each day I have work to
  do and can't afford to play politics with my hardware.

- I personally don't believe that building barriers to binary drives is
  helpful.  In fact, I think it ultimately means *less* open source
  from manufacturers.  I think of a good binary interface as a good
  ambassador.

> but I still think that cons > pros...

Of course.  We live in a highly imperfect world, and the computer
industry is among the most imperfect parts of it.

At the same time, we need to make sure that in our posturing and
political moves, we don't end up making things worse.

> > With this restrictions those "good" binary modules could be debugged, run
> > in a sandbox... The question remains if anybody will want to debug them:-)
> 
> In my opinion using binary only modules is equal to modifying your kernel
> but being unable to show your modifications so you are on your own and you
> shouldn't bring it on lkml.

Sounds illogical to me.

That's like saying that selling a turbocharger for a car is the same as
illegally copying the design of a car and selling it as your own.

> Useful thing will be to create mailing list about Linux kernel
> + binary only modules and to move discussion from lkml there...

True.  Also useful would be to get manufacturers involved in any
such list so you can hear from them.

-- 
shannon "AT" widomaker.com -- [4649 5920 4320 204e 4452 5420 5348 5920 4820
2056 2054 434d 2048 4d54 2045 204e 5259 4820 444e 0a53]
