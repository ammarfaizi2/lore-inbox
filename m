Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSHZAVJ>; Sun, 25 Aug 2002 20:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSHZAVJ>; Sun, 25 Aug 2002 20:21:09 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:59131 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317701AbSHZAVI>; Sun, 25 Aug 2002 20:21:08 -0400
Message-ID: <3D697546.4D67DFFE@bigpond.com>
Date: Mon, 26 Aug 2002 10:24:38 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tomas Szepe <szepe@pinerecords.com>,
       Thunder from the hill <thunder@lightweight.ods.org>,
       Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@redhat.com>,
       andre@linux-ide.org
Subject: Re: Linux 2.4.20-pre4-ac1
References: <20020825110156.GB1107@louise.pinerecords.com> <Pine.LNX.4.44.0208250508280.3234-100000@hawkeye.luckynet.adm> <20020825114159.GD1293@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:
> 
> > > > "Warning: Limiting speed since you did not use an 80-conductor cable"
> > >
> > > Pronouns should generally be avoided in formulations such as this one,
> > > simply because there's no way to tell who it really was who didn't use
> > > an 80-conductor cable. Go with a passive sentence instead.
> >
> > "Warning: The speed was limited because the 80-conductor cable wasn't used
> > (and got annoyed for that reason)."?
> > "Warning: 80-conductor cable wasn't, so it must have been the speed
> > which got used to reducing itself."
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: ST380021A, ATA DISK drive
> hdc: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
> hdd: CD-532E-B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide0:
>     It appears an 80-conductor cable is not in use.
>     => Transfer rates above UDMA2 won't work.
> ide1:
>     It appears an 80-conductor cable is not in use.
>     => Transfer rates above UDMA2 won't work.
> ...

Maybe "80-conductor cable (ATA-66+)" would cover more bases.
