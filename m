Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbTA3IhT>; Thu, 30 Jan 2003 03:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267445AbTA3IhT>; Thu, 30 Jan 2003 03:37:19 -0500
Received: from users.evp.sf.ukrtel.net ([195.5.3.162]:26889 "EHLO
	users.evp.sf.ukrtel.net") by vger.kernel.org with ESMTP
	id <S267446AbTA3IhS>; Thu, 30 Jan 2003 03:37:18 -0500
Date: Thu, 30 Jan 2003 10:47:00 +0200 (EET)
From: Andrei Loukinykh <avl@seavenue.net>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi fails with kernels > 2.4.1
Message-ID: <Pine.LNX.4.20.0301301045560.24862-100000@users.evp.sf.ukrtel.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi all
  Being a sort of god damn tired (sorry), i decided to ask here

 In short:
   My CDRW refuses to work with any kernel bigger than 2.4.1.

It is IDE-CDRW . I use ide-scsi driver for this.
With 2.4.1 - all o'k.
 Then I tried 2.4.7 ... 2.4.9 ... 2.4.19.. 2.4.20 ( i dont remember al of
them) - none works. I get the following:

hdc: SAMSUNG CD-R/RW SW-408B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c030e544, I/O limit 4095Mb (mask 0xffffffff)
hda: 12672450 sectors (6488 MB), CHS=788/255/63, UDMA(33)
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0x04


Someone please help
 I desperately need 2.4.20 for my devices to work, but I also need CDR..



Best regards,
Andrei V. Loukinykh , Evpatoria Ukrtelecom ISP, +380 6569 29376
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"UNIX is like a vigvam - no Windows, no Gates and an Apache inside"



