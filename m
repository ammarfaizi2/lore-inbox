Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbTBOTOe>; Sat, 15 Feb 2003 14:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTBOTOd>; Sat, 15 Feb 2003 14:14:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55056 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264944AbTBOTNo>; Sat, 15 Feb 2003 14:13:44 -0500
Subject: PATCH: itanic people cant spell either
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:23:57 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7un-0007IW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/ia64/sn/io/io.c linux-2.5.61-ac1/arch/ia64/sn/io/io.c
--- linux-2.5.61/arch/ia64/sn/io/io.c	2003-02-10 18:38:29.000000000 +0000
+++ linux-2.5.61-ac1/arch/ia64/sn/io/io.c	2003-02-14 23:08:57.000000000 +0000
@@ -631,7 +631,7 @@
 }
 
 /*
- * Check that an address is in teh real small window widget 0 space
+ * Check that an address is in the real small window widget 0 space
  * or else in the big window we're using to emulate small window 0
  * in the kernel.
  */
@@ -708,7 +708,7 @@
 /*
  * hub_setup_prb(nasid, prbnum, credits, conveyor)
  *
- * 	Put a PRB into fire-and-forget mode if conveyor isn't set.  Otehrwise,
+ * 	Put a PRB into fire-and-forget mode if conveyor isn't set.  Otherwise,
  * 	put it into conveyor belt mode with the specified number of credits.
  */
 void

