Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315232AbSEURVR>; Tue, 21 May 2002 13:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315233AbSEURVQ>; Tue, 21 May 2002 13:21:16 -0400
Received: from ool-182d4c76.dyn.optonline.net ([24.45.76.118]:34308 "EHLO
	physics.dyndns.org") by vger.kernel.org with ESMTP
	id <S315232AbSEURVP>; Tue, 21 May 2002 13:21:15 -0400
Date: Tue, 21 May 2002 14:20:22 -0400 (EDT)
From: "Nicholas L. D'Imperio" <dimperio@physics.dyndns.org>
To: <linux-kernel@vger.kernel.org>
Subject: Asus a7m266d stability issues
In-Reply-To: <Pine.LNX.4.44.0205211920220.1290-100000@bilmuh.ege.edu.tr>
Message-ID: <Pine.LNX.4.33.0205211413310.515-100000@physics.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting kernel panics using the A7m266d smp motherboard and kernel 
2.4.18 as soon as the system is put under load.

I've tried ext2 and ext3 filesystems.

It's rock solid when booted using uni-processor kernel.

Also, hdparm reports the drive as udma2 even though it's udma5.  
IDE performance as measured by hdparm is terribly slow even when compared 
to what it should be using udma2.

I've had the same IDE issues with a Tiger MP using the AMD760MP chipset.

I don't have a problem with ASIC during boot and MP is on version 1.1.

Does anyone else have these problems or know what is causing them.


Thanks,

Nick D'Imperio

