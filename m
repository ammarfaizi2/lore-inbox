Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263237AbRFEFjR>; Tue, 5 Jun 2001 01:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbRFEFjH>; Tue, 5 Jun 2001 01:39:07 -0400
Received: from kathy-geddis.astound.net ([24.219.123.215]:24326 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263231AbRFEFjA>; Tue, 5 Jun 2001 01:39:00 -0400
Date: Mon, 4 Jun 2001 22:38:58 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: linux-kernel@vger.kernel.org
Subject: Speed to please all......
In-Reply-To: <memo.217821@cix.compulink.co.uk>
Message-ID: <Pine.LNX.4.10.10106042237470.18954-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


beetle:/src/DiskPerf-1.0.5 # ./DiskPerf.rw /dev/hdb
Device: Maxtor 5T020H2 Serial Number: T2J0HC0C
LBA 0 DMA Read Test                      = 68.82 MB/Sec (3.63 Seconds)
Outer Diameter Sequential DMA Read Test  = 36.68 MB/Sec (6.81 Seconds)
Inner Diameter Sequential DMA Read Test  = 21.36 MB/Sec (11.70 Seconds)
LBA 1 DMA Write Test                     = 65.57 MB/Sec (3.81 Seconds)
Outer Diameter Sequential DMA Write Test = 36.89 MB/Sec (6.78 Seconds)
Inner Diameter Sequential DMA Write Test = 21.42 MB/Sec (11.67 Seconds)

The new driver for 2.5 can read and write at near the same speeds.

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

