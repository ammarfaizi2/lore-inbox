Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbRBEBSy>; Sun, 4 Feb 2001 20:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132582AbRBEBSp>; Sun, 4 Feb 2001 20:18:45 -0500
Received: from mdmgrp2-250.accesstoledo.net ([207.43.107.250]:60685 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S132553AbRBEBSb>;
	Sun, 4 Feb 2001 20:18:31 -0500
Date: Sun, 4 Feb 2001 20:18:18 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: Tom Eastep <teastep@seattlefirewall.dyndns.org>
cc: Josh Myer <jbm@joshisanerd.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org>
Message-ID: <Pine.LNX.4.21.0102042015350.5276-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Feb 2001, Tom Eastep wrote:

> Thus spoke Michael B. Trausch:
> 
> > On Sat, 3 Feb 2001, Josh Myer wrote:
> >
> > > Hello all,
> > >
> > > I know this _really_ isn't the forum for this, but a friend of mine has
> > > noticed major, persistent clock drift over time. After several weeks, the
> > > clock is several minutes slow (always slow). Any thoughts on the
> > > cause? (Google didn't show up anything worthwhile in the first couple of
> > > pages, so i gave up).
> > >
> >
> > I'm having the same problem here.  AMD K6-II, 450 MHz, VIA Chipset, Kernel
> > 2.4.1.
> >
> 
> 
> The video on this system is an onboard ATI 3D Rage LT Pro; I use vesafb
> rather than atyfb because the latter screws up X.
> 

I'm not using any framebuffer on my machine (I have an ATI 3D Rage 128
Pro, myself).  I use the standard 80x50 console, and X when I need
it.  I'm about to put Debian on the system and see how that works and if I
like it, I just got the .ISO of disc 1 downloaded (after about a week) and
now it's burning.  (I hate having a 33.6 connection!)

However the clock drift didn't happen as much, if at all, with 2.2.xx
kernels.  It's kept itself pretty well sane.  But now I'm losing something
on the order of a half hour a week - that didn't happen before.

	- Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
