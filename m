Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbRE2GcR>; Tue, 29 May 2001 02:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbRE2Gb5>; Tue, 29 May 2001 02:31:57 -0400
Received: from kathy-geddis.astound.net ([24.219.123.215]:4868 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263225AbRE2Gbu>; Tue, 29 May 2001 02:31:50 -0400
Date: Mon, 28 May 2001 23:32:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Part II of Lameness...
Message-ID: <Pine.LNX.4.10.10105282325560.889-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


athy:/src/DiskPerf-1.0.4 # ./DiskPerf /dev/hda
Device: IBM-DTLA-307075 Serial Number: YSDYSFA5874
LBA 0 DMA Read Test                      = 45.73 MB/Sec (5.47 Seconds)
Outer Diameter Sequential DMA Read Test  = 35.85 MB/Sec (6.97 Seconds)
Inner Diameter Sequential DMA Read Test  = 17.62 MB/Sec (14.19 Seconds)

Sorry I do not have the other boxes configured with a kernel to accept
this test callout.

However I do have systems that rip at 63 MB/Sec and if you adjust for
CR3's between kernel to user-space it comes out to about 93 MB/Sec.

There is nothing LAME or LACKING about that performance!

Regards,

Andre Hedrick
Linux ATA Development


