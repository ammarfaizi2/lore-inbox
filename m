Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbTACOh5>; Fri, 3 Jan 2003 09:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbTACOh5>; Fri, 3 Jan 2003 09:37:57 -0500
Received: from otter.mbay.net ([206.55.237.2]:21510 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S267525AbTACOh4>;
	Fri, 3 Jan 2003 09:37:56 -0500
Date: Fri, 3 Jan 2003 06:46:23 -0800 (PST)
From: John Alvord <jalvo@mbay.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <3E159336.F249C2A1@aitel.hist.no>
Message-ID: <Pine.LNX.4.20.0301030645040.31823-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003, Helge Hafting wrote:

> Andrew Walrond wrote:
> > 
> > Yes but....
> > 
> > I develop computer games. The last one I did took a team of 35 people 2
> > years and cost $X million to develop.
> > 
> > Please explain how I could do this as free software, while still feeding
> > my people? 
> 
> > Am I a bad person charging for my work?
> No.
> > 
> > Really - I want to understand so I too can join this merry band of happy
> > people giving everything away for free!
> > 
> Nobody give everything away from free.  Free software, in particular,
> runs
> on boxes that cost money.  And people sell service and support.
> 
> The problem with nvidia isn't that they charge money.  The problem
> is that their product comes with strange restrictions.  
> 
> Everybody accepts that a nvidia cards cost money - chips and boards
> certainly aren't free.  They even provide drivers for their card
> for free.  They can trivially do this because they make their
> money on selling the hardware.
> 
> The problems are:
> 1) The drivers are closed-source, so we can't fix the bugs.  (Yes,
>    there are bugs, and no, nvidia don't fix them immediately.  So
>    it'd be nice for us who understand C to fix this ourselves.
>    Releasing the code don't won't cost nvidia because they aren't
>    making money on it.  They might actually sell _more_ hardware
>    if they released the code.  So keeping it secret don't make sense
>    even from a extreme greediness viewpoint.  Such a driver can't
>    be made to work with a competing product either with a few tweaks.
> 
> 2) Still, they _may_ have reasons not to release the code, perhaps
>    a patended algorithm or some such.  They could at least release the
>    specs for their card, so a free driver could be written from scratch.
>    But they don't do that either - strange.  Some manufacturers _do_
>    this, with no ill effects.  They get a slightly bigger market because
>    their equipment is ok with the free software world.  
Another possibility is that they used some propriatary software libraries
which have restrictions. Didn't someone see some strings which suggested
that?

> 
> This is very much like selling cars were the gas tank is locked, and
> you don't have the key.  The gas stations have keys, but only
> some of them.  So you can't fill anywhere.  
> Or a tv that don't work on thursdays. Silly in the extreme,
> annoying for the user and no benefit for the manufacturer.
> 
> Helge Hafting
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

