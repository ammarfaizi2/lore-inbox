Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAPV7b>; Tue, 16 Jan 2001 16:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRAPV7V>; Tue, 16 Jan 2001 16:59:21 -0500
Received: from gnwy29.wuh.wustl.edu ([128.252.22.29]:10764 "EHLO
	gnwy29.wuh.wustl.edu") by vger.kernel.org with ESMTP
	id <S129561AbRAPV7G>; Tue, 16 Jan 2001 16:59:06 -0500
Date: Tue, 16 Jan 2001 16:01:20 -0600 (CST)
From: "Rodney M. Jokerst" <rmjokers@gnwy29.wuh.wustl.edu>
To: Nathan Thompson <nate@thebog.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem:  Blank screen in X after heavy disk access (2.4 only)
In-Reply-To: <20010116164329.A1247@eliot.thebog.net>
Message-ID: <Pine.LNX.4.21.0101161600000.24100-100000@gnwy29.wuh.wustl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I have the same motherboard / chipset.  Thanks for your help!

Rodney M. Jokerst

On Tue, 16 Jan 2001, Nathan Thompson wrote:

> On Tue, Jan 16, 2001 at 03:11:01PM -0600, Rodney M. Jokerst wrote:
> > This action causes my screen to go blank in X and remain blank
> > unless I move the mouse or type on the keyboard.  The second I stop doing
> > one of these activities, it goes blank again.  While it is blank, it seems
> > to be flashing every second, as if it is recieving blank screen commands
> > repeatedly.  This behavior continues until I restart the machine.  If I
> > switch to a console, everything is fine.  If I restart the X server, the
> > behavior continues.
> 
> Is this a VIA chipset based motherboard?
> 
> If so someone (Vojtech Pavlik ?) has a patch that helps this... 
> It is a hardware error.
> 
> For what it's worth I have seen this exact same behavior on my machine
> in 2.2.x.
> 
> I have an abit ka7 motherboard, via kx133 chipset.
> 
> Nate
> 
> > thanks,
> > 
> > Rodney M. Jokerst
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
