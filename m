Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUH1LQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUH1LQI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 07:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUH1LQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 07:16:08 -0400
Received: from lucidpixels.com ([66.45.37.187]:38794 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S266149AbUH1LPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 07:15:51 -0400
Date: Sat, 28 Aug 2004 07:15:49 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: apiszcz@lucidpixels.com
cc: linux-kernel@vger.kernel.org
Subject: Burning audio CD's is totally broken under 2.6.8.1.
Message-ID: <Pine.LNX.4.61.0408280714550.9133@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using: cdrtools-2.01a38-pre
User: root
Memory In My Box: 2GB
Swap: 4GB


Free pages:      716208kB (712448kB HighMem)
Active:92966 inactive:21940 dirty:3 writeback:0 unstable:0 free:179052 
slab:6007
  mapped:74076 pagetables:999
DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB 
present:1638
4kB
protections[]: 8 476 732
Normal free:1856kB min:936kB low:1872kB high:2808kB active:12kB 
inactive:244kB p
resent:901120kB
protections[]: 0 468 724
HighMem free:712448kB min:512kB low:1024kB high:1536kB active:371852kB 
inactive:
87580kB present:1179584kB
protections[]: 0 0 256
DMA: 2*4kB 1*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 
0*2048kB
0*4096kB = 1904kB
Normal: 160*4kB 14*8kB 1*16kB 2*32kB 0*64kB 0*128kB 0*256kB 2*512kB 
0*1024kB 0*2
048kB 0*4096kB = 1856kB
HighMem: 5592*4kB 2490*8kB 719*16kB 1407*32kB 1240*64kB 612*128kB 
303*256kB 149*
512kB 93*1024kB 55*2048kB 23*4096kB = 712448kB
Swap cache: add 12456, delete 11114, find 1712/2078, race 0+0
Out of Memory: Killed process 737 (xchats).
Out of Memory: Killed process 739 (xchats).
Out of Memory: Killed process 740 (xchats).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16

Free pages:      797332kB (793536kB HighMem)
Active:91450 inactive:3306 dirty:0 writeback:0 unstable:0 free:199333 
slab:5949
mapped:72724 pagetables:995
DMA free:1908kB min:16kB low:32kB high:48kB active:0kB inactive:16kB 
present:163
84kB
protections[]: 8 476 732
Normal free:1888kB min:936kB low:1872kB high:2808kB active:336kB 
inactive:84kB p
resent:901120kB
protections[]: 0 468 724
HighMem free:793536kB min:512kB low:1024kB high:1536kB active:365464kB 
inactive:
13124kB present:1179584kB
protections[]: 0 0 256
DMA: 3*4kB 1*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 
0*2048kB
0*4096kB = 1908kB
Normal: 156*4kB 18*8kB 2*16kB 2*32kB 0*64kB 0*128kB 0*256kB 2*512kB 
0*1024kB 0*2
048kB 0*4096kB = 1888kB
HighMem: 5238*4kB 2595*8kB 797*16kB 1448*32kB 1258*64kB 623*128kB 
308*256kB 150*
512kB 92*1024kB 54*2048kB 42*4096kB = 793536kB
Swap cache: add 12583, delete 11169, find 1927/2319, race 0+0
Out of Memory: Killed process 716 (xchatl).
Out of Memory: Killed process 718 (xchatl).
Out of Memory: Killed process 719 (xchatl).

