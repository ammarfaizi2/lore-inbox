Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312353AbSCYThk>; Mon, 25 Mar 2002 14:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312517AbSCYThV>; Mon, 25 Mar 2002 14:37:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55310 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312353AbSCYThK>; Mon, 25 Mar 2002 14:37:10 -0500
Date: Mon, 25 Mar 2002 14:34:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
In-Reply-To: <E16pWpL-0000pg-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1020325141655.4219A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002, Alan Cox wrote:

> > The device is hot-swap capable and has a switch (others have a key) 
> > that locks the drive in and powers it up; in the other position the 
> > drive is powered down and can be removed.
> 
> Linux doesn't support IDE hot swap at the drive level. Its basically
> waiting people to want it enough to either fund it or go write the code

  The way you say that makes me think that it does support at some other
level... hot swap controller? Doesn't match MY hardware. Hot swap
partitions? While I get amusing imaginations of cutting and pasting thin
film off a platter, I guess that's not it either. Media? Unless some hot
swap were to totally duplicate the IDE-FLOPPY code, I don't see that
either.

  Actually, I'm almost sure that I have booted a system with a drive in,
unregistered it, swapped it, and reregistered it. Unfortunately that
system is in a closet and hundreds of miles away, so I won't just check
right now. But it was built on a junk 486 just to allow insertion of a
pile of old 360 and 520MB drives which were being backed up to CD without
even checking the contents, just so the drives could be recycled.

  Since the project was closed and I got paid, I assume that worked. 
Either that or the part-timer who did the work shipped about 70 copies of
the bad music he liked and the client never looked :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

