Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWIHSYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWIHSYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWIHSX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:23:29 -0400
Received: from mga07.intel.com ([143.182.124.22]:33075 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751140AbWIHSXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:23:22 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="113819761:sNHT2685766160"
Message-Id: <20060908182024.911086000@linux.intel.com>
References: <20060908181533.771856000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 08 Sep 2006 11:15:43 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valerie Henson <val_henson@linux.intel.com>, Jeff Garzik <jeff@garzik.org>
Subject: [patch 10/10] [TULIP] Update winbond840.c version
Content-Disposition: inline; filename=tulip-rev-winbond-version
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>

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
