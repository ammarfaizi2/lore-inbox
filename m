Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135564AbRDSGCS>; Thu, 19 Apr 2001 02:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135566AbRDSGCI>; Thu, 19 Apr 2001 02:02:08 -0400
Received: from [64.170.109.178] ([64.170.109.178]:55253 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S135564AbRDSGBy>;
	Thu, 19 Apr 2001 02:01:54 -0400
Message-ID: <3ADE7F45.2030205@petreley.com>
Date: Wed, 18 Apr 2001 23:01:41 -0700
From: Nicholas Petreley <nicholas@petreley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac9 i686; en-US; 0.8) Gecko/20010322
X-Accept-Language: en
MIME-Version: 1.0
To: ignaciomonge@navegalia.com, linux-kernel@vger.kernel.org
Subject: Re: ATA 100 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same motherboard, and it works fine for me.  Note the 
80w cable detection.  Perhaps you've got a bad cable?

-Nick

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.23
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA      UDMA       PIO
Address Setup:       30ns      30ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns     330ns
Data Recovery:       30ns      30ns      30ns     270ns
Cycle Time:          20ns      20ns      60ns     600ns
Transfer Rate:  100.0MB/s 100.0MB/s  33.3MB/s   3.3MB/s

