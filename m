Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSHONX2>; Thu, 15 Aug 2002 09:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSHONX2>; Thu, 15 Aug 2002 09:23:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:22543
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316896AbSHONX1>; Thu, 15 Aug 2002 09:23:27 -0400
Date: Thu, 15 Aug 2002 06:18:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: ide-2.4.19-ac4.11.patch, late but stable
Message-ID: <Pine.LNX.4.10.10208150614300.12468-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is out, require 2.4.19 plus -ac4

http://www.linuxdiskcert.org/ide-2.4.19-ac4.11.patch.bz2

Cheers,

Andre Hedrick
LAD Storage Consulting Group
-----------------------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 3
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DTLA-307075, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LTN242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI3112 Serial ATA: IDE controller on PCI bus 00 dev 40
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA at 0xf8800000-0xf8800007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xf8800008-0xf880000f, BIOS settings: hdg:pio, hdh:pio
hde: ST*******, ATA DISK drive
ide2 at 0xf8800080-0xf8800087,0xf880008a on irq 11
hdg: ST*******, ATA DISK drive
ide3 at 0xf88000c0-0xf88000c7,0xf88000ca on irq 11



