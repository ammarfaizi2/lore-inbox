Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSGDWOr>; Thu, 4 Jul 2002 18:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSGDWOq>; Thu, 4 Jul 2002 18:14:46 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:27657
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314514AbSGDWOp>; Thu, 4 Jul 2002 18:14:45 -0400
Date: Thu, 4 Jul 2002 15:15:47 -0700 (PDT)
From: Andre Hedrick <andre@serialata.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: hd_geometry question.
In-Reply-To: <20020704090926.GA22609@win.tue.nl>
Message-ID: <Pine.LNX.4.10.10207041515210.19028-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well it just got adopted to 528 --- whoop !

On Thu, 4 Jul 2002, Andries Brouwer wrote:

> On Thu, Jul 04, 2002 at 01:48:33AM +0200, Roman Zippel wrote:
> 
> > > It is rumoured that certain MO disks with a hardware sector size
> > > of 2048 bytes have partition tables in units of 2048-byte sectors.
> > 
> > Why is it a rumour? AFAIK under DOS/Windows the partition table is in
> > units of sector size.
> 
> I assume you mean hardware sector size.
> 
> Yes, that is what I wrote in
> 	http://www.win.tue.nl/~aeb/partitions/partition_tables-2.html#ss2.1
> 
> Sector size different from 512 is rare, so it is a bit difficult to find
> precise details. Do you have docs?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Serial ATA Solutions
LAD Storage Consulting Group

