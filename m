Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUGJP0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUGJP0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266297AbUGJP0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:26:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54014 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266295AbUGJPZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:25:57 -0400
Date: Sat, 10 Jul 2004 17:25:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] update contact address for SCSI megaraid.c
Message-ID: <20040710152551.GL28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you send an email to linux-megaraid-devel@dell.com, you get an 
automated response to send the mail to linux-scsi@vger.kernel.org 
instead.

The patch below updates megaraid.c accordingly.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full/drivers/scsi/megaraid.c.old	2004-07-10 16:25:33.000000000 +0200
+++ linux-2.6.7-mm7-full/drivers/scsi/megaraid.c	2004-07-10 17:16:51.000000000 +0200
@@ -25,11 +25,8 @@
  *					518, 520, 531, 532
  *
  * This driver is supported by LSI Logic, with assistance from Red Hat, Dell,
- * and others. Please send updates to the public mailing list
- * linux-megaraid-devel@dell.com, and subscribe to and read archives of this
- * list at http://lists.us.dell.com/.
- *
- * For history of changes, see ChangeLog.megaraid.
+ * and others. Please send updates to the mailing list
+ * linux-scsi@vger.kernel.org .
  *
  */
 

