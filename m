Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLWUG3>; Sat, 23 Dec 2000 15:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbQLWUGT>; Sat, 23 Dec 2000 15:06:19 -0500
Received: from magician.bunzy.net ([206.245.168.220]:3857 "HELO
	magician.bunzy.net") by vger.kernel.org with SMTP
	id <S129410AbQLWUGN>; Sat, 23 Dec 2000 15:06:13 -0500
Date: Sat, 23 Dec 2000 14:35:47 -0500 (EST)
From: tc lewis <tcl@bunzy.net>
To: Alex Buell <alex.buell@tahallah.clara.co.uk>
cc: Marcus Meissner <Marcus.Meissner@caldera.de>,
        "Mohammad A. Haque" <mhaque@haque.net>, linux-kernel@vger.kernel.org
Subject: Re: Netgear FA311
In-Reply-To: <Pine.LNX.4.30.0012231927200.4671-100000@tahallah.clara.co.uk>
Message-ID: <Pine.LNX.4.10.10012231431470.11359-100000@magician.bunzy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Dec 2000, Alex Buell wrote:

> On Sat, 23 Dec 2000, Marcus Meissner wrote:
> 
> > > Is this where you got the sources?
> > > http://www.scyld.com/network/natsemi.html (Thanks Steve)
> >
> > The linux driver is actually on the accompanying floppy disk. Without license
> > statement unfortunately.
> 
> I got a floppy disk with the netgear fa311, but the only linux sources on
> it was for 2.0.36!

yeah i believe that natsemi driver is supposed to work with that 311 card,
although i have heard of issues with that now and then.  to be honest i
haven't followed very closely, as i don't use those cards/chips.  that
scyld.com page should have all the info you need, as well as info on an
accompianing mailing list for further help.

if whatever distro/kernel you're using already has a compiled natsemi
driver you can just try it out by messing with /etc/conf.modules or
/etc/modules.conf or whatever proper files your distribution uses.

-tcl.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
