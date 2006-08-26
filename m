Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422942AbWHZAFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422942AbWHZAFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422936AbWHZAEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:04:20 -0400
Received: from mga06.intel.com ([134.134.136.21]:59488 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422932AbWHZADH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:03:07 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="scan'208"; a="115152417:sNHT19815299"
Message-Id: <20060826000304.507563000@linux.intel.com>
References: <20060826000227.818796000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 25 Aug 2006 17:02:36 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valerie Henson <val_henson@linux.intel.com>, Jeff Garzik <jeff@garzik.org>
Subject: [patch 09/10] [TULIP] Update tulip version
Content-Disposition: inline; filename=tulip-rev-tulip-version
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Cc: Jeff Garzik <jeff@garzik.org>

---
 drivers/net/tulip/tulip_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/tulip_core.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/tulip_core.c
@@ -17,11 +17,11 @@
 
 #define DRV_NAME	"tulip"
 #ifdef CONFIG_TULIP_NAPI
-#define DRV_VERSION    "1.1.14-NAPI" /* Keep at least for test */
+#define DRV_VERSION    "1.1.15-NAPI" /* Keep at least for test */
 #else
-#define DRV_VERSION	"1.1.14"
+#define DRV_VERSION	"1.1.15"
 #endif
-#define DRV_RELDATE	"May 6, 2006"
+#define DRV_RELDATE	"Aug 23, 2006"
 
 
 #include <linux/module.h>

--
