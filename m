Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131499AbRCNU7I>; Wed, 14 Mar 2001 15:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131537AbRCNU6s>; Wed, 14 Mar 2001 15:58:48 -0500
Received: from www.thebucket.org ([216.63.180.35]:14607 "EHLO www")
	by vger.kernel.org with ESMTP id <S131499AbRCNU6m>;
	Wed, 14 Mar 2001 15:58:42 -0500
Date: Wed, 14 Mar 2001 15:33:32 -0600 (CST)
From: Bart Dorsey <echo@thebucket.org>
To: linux-kernel@vger.kernel.org
Subject: Problem with abyss driver in 2.4.2 and newer kernels
Message-ID: <Pine.LNX.4.21.0103141530270.7329-100000@www>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The abyss driver will not load on 2.4.2 or 2.4.3-pre4, or 2.4.2-ac20,
however it works fine in 2.4.1

Mar 14 13:48:40 jdorse01 kernel: tms380tr.c: v1.08 14/01/2001 by Christoph
Goos, Adam Fritzler
Mar 14 13:48:40 jdorse01 kernel: abyss.c: v1.02 23/11/2000 by Adam
Fritzler
Mar 14 13:48:40 jdorse01 kernel: PCI: Found IRQ 7 for device 01:09.0
Mar 14 13:48:40 jdorse01 kernel: tr0: Madge Smart 16/4 PCI Mk2 (Abyss)
Mar 14 13:48:40 jdorse01 kernel: tr0:    IO: 0xec00  IRQ: 7
Mar 14 13:48:40 jdorse01 kernel: tr0: Memory not accessible for DMA
Mar 14 13:48:40 jdorse01 kernel: tr0: unable to get memory for dev->priv.


