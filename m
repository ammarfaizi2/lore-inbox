Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRD3SSi>; Mon, 30 Apr 2001 14:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132801AbRD3SS0>; Mon, 30 Apr 2001 14:18:26 -0400
Received: from adsl-63-203-203-138.dsl.snfc21.pacbell.net ([63.203.203.138]:18190
	"EHLO michael.channeldot.com") by vger.kernel.org with ESMTP
	id <S135263AbRD3SQ6>; Mon, 30 Apr 2001 14:16:58 -0400
Date: Mon, 30 Apr 2001 11:29:06 -0700 (PDT)
From: Michael Shiloh <mshiloh@mediabolic.com>
To: linux-kernel@vger.kernel.org
Subject: DMA support in cs5530 IDE driver? (repost)
Message-ID: <Pine.LNX.4.21.0104301124210.32533-100000@michael.channeldot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My apologies if you've seen this already. I sent this
out last week but have not seen any replies; perhaps
no one has any suggestions, but perhaps it didn't go
out properly for some reason.

---------- ................. ----------

Can anyone report success or failure with enabling DMA for
the CS5530 IDE driver? I can get my system to crash or at
least hang pretty reliably by using hdparm to turn on DMA
while reading an MPEG-2 movie from my hard disk drive.

I don't think the movie playing is the relevent part; 
rather that it is heavily using the disk and driver.

The hard disk drive is the only rotating drive on the 
system.

Hardware: GCT Allwell set top box 
CPU: National Geode 266MHz GXM  
IDE controller: CS5530 Geode companion chip
Linux: 2.4.3
Disk: IBM Deskstar, 46.1 GByte

Any comments or suggestions appreciated

Thanks,
Michael

