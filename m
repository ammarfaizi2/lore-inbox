Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313084AbSEAPK4>; Wed, 1 May 2002 11:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313115AbSEAPKz>; Wed, 1 May 2002 11:10:55 -0400
Received: from lightning.nolink.net ([195.139.204.148]:25865 "HELO
	lightning.nolink.net") by vger.kernel.org with SMTP
	id <S313084AbSEAPKz>; Wed, 1 May 2002 11:10:55 -0400
Date: Wed, 1 May 2002 17:10:53 +0200 (CEST)
From: Marius Flage <marius@flage.nu>
X-X-Sender: marius@lightning.nolink.net
To: linux-kernel@vger.kernel.org
Subject: aiee, killing interrupt handler
Message-ID: <Pine.BSF.4.43.0205011654380.49671-100000@lightning.nolink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

I've been getting this error when I try installing Slackware8.0.

I'm using the bare.i-bootdisk and the color.gz-rootdisk

code: 89 37 83 c7 04 89 d0 25 ff ff 00 00 89 07 83 c7 04 01 d6 29
aiee, killing interrupt handler
kernel panic: attempted to kill the idle task!
in swapper task - not syncing

This is an AT&T Globalyst 730, class 3358:

Dual Intel Pentium 133MHz (HC only uses one CPU)
AUGUSTA Motherboard with VLSI 590 Chip Set
256KB, PB-SRAM L2 Cache
24MB RAM
Integrated S3 Vision968, 4MB VRAM, True Color (32-bit), 1024 by 768,
100Hz Refresh Frequency
Integrated 16 bit stereo (Ensoniq Sound Scape 688)
Integrated AMD PCSCSI Fast SCSI-2 controller

I've tried disabling SCSI, COM and LPT in bios, but it still won't work.
Can you please help me out here?

This very same computer has been running RH6.2 for a period of time, so it
should be enough to run Linux.

Marius

