Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313336AbSDOWzo>; Mon, 15 Apr 2002 18:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313338AbSDOWzn>; Mon, 15 Apr 2002 18:55:43 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29957
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313336AbSDOWzm>; Mon, 15 Apr 2002 18:55:42 -0400
Date: Mon, 15 Apr 2002 15:55:01 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Maxwell Spangler <maxwax@mindspring.com>
cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re:  [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup:
 idebus=66 -- BAD OPTION"
In-Reply-To: <Pine.LNX.4.44.0204151804100.1145-100000@tyan.doghouse.com>
Message-ID: <Pine.LNX.4.10.10204151553280.6776-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do not know what is left of the kernel base in 2.5 as I am out of the
development tree.  Somewhat offically kicked out of Linux.  After 2.4 pass
on so will I.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 15 Apr 2002, Maxwell Spangler wrote:

> On Mon, 15 Apr 2002, Meelis Roos wrote:
> 
> > MH> Kernel command line: BOOT_IMAGE=2.5.8-without-TCQ ro root=303 video=matrox:vesa:0x118 idebus=66 profile=2
> > MH> ide_setup: idebus=66
> > MH> ide: system bus speed 66MHz
> > 
> > MH> works like a charm :)
> > 
> > Do you really have an IDE controller that does 66 MHz PCI? What kind on IDE
> > controller is this?
> 
> I have a Promise Ultra133TX2 card on my shelf that is 32-bit PCI with 66Mhz 
> operation.
> 
> I don't know to what extent it is supported yet.. Andre?
> -- ----------------------------------------------------------------------------
> Maxwell Spangler                                                 Save Futurama!
> Program Writer                                               Sign the petition!
> Greenbelt, Maryland, U.S.A.                         http://www.gotfuturama.com/
> Washington D.C. Metropolitan Area 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

