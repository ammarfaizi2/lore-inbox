Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSHYLiI>; Sun, 25 Aug 2002 07:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSHYLiI>; Sun, 25 Aug 2002 07:38:08 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:24580 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317282AbSHYLiH>; Sun, 25 Aug 2002 07:38:07 -0400
Date: Sun, 25 Aug 2002 13:41:59 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@redhat.com>,
       Allan Duncan <allan.d@bigpond.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: Linux 2.4.20-pre4-ac1
Message-ID: <20020825114159.GD1293@louise.pinerecords.com>
References: <20020825110156.GB1107@louise.pinerecords.com> <Pine.LNX.4.44.0208250508280.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208250508280.3234-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 3:32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > "Warning: Limiting speed since you did not use an 80-conductor cable"
> > 
> > Pronouns should generally be avoided in formulations such as this one,
> > simply because there's no way to tell who it really was who didn't use
> > an 80-conductor cable. Go with a passive sentence instead.
> 
> "Warning: The speed was limited because the 80-conductor cable wasn't used 
> (and got annoyed for that reason)."?
> "Warning: 80-conductor cable wasn't, so it must have been the speed 
> which got used to reducing itself."

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST380021A, ATA DISK drive
hdc: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
hdd: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide0:
    It appears an 80-conductor cable is not in use.
    => Transfer rates above UDMA2 won't work.
ide1:
    It appears an 80-conductor cable is not in use.
    => Transfer rates above UDMA2 won't work.
...
