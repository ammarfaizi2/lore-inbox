Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbTCRNIj>; Tue, 18 Mar 2003 08:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbTCRNIj>; Tue, 18 Mar 2003 08:08:39 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:33152 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262369AbTCRNIi>; Tue, 18 Mar 2003 08:08:38 -0500
Date: Tue, 18 Mar 2003 22:18:39 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.65
Message-ID: <20030318131839.GA1059@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patchset to support NEC PC-9800 subarchitecture
against 2.5.65.

Please download archived patchset from URL
http://downloads.sourceforge.jp/linux98/2684/linux98-2.5.65.patch.tar.bz2

Comments and test reports are wellcome.

Description:
 o alsa-pc98.patch (1/30)
   ALSA sound drivers for PC98.
 o apm.patch (2/30)
   APM support for PC98. Including PC98's BIOS bug fix.
 o boot98.patch (3/30)
   PC98 boot support.
 o char_device.patch (4/30)
   PC98 specific character device driver support.
 o console.patch (5/30)
   PC98 Standard console support (without japanese kanji character).
 o core-misc.patch (6/30)
   Small patches for PC98 support core.
 o core.patch (7/30)
   Patches for PC98 support core.
 o dma.patch (8/30)
   DMA support for PC98.
 o floppy98-1.patch (9/30)
   PC98 standard floppy disk drives support. 1 of 2.
 o floppy98-2.patch (10/30)
   PC98 standard floppy disk drives support. 2 of 2.
 o fs.patch (11/30)
   FAT fs and partition table support for PC98.
 o ide.patch (12/30)
   PC98 standard IDE I/F support.
 o input.patch (13/30)
   PC98 standard keyboard and mouse support.
 o kanji.patch (14/30)
   japanese kanji character support for PC98 console.
 o kconfig.patch (15/30)
   Add selection for CONFIG_X86_PC9800.
 o network_card.patch (16/30)
   C-bus(PC98's legacy bus like ISA) network cards support.
 o parport.patch (17/30)
   Parallel port support.
 o pci.patch (18/30)
   Small changes for PCI support.
 o pcibios.patch (19/30)
   PCI BIOS function-number changes for PCI support.
 o pcmcia.patch (20/30)
   Small change for PCMCIA (16bits) support.
 o pnp.patch (21/30)
   Small change for Legacy bus PNP support.
 o reboot.patch (22/30)
   PC-98 specific reboot method support.
 o rtc.patch (23/30)
   Support RTC for PC98, using mach-* scheme.
 o scsi.patch (24/30)
   SCSI host adapter support.
 o serial.patch (25/30)
   Serial port support for PC98.
 o setup.patch (26/30)
   Support difference of IO port/memory address, using mach-* scheme.
 o smp.patch (27/30)
   SMP support for PC98.
 o timer.patch (28/30)
   Support difference of timer, using mach-* scheme.
 o traps.patch (29/30)
   Support difference of NMI handling, using mach-* scheme.
 o video_card.patch (30/30)
   PC-98 standard text mode video card driver.

Regards,
Osamu Tomita <tomita@cinet.co.jp>

