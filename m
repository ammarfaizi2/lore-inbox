Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264182AbTCXMu1>; Mon, 24 Mar 2003 07:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264184AbTCXMu1>; Mon, 24 Mar 2003 07:50:27 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:12416 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S264182AbTCXMuZ>; Mon, 24 Mar 2003 07:50:25 -0500
Date: Mon, 24 Mar 2003 22:00:25 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.5.65-ac4] Complete support for PC-9800 sub-arch (0/9) summary
Message-ID: <20030324130025.GA2465@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patchset to support NEC PC-9800 subarchitecture
against 2.5.65-ac4.

I'm doing cleanup these patches. If there is better way please tell me.
Comments and test reports are wellcome.

Description:
 o console.patch (1/9)
   PC98 Standard console support (without japanese kanji character).

 o core-misc.patch (2/9)
   Small patches for PC98 support core.

 o dma.patch (3/9)
   DMA support for PC98.

 o ide.patch (4/9)
   PC98 standard IDE I/F support.

 o kanji.patch (5/9)
   japanese kanji character support for PC98 console.

 o kconfig.patch (6/9)
   Add selection for CONFIG_X86_PC9800.

 o pci.patch (7/9)
   Small changes for PCI support.

 o pcmcia.patch (8/9)
   Small change for PCMCIA (16bits) support.

 o scsi.patch (9/9)
   SCSI host adapter support.

Regards,
Osamu Tomita <tomita@cinet.co.jp>

