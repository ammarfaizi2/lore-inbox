Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTAGWim>; Tue, 7 Jan 2003 17:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbTAGWim>; Tue, 7 Jan 2003 17:38:42 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62220
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267548AbTAGWij>; Tue, 7 Jan 2003 17:38:39 -0500
Date: Tue, 7 Jan 2003 14:45:51 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
In-Reply-To: <3E1B3A49.42F6370E@linux-m68k.org>
Message-ID: <Pine.LNX.4.10.10301071439190.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2003, Roman Zippel wrote:

> Hi,
> 
> Andre Hedrick wrote:
> 
> > Please continue to think of TCP checksums as valid for a data transport,
> > you data will be gone soon enough.
> > 
> > Initiator == Controller
> > Target == Disk
> > iSCSI == cable or ribbon
> > 
> > Please turn off the CRC on your disk drive and see if you still have data.
> 
> This maybe works as PR, but otherwise it's crap.

So, please turn off the CRC's in your onboard storage today and see how
long it lasts.

> With a network protocol you have multiple possibilities to increase the
> reliability. The lower you do it in the network layer the easier is it
> to put it into hardware and to optimize it and the more generically it's
> usable. Doing it in the protocol is only the last resort. The iSCSI
> protocol is a nice protocol - if you ignore all the crap the hardware
> vendors put in (that stuff only makes sense if you want to produce ultra
> cheap hardware).

I will be happy to see everyone turn off the CRC's on the data and headers
on their products or the open sources ones which fail to follow the rules.
I am well away of everyones contempt for standards.

Cheers,

Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

