Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTDGD0z (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbTDGD0y (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:26:54 -0400
Received: from chii.cinet.co.jp ([61.197.228.217]:41345 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S263225AbTDGD0x (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:26:53 -0400
Date: Mon, 7 Apr 2003 12:36:27 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.66-ac2] PC-9800 sub architecture support (0/9) summary
Message-ID: <20030407033627.GA4798@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patchset to support NEC PC-9800 subarchitecture
against 2.5.66-ac2.

Comments and test reports are wellcome.

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

