Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286087AbRLHX6w>; Sat, 8 Dec 2001 18:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286093AbRLHX6i>; Sat, 8 Dec 2001 18:58:38 -0500
Received: from a-night-at-the-opera.cu.groogroo.com ([64.5.70.200]:43270 "EHLO
	a-night-at-the-opera.cu.groogroo.com") by vger.kernel.org with ESMTP
	id <S286087AbRLHX6O>; Sat, 8 Dec 2001 18:58:14 -0500
Message-Id: <200112082358.fB8Nw1a06831@a-night-at-the-opera.cu.groogroo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
From: Arun Bhalla <bhalla@uiuc.edu>
Reply-To: Arun Bhalla <bhalla@uiuc.edu>
Subject: Re: Oops report for 2.2.19(ext3) 
In-Reply-To: <E16Cfg6-000185-00@the-village.bc.nu> 
Date: Sat, 08 Dec 2001 17:58:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
> > For at least a few months, if not most of the past year, my system
> > hasn't had an uptime longer than 14 days or so.  Every so often,
> 
> > (which has the same model of CPU and motherboard).  However, his
> > production server running 2.2.19 with slightly different hardware has
> > an uptime of 220 days.  I thought I'd finally send in an Oops report
> 
> That should be a clue. If you are using an AMD processor on a VIA chipset
> you may be hitting chipset bugs for one.

That's a good possibility.  The K7M motherboard has these two chipsets:

AMD-751 Northbridge
VIA 82C686A Southbridge

It sounds like there has been work towards correcting VIA chipset bugs in
2.4.  Is there an online resource available for reading about these bugs
and solutions?  I think I'll check for BIOS and driver updates from the
OEMs.

> > since work towards 2.2.20 appears to have been abandoned.  I have other
> 
> 2.2.20 was released ages ago

Wow, you're right, thanks... linuxhq.com hasn't noted this fact.


Thanks,
Arun
