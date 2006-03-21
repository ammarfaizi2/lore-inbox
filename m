Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWCUW0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWCUW0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWCUW0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:26:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43018 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750869AbWCUW0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:26:05 -0500
Date: Tue, 21 Mar 2006 23:26:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Wendy Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix the email address of Wendy Xiong
Message-ID: <20060321222604.GH3890@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a bouncing version of the email address of Wendy Xiong with a 
working one.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/serial/jsm/jsm.h        |    2 +-
 drivers/serial/jsm/jsm_driver.c |    2 +-
 drivers/serial/jsm/jsm_neo.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc6-mm2-full/drivers/serial/jsm/jsm.h.old	2006-03-21 18:45:11.000000000 +0100
+++ linux-2.6.16-rc6-mm2-full/drivers/serial/jsm/jsm.h	2006-03-21 18:45:26.000000000 +0100
@@ -20,7 +20,7 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ * Wendy Xiong   <wendyx@us.ibm.com>
  *
  ***********************************************************************/
 
--- linux-2.6.16-rc6-mm2-full/drivers/serial/jsm/jsm_driver.c.old	2006-03-21 18:45:36.000000000 +0100
+++ linux-2.6.16-rc6-mm2-full/drivers/serial/jsm/jsm_driver.c	2006-03-21 18:45:47.000000000 +0100
@@ -20,7 +20,7 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ * Wendy Xiong   <wendyx@us.ibm.com>
  *
  *
  ***********************************************************************/
--- linux-2.6.16-rc6-mm2-full/drivers/serial/jsm/jsm_neo.c.old	2006-03-21 18:45:56.000000000 +0100
+++ linux-2.6.16-rc6-mm2-full/drivers/serial/jsm/jsm_neo.c	2006-03-21 18:46:09.000000000 +0100
@@ -20,7 +20,7 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ * Wendy Xiong   <wendyx@us.ibm.com>
  *
  ***********************************************************************/
 #include <linux/delay.h>	/* For udelay */

