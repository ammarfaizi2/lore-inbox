Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130053AbRB1DqN>; Tue, 27 Feb 2001 22:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130054AbRB1DqE>; Tue, 27 Feb 2001 22:46:04 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:50119 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130053AbRB1Dpq>; Tue, 27 Feb 2001 22:45:46 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE0C9@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'jt@hpl.hp.com'" <jt@hpl.hp.com>, Greg KH <greg@wirex.com>,
        Dag Brattli <dag@brattli.net>, linux-kernel@vger.kernel.org
Subject: RE: [patch] patch-2.4.2-irda1 (irda-usb)
Date: Tue, 27 Feb 2001 19:43:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jean Tourrilhes [mailto:jt@bougret.hpl.hp.com]
> 
> 	First thanks for Dag for bringing me into the conversation. I
> may add my little bit of spice, especially that I was the one pushing
> for having the driver in .../drivers/net/irda.
> 	By the way, Greg, sorry if I hurt your feeling, I don't want
> to put down any of the great work that has been done on the USB stack.
> 
> 	My feeling is that devices are mostly defined by their higher
> level interface, because this is what is closer to the user.
> 	If I look at a Pcmcia Ethernet card, I will tend to associate
> more with a PCI Ethernet card rather than a Pcmcia SCSI card. Both
> card have the same high level interface (TCP/IP) even if their low
> level interface is different (Pcmcia, PCI).
> 	People tend to agree with that, and that's why you have
> directories called drivers/net, drivers/scsi and driver/sound, rather
> that drivers/pci, drivers/isa, drivers/mca and drivers/pcmcia.
> 
> 	If I get an IrDA-USB dongle, the feature that matter the most
> is that it does IrDA, the fact that it connect to my PC via USB is
> rather secondary.
> 	That's it. I hope it explain some of the rationale and why we
> departed from the usual drivers/usb arrangement. Actually, I think
> that stuffing all USB drivers in drivers/usb is not that great, but
> that's not my call...

That has been discussed & Linus like[ds] it that way.

~Randy
