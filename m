Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288117AbSACBwE>; Wed, 2 Jan 2002 20:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288130AbSACBvy>; Wed, 2 Jan 2002 20:51:54 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:59024 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S288129AbSACBvq>; Wed, 2 Jan 2002 20:51:46 -0500
Date: Wed, 2 Jan 2002 20:52:31 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <Pine.GSO.4.33.0201021812560.28783-100000@sweetums.bluetronic.net>
Message-ID: <Pine.LNX.4.33.0201022010340.10236-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Ricky Beam wrote:
...
> IDE is just fine for toys.  It's a serious pain in the ass for any serious
> work.

my goodness; it's been so long since l-k saw this traditional sport!
nothing much has changed in the intrim: SCSI still costs 2-3x as much,
and still offers the same, ever-more-niche set of advantages 
(decent hotswap, somewhat higher reliability, moderately higher performance,
easier expansion to more disks and/or other devices.)

> It takes expensive hardware RAID cards to make IDE tolerable. (and
> I'm not talking about the 30$ PoS HPT crap.)

besides having missed the last 2-3 generations of ATA (which include
things like diskconnect), you have clearly not noticed that entry-level
hardware with PoS UDMA100 controllers can sustain more bandwidth than
you can hope to consume (120 MB/s is pretty easy, even on 32x33 PCI!)

> PS: I once turned down a 360MHz Ultra10 in favor of a 167MHz Ultra1 because
>     of the absolutely shitty IDE performance.  The U1 was actually faster
>     at compiling software. (Solaris 2.6, btw)

yeah, if Sun can't make IDE scream, then no one can eh?

