Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSGRQtI>; Thu, 18 Jul 2002 12:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318278AbSGRQtI>; Thu, 18 Jul 2002 12:49:08 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26632 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318277AbSGRQtG>; Thu, 18 Jul 2002 12:49:06 -0400
Date: Thu, 18 Jul 2002 12:46:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
In-Reply-To: <3D361091.13618.16DC46FB@localhost>
Message-ID: <Pine.LNX.3.96.1020718123016.8220B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Guillaume Boissiere wrote:

> I broke down my status list into 3 categories: 
> - likely to be merged before the Halloween feature freeze
> - likely not to be ready by Halloween
> - ongoing work

Before I start asking what about XXX, is there a list of what major stuff
is already considered to be in? I don't see some things on your list,
perhaps you regard them as done.

> After feature freeze:

I really hope these do get in!
 
> o New kernel build system (kbuild 2.5)            (Keith Owens)
	I fear Keith might go SPC if this had to wait for 2.7
> o Add XFS (A journaling filesystem from SGI)      (XFS team)
> o Asynchronous IO (aio) support                   (Ben LaHaise)
> o LVM (Logical Volume Manager) v2.0               (LVM team)
	I thought these were all progressing nicely
> o Page table sharing                              (Daniel Phillips)
> o ext2/ext3 online resize support                 (Andreas Dilger)
	Definitely want to stabilize these
> o UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)
	Hopefully this is close as well
> o Full compliance with IPv6                       (Alexey Kuznetzov, Jun Murai, Yoshifuji Hideaki, USAGI team)
	could ease in 2.6.x if not?
> o Add support for NFS v4                          (NFS v4 team)
	This really shouldn't wait for 2.8!
> o Remove the 2TB block device limit               (Peter Chubb)
	This would help db folks now, and who knows how big
	a single drive will be before 2.7?
> o Overhaul PCMCIA support                         (David Woodhouse, David Hinds)
	Sure would be nice if it worked on desktops as well as laptops
> o Add thrashing control                           (Rik van Riel)

I sure would like to see documentation improvements on this list! For 2.6
it would be beautiful is no features went into /proc/sys unless they went
into the Documentation directory as well.	

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

