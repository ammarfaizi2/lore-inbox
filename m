Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbTBQNfN>; Mon, 17 Feb 2003 08:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTBQNfM>; Mon, 17 Feb 2003 08:35:12 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:13952 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267050AbTBQNfL>; Mon, 17 Feb 2003 08:35:11 -0500
Date: Mon, 17 Feb 2003 22:43:33 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (0/26) summary
Message-ID: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch's to support NEC PC-9800 subarchitecture
against 2.5.61.

Comments and test reports are wellcome.


Description:
 o alsa-pc98.patch (1/26)
   ALSA sound drivers for PC98.
 o apm.patch (2/26)
   APM support for PC98. Including PC98's BIOS bug fix.
 o arch-i386-mach-pc98.patch (3/26)
   Files under arch/i386/mach-pc9800 directory.
 o boot98.patch (4/26)
   Files under arch/i386/boot98 directory.
 o char_device.patch (5/26)
   Real time clock driver and printer driver for PC98.
 o console.patch (6/26)
   PC98 Standard console support (without japanese kanji character).
 o core-misc.patch (7/26)
   Small core patches for PC98.
 o core.patch (8/26)
   Core patches for PC98. Big changes using mach-* scheme.
 o dma.patch (9/26)
   DMA support for PC98.
 o floppy98-1.patch (10/26)
 o floppy98-2.patch (11/26)
   Driver for PC98 standard floppy disk drive.
 o fs.patch (12/26)
   FAT fs and partition table support for PC98.
 o ide.patch (13/26)
   PC98 standard IDE I/F support.
 o input.patch (14/26)
   Drivers for PC98 standard keyboard/mouse.
 o kanji.patch (15/26)
   japanese kanji character support for PC98 console.
 o network_card.patch (16/26)
   C-bus(PC98's legacy bus like ISA) network cards support.
 o parport.patch (17/26)
   Parallel port support.
 o pci.patch (18/26)
   Small changes for PCI support.
 o pcibios.patch (19/26)
   PCI BIOS function support using mach-* scheme.
 o pcmcia.patch (20/26)
   Small change for PCMCIA (16bits) support.
 o pnp.patch (21/26)
   Small change for Legacy bus PNP support.
 o reboot.patch (22/26)
   Support difference of machine reboot method, using mach-* scheme.
 o scsi.patch (23/26)
   SCSI host adapter support.
 o serial.patch (24/26)
   Serial port support for PC98.
 o smp.patch (25/26)
   SMP support for PC98.
 o video_card.patch (26/26)
   PC98 standard video card text mode driver.

Regards,
Osamu Tomita

