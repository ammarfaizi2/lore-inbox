Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282553AbRKZVKL>; Mon, 26 Nov 2001 16:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282551AbRKZVJz>; Mon, 26 Nov 2001 16:09:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54535 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282550AbRKZVJl>; Mon, 26 Nov 2001 16:09:41 -0500
Date: Mon, 26 Nov 2001 16:03:16 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
In-Reply-To: <m1d726zwdm.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.96.1011126154312.27112H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001, Eric W. Biederman wrote:

> Bah.  Some of the worst kernels I have seen have been distributors kernels.
> Distributors seem to give in to the desire for more features, and don't
> address the deep bugs.  

You use the wrong distributor, try Alan Cox ;-)
 
> What the developers produce primarily are correct kernels, especially
> Linus.  I have never seen a distribution make a kernel more correct.
> Instead what I have seen is distributors testing on a wide variety of
> hardware and for those things that don't work they throw in the
> current best work around.

I would regard a stable kernel which doesn't compile, or which corrupts
filesystems in operation normal to all systems (umount) as correctness
issues, which should be caught if even the smallest QA were being done.

> Also distributors during development don't have the same number of
> people testing a kernel as the global linux kernel project has.

A point some folks sem to have missed.

> To date Alan Cox has done a great job in maintaining the stable 2.2
> series.  Giving us all something we can use reliably without fear.
> And while I haven't watched it religiously Alan Cox has done the whole
> release candidate thing, which really does help to catch stupid
> typos..  And hopefully in his one way Marcello Tosatti will as well.
> I honestly expect future 2.4.x kernels to be much more stable.

> Linus has admitted he really doesn't have the temperament for
> maintaining a long term stable release.  But as we have all seen he
> does have the temperament to lead a development kernel.  And his
> stepping down now from the stable branch now that the core of the
> kernel is correct is the best sign for stability for 2.4.x that I have
> seen.

Agreed. But I would like to have seen it sooner, allowing all the
developmental stuff to be fully developed in 2.5 before it was dropped
into 2.4. By putting new features in 2.4.x we had the worst of possible
results, end users got a less stable kernel and developers were slowed
down by release cycles. This didn't really make anyone happy, I believe. I
expect both 2.4 and 2.5 to work better now.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

