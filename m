Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271080AbTGWCYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 22:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271089AbTGWCYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 22:24:08 -0400
Received: from CPE-65-29-18-15.mn.rr.com ([65.29.18.15]:63660 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S271080AbTGWCYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 22:24:03 -0400
Subject: Re: Promise SATA driver GPL'd
From: Shawn <core@enodev.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Erik Andersen <andersen@codepoet.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10307221852030.8687-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10307221852030.8687-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058927928.8504.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 21:38:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holy piss Andre, you've got to be one of the funnier kernel guys...

On Tue, 2003-07-22 at 20:59, Andre Hedrick wrote:
> It is a HUGE POS!
> 
> The obfustication (sp) level is so high you wonder why.
> It may be GPL, but only goes to prove a few points that everyone lost on
> me in the past.
> 
> OEM drivers in ATA suck!  Their CAM blows goat.
> 
> Look at the crap in the stack when Marcelo was suckered into taking a
> "Promise Patch".
> 
> I have already cut all ties with Promise so here is the deal.
> I no longer have to count the number of fingers on my hand between hand
> shakes.  IE no extras and not shortages.
> 
> I wish you well in your adventures in pain.
> 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Tue, 22 Jul 2003, Erik Andersen wrote:
> 
> > Some folk I've done some consulting work for bought a zillion
> > Promise SATA cards.  They were able to convince Promise to
> > release their SATA driver, which was formerly available only as 
> > a binary only kernel module, under the terms of the GPL.
> > 
> > So <drum-roll, trumpets> here it is: the Promise SATA driver for
> > the PDC20318, PDC20375, PDC20378, and PDC20618.  This driver is
> > released as-is.  It is useful for the
> > 
> > 	Promise SATA150 TX4
> > 	Promise SATA150 TX2plus
> > 	Promise SATA 378
> > 	Promise Ultra 618
> > 
> > cards.  As a temporary download location, the GPL'd driver can be
> > obtained from http://www.busybox.net/pdc-ultra-1.00.0.10.tgz
> > 
> > Have fun!  And many thanks to Promise for contributing the driver
> > for their cards!
> > 
> >  -Erik
> > 
> > --
> > Erik B. Andersen             http://codepoet-consulting.com/
> > --This message was written using 73% post-consumer electrons--
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
