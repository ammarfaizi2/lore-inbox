Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbTCaQYJ>; Mon, 31 Mar 2003 11:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbTCaQYJ>; Mon, 31 Mar 2003 11:24:09 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:29568 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261699AbTCaQYI>; Mon, 31 Mar 2003 11:24:08 -0500
Date: Tue, 1 Apr 2003 01:34:04 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.66-ac1] Rest of PC-9800 support (0/9) summary
Message-ID: <20030331163404.GC1148@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patchset to support NEC PC-9800 subarchitecture
against 2.5.66-ac1.

Comments and test reports are wellcome.
There is archived patchset for download.
http://downloads.sourceforge.jp/linux98/2932/linux98-2.5.66-ac1.patch.tar.bz2

Description:
 o arch.patch (1/9)
   Add selection for CONFIG_X86_PC9800.

 o console.patch (2/9)
   PC98 Standard console support (without japanese kanji character).

 o core-misc.patch (3/9)
   Small patches for PC98 support core.

 o dma.patch (4/9)
   DMA support for PC98.

 o ide.patch (5/9)
   PC98 standard IDE I/F support.

 o kanji.patch (6/9)
   japanese kanji character support for PC98 console.

 o pci.patch (7/9)
   Small changes for PCI support.

 o pcmcia.patch (8/9)
   Small change for PCMCIA (16bits) support.

 o scsi.patch (9/9)
   SCSI host adapter support.

Regards,
Osamu Tomita <tomita@cinet.co.jp>

