Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262768AbTCUCSm>; Thu, 20 Mar 2003 21:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262844AbTCUCSm>; Thu, 20 Mar 2003 21:18:42 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:50304 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262768AbTCUCSl>; Thu, 20 Mar 2003 21:18:41 -0500
Date: Fri, 21 Mar 2003 11:28:50 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.5.65-ac1] Support PC-9800 subarchitecture (0/14) summary
Message-ID: <20030321022850.GA1767@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patchset to support NEC PC-9800 subarchitecture
against 2.5.65-ac1.

There is archived patchset at URL bellow.
http://downloads.sourceforge.jp/linux98/2768/linux98-2.5.65-ac1.patch.tar.bz2
Comments and test reports are wellcome.

Description:
 o boot98-update.patch (1/14)
   Update arch/i386/Makefile and arch/i386/boot98/*.
 o console.patch (2/14)
   PC98 Standard console support (without japanese kanji character).
 o core-misc.patch (3/14)
   Small patches for PC98 support core.
 o dma.patch (4/14)
   DMA support for PC98.
 o floppy98-update.patch (5/14)
   Update PC98 standard floppy driver.
 o ide.patch (6/14)
   PC98 standard IDE I/F support.
 o kanji.patch (7/14)
   japanese kanji character support for PC98 console.
 o kconfig.patch (8/14)
   Add selection for CONFIG_X86_PC9800.
 o network_card.patch (9/14)
   C-bus(PC98's legacy bus like ISA) network cards support.
 o parport.patch (10/14)
   Parallel port support.
 o pci.patch (11/14)
   Small changes for PCI support.
 o pcmcia.patch (12/14)
   Small change for PCMCIA (16bits) support.
 o scsi.patch (13/14)
   SCSI host adapter support.
 o video_card-update.patch (14/14)
   Add missing files for PC98 Standard text mode video driver.

Thanks,
Osamu Tomita <tomita@cinet.co.jp>

