Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbVFXEWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbVFXEWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbVFXEVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:21:38 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263104AbVFXEE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:27 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 14/14] IB/mthca: Bump version
In-Reply-To: <2005623214.1yVGvzp1yi0UQ3bC@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:21 -0700
Message-Id: <2005623214.KAnnSVPywiOCFGvX@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:21.0339 (UTC) FILETIME=[CCD9CAB0:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's about time for a version bump.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_dev.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-23 13:03:09.283107924 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-23 13:03:10.111928547 -0700
@@ -47,8 +47,8 @@
 
 #define DRV_NAME	"ib_mthca"
 #define PFX		DRV_NAME ": "
-#define DRV_VERSION	"0.06-pre"
-#define DRV_RELDATE	"November 8, 2004"
+#define DRV_VERSION	"0.06"
+#define DRV_RELDATE	"June 23, 2005"
 
 enum {
 	MTHCA_FLAG_DDR_HIDDEN = 1 << 1,

