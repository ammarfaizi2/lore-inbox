Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTBBShY>; Sun, 2 Feb 2003 13:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTBBShY>; Sun, 2 Feb 2003 13:37:24 -0500
Received: from pa158.zgierz.sdi.tpnet.pl ([213.77.180.158]:25221 "HELO
	ekatalog.com.pl") by vger.kernel.org with SMTP id <S265063AbTBBShX>;
	Sun, 2 Feb 2003 13:37:23 -0500
Date: Sun, 2 Feb 2003 19:46:37 +0100
From: Filip djMedrzec Zyzniewski <lkml@filip.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Hardware recommentations.
Message-ID: <20030202184637.GA3777@ekatalog.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am sick of my hardware and I'd like to change it.
Not to make bad buys, I decided to ask you for advice :).

What I need:
STABLE x86 architecture, capable of decoding DVD realtime in
software and run some 3D games like RtCW. It doesn't have to
be extremely powerful, but has to run smoothly. Without
IDE transfer locking all other stuff (via kt133a/686)

What I have now:
CPU:		duron 700 spitfire
mainboard:	sono vk2208a (via kt133a / vc82C686B)
RAM:		384MB PC133 SDRAM
sound:		SB Live!
NIC:		rtl8139C
GPU:		radeon 7500 64MB DDR
HDD:		ST340810A 40GB/5400rpm
CDRW:		Teac CD-W58E

problems:
heavy IDE transfers cause horrible system slowdowns (UDMA100 mode)
using DRI causes hard freezes (AGP x1 mode)
processes influence other ones more than on 440lx / p2 266 machine (cache?)

tried on kernels 2.4.17 to 2.2.40. DRI from CVS.


What I'd like to keep: sound, nic, gpu, hdd and cdrw.

What CPU/mobo/ram would you suggest?
Considering 2.5 kernels too (to have nice sys with 2.6.x).
I have a limited budget...

tia and bye,

Filip Zyzniewski
