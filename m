Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262142AbSJDVlc>; Fri, 4 Oct 2002 17:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262122AbSJDVlc>; Fri, 4 Oct 2002 17:41:32 -0400
Received: from [166.90.172.6] ([166.90.172.6]:6176 "EHLO
	Mail.Linux-Consulting.com") by vger.kernel.org with ESMTP
	id <S262092AbSJDVlX>; Fri, 4 Oct 2002 17:41:23 -0400
Date: Fri, 4 Oct 2002 14:45:55 -0700 (PDT)
From: Alvin Oga <aoga@Maggie.Linux-Consulting.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: RAID backup
In-Reply-To: <20021004150752.B16727@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021004144054.10481B-100000@Maggie.Linux-Consulting.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi ya

mroe fun stuff

"drop tests" ... that person that tend to have "accidents" should be
kept outof the lab and away from hardware
	( ceo/cfo/managers dont wanna spend un-necessary $2K - $10k
	( because somebody dropped it ... or dropped a screw in a running
	( system

on the other hand... that clumbsy tech/engineer is purrfect ina
testing lab or qa lab where they do require drop tests for "submarine"
applications

have fun
alvin

- i never dropped a disks in 20 years... or mb or anything
  importnat/expensive

- dropped lots of screws, screwdrivers into "turned off systems" while
  working on it

- dropped tape drives too and sometimes the tape drives itself ejects the
  tapes too too fast
	- clumbsy me for not being able to catch the 'flying tape" as
	it ejects

- a months worth of daily tapes ( we keep 30 days worth of tape )
	takes up as much room as a 1U box.. 

	-  a 1U box can hold about 3 months worth of compressed data
	in our environment ... ( 3:1 compression on the average )


On Fri, 4 Oct 2002, Russell King wrote:

> On Fri, Oct 04, 2002 at 02:24:19PM +0100, Dr. David Alan Gilbert wrote:
> > Not sure about that; DLT tapes are pretty bulky themselves; I think the
> > difference between say a set of 4 DLT tapes and a single Maxtor 320 in
> > caddy would be minimal.
> 
> The 4 DLT tapes would take up twice the room.
> 
> > As for stored media, I think Maxtor are quoting
> > 1M hours MTTF - (I hate to think how you measure such a figure) - for
> > the 320G, and that is probably longer than I'd trust either the tape or
> > the drive to survive.
> 
> However, drive in caddy or no caddy, the accidental drop test would
> probably be more favourable to the DLT tape surviving over the drive.
> Physical accidents do happen.
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

