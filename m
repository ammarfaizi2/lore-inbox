Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315663AbSEIJU6>; Thu, 9 May 2002 05:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315664AbSEIJU6>; Thu, 9 May 2002 05:20:58 -0400
Received: from p50887560.dip.t-dialin.net ([80.136.117.96]:50849 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315663AbSEIJU5>; Thu, 9 May 2002 05:20:57 -0400
Date: Thu, 9 May 2002 03:20:55 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Two annoying problems with Linux 2.4 bk repository version
Message-ID: <Pine.LNX.4.44.0205090307150.5351-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having two annoying problems with the bk version of Linux 2.4, but I 
don't exactly know how to track them down:

 - Even though APM is enabled in the BIOS, the kernel keeps issuing
   "apm disabled" either when changing back from XFree86 to console or 
   when leaving the PC alone for ~5 mins.
 - The PC slows down over time (RAM et al is unchanged, means nobody is 
   using up our resources), so I can't even login before the timeout after
   ~4 hours.

Penguin:AMD K6-II on ALi 1541 compatible board (rev 04)
	Tekram DC-390 SCSI controller (the reason why I can't use Linux 
	2.5) (rev 10)
	3Com 3CSOHO100-TX Hurricane 100Mbps-NIC (rev 30)
	Realtek RTL-8029(AS) 10Mbps-NIC
	Creative Labs SoundBlaster Live! (rev 04)
	nVidia Vanta [NV6] GPU (rev 15)
	384 MiB SDRAM
	Maxtor 4D040H2 40 GiB harddisk drive
	Award BIOS rev 1004 Beta something (the only one which really 
	worked on this PC (hd problems), and the latest)

Regards,
							Thunder
-- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");

