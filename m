Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267849AbTAHTaa>; Wed, 8 Jan 2003 14:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267850AbTAHTaa>; Wed, 8 Jan 2003 14:30:30 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:14094
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267849AbTAHTa3>; Wed, 8 Jan 2003 14:30:29 -0500
Date: Wed, 8 Jan 2003 11:37:20 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
In-Reply-To: <20030108174827.A28042@ucw.cz>
Message-ID: <Pine.LNX.4.10.10301081136150.31168-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Vojtech Pavlik wrote:

> On Tue, Jan 07, 2003 at 02:45:51PM -0800, Andre Hedrick wrote:
> 
> > > Andre Hedrick wrote:
> > > 
> > > > Please continue to think of TCP checksums as valid for a data transport,
> > > > you data will be gone soon enough.
> > > > 
> > > > Initiator == Controller
> > > > Target == Disk
> > > > iSCSI == cable or ribbon
> > > > 
> > > > Please turn off the CRC on your disk drive and see if you still have data.
> > > 
> > > This maybe works as PR, but otherwise it's crap.
> > 
> > So, please turn off the CRC's in your onboard storage today and see how
> > long it lasts.
> 
> 1) Bad comparison.
> 
> 2) It'd last very very long, because I never get a CRC error anyway.

So turn them off so it never checks, nevermind :-)

--ah

