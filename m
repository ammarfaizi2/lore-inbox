Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271552AbTGQSjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271539AbTGQShq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:37:46 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:29340 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271041AbTGQSfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:35:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 17 Jul 2003 20:43:26 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] bttv documentation update
Message-ID: <20030717184326.GA22025@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the bttv documentation with the latest 
card list changes and new entries.

Please apply,

  Gerd

diff -u linux-2.6.0-test1/Documentation/video4linux/bttv/CARDLIST linux/Documentation/video4linux/bttv/CARDLIST
--- linux-2.6.0-test1/Documentation/video4linux/bttv/CARDLIST	2003-07-17 18:55:00.977444723 +0200
+++ linux/Documentation/video4linux/bttv/CARDLIST	2003-07-17 19:13:34.169364573 +0200
@@ -30,7 +30,7 @@
   card=28 - Terratec TerraTV+ Version 1.1 (bt878)
   card=29 - Imagenation PXC200
   card=30 - Lifeview FlyVideo 98 LR50
-  card=31 - Formac iProTV
+  card=31 - Formac iProTV, Formac ProTV I (bt848)
   card=32 - Intel Create and Share PCI/ Smart Video Recorder III
   card=33 - Terratec TerraTValue Version Bt878
   card=34 - Leadtek WinFast 2000/ WinFast 2000 XP
@@ -94,9 +94,16 @@
   card=92 - Osprey 2000
   card=93 - IDS Eagle
   card=94 - Pinnacle PCTV Sat
-  card=95 - Formac ProTV II
+  card=95 - Formac ProTV II (bt878)
   card=96 - MachTV
   card=97 - Euresys Picolo
+  card=98 - ProVideo PV150
+  card=99 - AD-TVK503
+  card=100 - Hercules Smart TV Stereo
+  card=101 - Pace TV & Radio Card
+  card=102 - IVC-200
+  card=103 - Grand X-Guard / Trust 814PCI
+  card=104 - Nebula Electronics DigiTV
 
 tuner.o
   type=0 - Temic PAL (4002 FH5)
@@ -139,3 +146,4 @@
   type=37 - LG PAL (newer TAPC series)
   type=38 - Philips PAL/SECAM multi (FM1216ME MK3)
   type=39 - LG NTSC (newer TAPC series)
+  type=40 - HITACHI V7-J180AT

-- 
sigfault
