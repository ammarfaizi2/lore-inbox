Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262845AbTCWGtW>; Sun, 23 Mar 2003 01:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbTCWGtW>; Sun, 23 Mar 2003 01:49:22 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:38016 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262845AbTCWGtV>; Sun, 23 Mar 2003 01:49:21 -0500
Date: Sun, 23 Mar 2003 15:59:28 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.5.65-ac3] Additionals for support PC-9800 (0/10) summary
Message-ID: <20030323065928.GF2851@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac3.

There is the archived patch set including updates at URL bellow.
http://downloads.sourceforge.jp/linux98/2803/linux98-2.5.65-ac3.patch.tar.bz2
Comments and test reports are wellcome.

Description:
 o console.patch (1/10)
   PC98 Standard console support (without japanese kanji character).

 o core-misc.patch (2/10)
   Small patches for PC98 support core.

 o dma.patch (3/10)
   DMA support for PC98.

 o ide.patch (4/10)
   PC98 standard IDE I/F support.

 o kanji.patch (5/10)
   japanese kanji character support for PC98 console.

 o kconfig.patch (6/10)
   Add selection for CONFIG_X86_PC9800.

 o parport.patch (7/10)
   Parallel port support.

 o pci.patch (8/10)
   Small changes for PCI support.

 o pcmcia.patch (9/10)
   Small change for PCMCIA (16bits) support.

 o scsi.patch (10/10)
   SCSI host adapter support.

Regards,
Osamu Tomita <tomita@cinet.co.jp>

