Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbRAQD1p>; Tue, 16 Jan 2001 22:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbRAQD1f>; Tue, 16 Jan 2001 22:27:35 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:62933 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129825AbRAQD1a>; Tue, 16 Jan 2001 22:27:30 -0500
Date: Tue, 16 Jan 2001 22:27:14 -0500 (EST)
From: Shane Shrybman <shane@zeke.yi.org>
To: "Rodney M. Jokerst" <rmjokers@gnwy29.wuh.wustl.edu>
cc: Nathan Thompson <nate@thebog.net>, linux-kernel@vger.kernel.org
Subject: Re: Problem:  Blank screen in X after heavy disk access (2.4 only)
In-Reply-To: <Pine.LNX.4.21.0101161600000.24100-100000@gnwy29.wuh.wustl.edu>
Message-ID: <Pine.LNX.4.21.0101162216560.2165-100000@zeke.goatskin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Rodney M. Jokerst wrote:

> Yes, I have the same motherboard / chipset.  Thanks for your help!
> 
> Rodney M. Jokerst
> 
> On Tue, 16 Jan 2001, Nathan Thompson wrote:
> 
> > On Tue, Jan 16, 2001 at 03:11:01PM -0600, Rodney M. Jokerst wrote:
> > > This action causes my screen to go blank in X and remain blank
> > > unless I move the mouse or type on the keyboard.  The second I stop doing
> > > one of these activities, it goes blank again.  While it is blank, it seems
> > > to be flashing every second, as if it is recieving blank screen commands
> > > repeatedly.  This behavior continues until I restart the machine.  If I
> > > switch to a console, everything is fine.  If I restart the X server, the
> > > behavior continues.
> > 
> > Is this a VIA chipset based motherboard?
> > 
> > If so someone (Vojtech Pavlik ?) has a patch that helps this... 
> > It is a hardware error.
> > 
> > For what it's worth I have seen this exact same behavior on my machine
> > in 2.2.x.

I think the work around patch was included in 2.2.19pre2, does it still
occur with that or later 2.2 kernels?

> > 
> > I have an abit ka7 motherboard, via kx133 chipset.

I have the same board. Can someone point me to the patch for 2.4?

This is a problem for me because it requires a reboot to fix and who 
likes rebooting? :)

btw: I have received several private emails from people having this
problem, (so it is biting people). Just a polite beg that it might
be included in 2.4.

Cheers,

shane

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
