Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWHQHzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWHQHzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWHQHzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:55:25 -0400
Received: from msr16.hinet.net ([168.95.4.116]:51199 "EHLO msr16.hinet.net")
	by vger.kernel.org with ESMTP id S932229AbWHQHzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:55:24 -0400
Subject: [PATCH 1/7] ip1000: update maintainer information
From: Jesse Huang <jesse@icplus.com.tw>
To: romieu@fr.zoreil.com, penberg@cs.Helsinki.FI, akpm@osdl.org,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:42:23 -0400
Message-Id: <1155843743.5006.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

update maintainer information

Change Logs:
    update maintainer information

---

 drivers/net/ipg.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

11745492c8580b2e40764e7fcd6a7a35f28c7635
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index 754ddb5..67bf552 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -1,18 +1,26 @@
-/*PCI_DEVICE_ID_IP1000
+/*
+ * ipg.c: Device Driver for the IP1000 Gigabit Ethernet Adapter
+ *
+ * Copyright (C) 2003, 2006  IC Plus Corp.
+ *
+ * Original Author:
  *
- * ipg.c
+ *   Craig Rich
+ *   Sundance Technology, Inc.
+ *   1485 Saratoga Avenue
+ *   Suite 200
+ *   San Jose, CA 95129
+ *   408 873 4117
+ *   www.sundanceti.com
+ *   craig_rich@sundanceti.com
  *
- * IC Plus IP1000 Gigabit Ethernet Adapter Linux Driver v2.01
- * by IC Plus Corp. 2003
+ * Current Maintainer:
  *
- * Craig Rich
- * Sundance Technology, Inc.
- * 1485 Saratoga Avenue
- * Suite 200
- * San Jose, CA 95129
- * 408 873 4117
- * www.sundanceti.com
- * craig_rich@sundanceti.com
+ *   Sorbica Shieh.
+ *   10F, No.47, Lane 2, Kwang-Fu RD.
+ *   Sec. 2, Hsin-Chu, Taiwan, R.O.C.
+ *   http://www.icplus.com.tw
+ *   sorbica@icplus.com.tw
  */
 #include <linux/crc32.h>
 #include <linux/ethtool.h>
-- 
1.3.2



