Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263732AbTCUS0C>; Fri, 21 Mar 2003 13:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263722AbTCUSYy>; Fri, 21 Mar 2003 13:24:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52867
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263721AbTCUSYH>; Fri, 21 Mar 2003 13:24:07 -0500
Date: Fri, 21 Mar 2003 19:39:22 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211939.h2LJdMF9025869@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix 3c501 typo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/net/3c501.c linux-2.5.65-ac2/drivers/net/3c501.c
--- linux-2.5.65/drivers/net/3c501.c	2003-03-06 17:04:27.000000000 +0000
+++ linux-2.5.65-ac2/drivers/net/3c501.c	2003-03-06 23:14:17.000000000 +0000
@@ -955,7 +955,7 @@
  * init_module:
  *
  * When the driver is loaded as a module this function is called. We fake up
- * a device structure with the base I/O and interrupt set as if it was being
+ * a device structure with the base I/O and interrupt set as if it were being
  * called from Space.c. This minimises the extra code that would otherwise
  * be required.
  *
