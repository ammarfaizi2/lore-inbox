Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277942AbRKSLMi>; Mon, 19 Nov 2001 06:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278078AbRKSLM2>; Mon, 19 Nov 2001 06:12:28 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:12214 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S277942AbRKSLMW>; Mon, 19 Nov 2001 06:12:22 -0500
Date: Mon, 19 Nov 2001 13:12:20 +0100
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] 2 non-code typo's i've encountered
Message-ID: <20011119131219.A6633@Zenith.starcenter>
Mail-Followup-To: Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.15-pre6
X-Telephone: +32 486 460306
X-Requested: Beautiful, smart and Linux-lovin' girlfriend
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just saw 2 typo's. Patch beneith...

diff -urN linux/drivers/net/wan/sdla_ppp.c linux-new/drivers/net/wan/sdla_ppp.c
--- linux/drivers/net/wan/sdla_ppp.c	Mon Nov 19 12:49:32 2001
+++ linux-new/drivers/net/wan/sdla_ppp.c	Mon Nov 19 12:59:07 2001
@@ -2473,7 +2473,7 @@
 #endif
 
 		default:
-			printk(KERN_INFO "%s: ERROR: Unsuported PPP Mode Selected\n",
+			printk(KERN_INFO "%s: ERROR: Unsupported PPP Mode Selected\n",
 					card->devname);
 			printk(KERN_INFO "%s:        PPP IP Modes: STATIC, PEER or HOST\n",
 					card->devname);	
diff -urN linux/fs/hpfs/super.c linux-new/fs/hpfs/super.c
--- linux/fs/hpfs/super.c	Mon Nov 19 12:23:04 2001
+++ linux-new/fs/hpfs/super.c	Mon Nov 19 12:58:39 2001
@@ -3,7 +3,7 @@
  *
  *  Mikulas Patocka (mikulas@artax.karlin.mff.cuni.cz), 1998-1999
  *
- *  mouning, unmounting, error handling
+ *  mounting, unmounting, error handling
  */
 
 #include <linux/string.h>


-- 
The memory management on the PowerPC can be used to frighten small
children. (Linus Torvalds.)

