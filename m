Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317339AbSFGUOB>; Fri, 7 Jun 2002 16:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317340AbSFGUOA>; Fri, 7 Jun 2002 16:14:00 -0400
Received: from dc-mx09.cluster1.charter.net ([209.225.8.19]:42462 "EHLO
	mx09.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S317339AbSFGUN7>; Fri, 7 Jun 2002 16:13:59 -0400
Message-ID: <002101c20e5f$da262490$420aa8c0@beast>
From: "Raptorfan" <raptorfan@earthlink.net>
To: <linux-kernel@vger.kernel.org>
Subject: Status of Artop AEC865 support in mainline (2.4) kernel
Date: Fri, 7 Jun 2002 16:13:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone clarify the status of support for the Artop AEC865 chipset in the
2.4.x kernel series? Digging thru the archives, I see what appears to be at
least a more current aec62xx.c ('Version 0.11        March 27,
2002/Copyright (C) 1999-2000     Andre Hedrick (andre@linux-ide.org)' in the
head of the file) than what is included in the 2.4.18 & 2.4.19-pre patches
(version 0.09). I also saw the Andre/Vojtech 'exchange' on copyright, so I
know some 'issues' exist with the sourcefile in question. Can anyone direct
me to version 0.11 of the aec62xx.c file (and any other updated files it
depends on)?

My card is a Siig CN2487, SC-PE4B12 UltraATA/133; they have a 'driver'
listed on their site, which appears to be a hacked group of files
(aec62xx.c, ide-dma.c, ide-pci.c, pci.ids, pci_ids.h)
(http://www.siig.com/drivers/ide_pc_pci_driver.html) but is quite picky on
compiling into a kernel. They also appear to be based on older versions of
pciutils (before 2.1.10; header of pci.ids contains '$Id: pci.ids,v 1.62
2000/06/28 10:56:36 mj Exp $'). Will this card be supported in the
near/foreseeable future or should I take it back and find a more
Linux-friendly card?

Thank you all for your time and efforts,

-r

