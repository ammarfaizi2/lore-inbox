Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWHZAGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWHZAGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422955AbWHZAEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:04:14 -0400
Received: from mga07.intel.com ([143.182.124.22]:60976 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1422940AbWHZADM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:03:12 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="scan'208"; a="107791872:sNHT18749143"
Message-Id: <20060826000304.734423000@linux.intel.com>
References: <20060826000227.818796000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 25 Aug 2006 17:02:37 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valerie Henson <val_henson@linux.intel.com>, Jeff Garzik <jeff@garzik.org>
Subject: [patch 10/10] [TULIP] Update winbond840.c version
Content-Disposition: inline; filename=tulip-rev-winbond-version
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Cc: Jeff Garzik <jeff@garzik.org>

---
 drivers/net/tulip/winbond-840.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/winbond-840.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/winbond-840.c
@@ -45,8 +45,8 @@
 */
 
 #define DRV_NAME	"winbond-840"
-#define DRV_VERSION	"1.01-d"
-#define DRV_RELDATE	"Nov-17-2001"
+#define DRV_VERSION	"1.01-e"
+#define DRV_RELDATE	"Aug-23-2006"
 
 
 /* Automatically extracted configuration info:

--
