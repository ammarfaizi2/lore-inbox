Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVKJMts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVKJMts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVKJMts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:49:48 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:13733 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750825AbVKJMt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:49:26 -0500
Date: Thu, 10 Nov 2005 13:51:42 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 7/7] s390: mail address changed
Message-ID: <20051110125142.GG7936@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/7] s390: mail address changed 

From: Frank Pavlic <fpavlic@de.ibm.com>
	- mail address changed to fpavlic@de.ibm.com
	
Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 lcs.c       |    4 ++--
 qeth_main.c |    4 ++--
 qeth_mpc.c  |    2 +-
 qeth_mpc.h  |    2 +-
 qeth_sys.c  |    2 +-
 qeth_tso.h  |    2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff -Naupr orig/drivers/s390/net/lcs.c linux-patched/drivers/s390/net/lcs.c
--- orig/drivers/s390/net/lcs.c	2005-11-10 13:11:18.000000000 +0100
+++ linux-patched/drivers/s390/net/lcs.c	2005-11-10 13:07:11.000000000 +0100
@@ -8,7 +8,7 @@
  *    Author(s): Original Code written by
  *			  DJ Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
  *		 Rewritten by
- *			  Frank Pavlic (pavlic@de.ibm.com) and
+ *			  Frank Pavlic (fpavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
  *    $Revision: 1.99 $	 $Date: 2005/05/11 08:10:17 $
@@ -2342,6 +2342,6 @@ __exit lcs_cleanup_module(void)
 module_init(lcs_init_module);
 module_exit(lcs_cleanup_module);
 
-MODULE_AUTHOR("Frank Pavlic <pavlic@de.ibm.com>");
+MODULE_AUTHOR("Frank Pavlic <fpavlic@de.ibm.com>");
 MODULE_LICENSE("GPL");
 
diff -Naupr orig/drivers/s390/net/qeth_main.c linux-patched/drivers/s390/net/qeth_main.c
--- orig/drivers/s390/net/qeth_main.c	2005-11-10 13:13:21.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_main.c	2005-11-10 13:07:56.000000000 +0100
@@ -9,7 +9,7 @@
  *    Author(s): Original Code written by
  *			  Utz Bacher (utz.bacher@de.ibm.com)
  *		 Rewritten by
- *			  Frank Pavlic (pavlic@de.ibm.com) and
+ *			  Frank Pavlic (fpavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
  *    $Revision: 1.242 $	 $Date: 2005/05/04 20:19:18 $
@@ -8715,7 +8715,7 @@ EXPORT_SYMBOL(qeth_osn_deregister);
 EXPORT_SYMBOL(qeth_osn_assist);
 module_init(qeth_init);
 module_exit(qeth_exit);
-MODULE_AUTHOR("Frank Pavlic <pavlic@de.ibm.com>");
+MODULE_AUTHOR("Frank Pavlic <fpavlic@de.ibm.com>");
 MODULE_DESCRIPTION("Linux on zSeries OSA Express and HiperSockets support\n" \
 		                      "Copyright 2000,2003 IBM Corporation\n");
 
diff -Naupr orig/drivers/s390/net/qeth_mpc.c linux-patched/drivers/s390/net/qeth_mpc.c
--- orig/drivers/s390/net/qeth_mpc.c	2005-11-10 13:11:18.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_mpc.c	2005-11-10 13:08:05.000000000 +0100
@@ -4,7 +4,7 @@
  * Linux on zSeries OSA Express and HiperSockets support
  *
  * Copyright 2000,2003 IBM Corporation
- * Author(s): Frank Pavlic <pavlic@de.ibm.com>
+ * Author(s): Frank Pavlic <fpavlic@de.ibm.com>
  * 	      Thomas Spatzier <tspat@de.ibm.com>
  *
  */
diff -Naupr orig/drivers/s390/net/qeth_mpc.h linux-patched/drivers/s390/net/qeth_mpc.h
--- orig/drivers/s390/net/qeth_mpc.h	2005-11-10 13:13:21.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_mpc.h	2005-11-10 13:08:19.000000000 +0100
@@ -6,7 +6,7 @@
  * Copyright 2000,2003 IBM Corporation
  * Author(s): Utz Bacher <utz.bacher@de.ibm.com>
  *            Thomas Spatzier <tspat@de.ibm.com>
- *            Frank Pavlic <pavlic@de.ibm.com>
+ *            Frank Pavlic <fpavlic@de.ibm.com>
  *
  */
 #ifndef __QETH_MPC_H__
diff -Naupr orig/drivers/s390/net/qeth_sys.c linux-patched/drivers/s390/net/qeth_sys.c
--- orig/drivers/s390/net/qeth_sys.c	2005-11-10 13:12:52.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_sys.c	2005-11-10 13:08:30.000000000 +0100
@@ -8,7 +8,7 @@
  * Copyright 2000,2003 IBM Corporation
  *
  * Author(s): Thomas Spatzier <tspat@de.ibm.com>
- * 	      Frank Pavlic <pavlic@de.ibm.com>
+ * 	      Frank Pavlic <fpavlic@de.ibm.com>
  *
  */
 #include <linux/list.h>
diff -Naupr orig/drivers/s390/net/qeth_tso.h linux-patched/drivers/s390/net/qeth_tso.h
--- orig/drivers/s390/net/qeth_tso.h	2005-11-10 13:11:18.000000000 +0100
+++ linux-patched/drivers/s390/net/qeth_tso.h	2005-11-10 13:08:43.000000000 +0100
@@ -5,7 +5,7 @@
  *
  * Copyright 2004 IBM Corporation
  *
- *    Author(s): Frank Pavlic <pavlic@de.ibm.com>
+ *    Author(s): Frank Pavlic <fpavlic@de.ibm.com>
  *
  *    $Revision: 1.7 $	 $Date: 2005/05/04 20:19:18 $
  *
