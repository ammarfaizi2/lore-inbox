Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317391AbSFHJko>; Sat, 8 Jun 2002 05:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSFHJkn>; Sat, 8 Jun 2002 05:40:43 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:16863 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S317391AbSFHJkn>; Sat, 8 Jun 2002 05:40:43 -0400
Date: Sat, 8 Jun 2002 11:41:53 +0200 (CEST)
From: Michael De Nil <linux@aerythmic.be>
X-X-Sender: linux@LiSa
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: /dev/input/mice problem with 2.4.19-pre9 & 10
Message-ID: <Pine.LNX.4.44.0206081137310.32319-100000@LiSa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey

I saved the old config from 2.4.18 (with make menuconfig) and loaded it
with kernel 2.4.19-pre9 and pre10. everything compiles etc, the kernel
boots, but my usb-mouse is not working any more ...

All modules were loaded and none gave any error.

When I move my mouse while catting /dev/input/mice, nothing appears ...

Other USB-device work...


michael

btw: sry for this n00b-bugreport :) plz tell me if you need any more
information

-----------------------------------------------------------------------
                Michael De Nil -- michael@aerythmic.be
       Linux LiSa 2.4.18 #9 SMP zo mei 5 13:42:48 CEST 2002 i686
  11:37:01 up 33 days, 16:57, 16 users,  load average: 0.00, 0.02, 0.08
-----------------------------------------------------------------------

