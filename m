Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWAFQe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWAFQe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbWAFQdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:33:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55563 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752477AbWAFQdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:33:21 -0500
Date: Fri, 6 Jan 2006 17:33:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] spelling: s/assoicated/associated/
Message-ID: <20060106163316.GM12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/common/amba.c   |    2 +-
 include/linux/elevator.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-mm1-full/arch/arm/common/amba.c.old	2006-01-06 16:58:14.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/arm/common/amba.c	2006-01-06 16:58:25.000000000 +0100
@@ -340,7 +340,7 @@
 }
 
 /**
- *	amba_release_regions - release mem regions assoicated with device
+ *	amba_release_regions - release mem regions associated with device
  *	@dev: amba_device structure for device
  *
  *	Release regions claimed by a successful call to amba_request_regions.
--- linux-2.6.15-mm1-full/include/linux/elevator.h.old	2006-01-06 16:58:33.000000000 +0100
+++ linux-2.6.15-mm1-full/include/linux/elevator.h	2006-01-06 16:58:40.000000000 +0100
@@ -66,7 +66,7 @@
 };
 
 /*
- * each queue has an elevator_queue assoicated with it
+ * each queue has an elevator_queue associated with it
  */
 struct elevator_queue
 {

