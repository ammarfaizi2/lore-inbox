Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVE0Ssk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVE0Ssk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVE0Ssg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:48:36 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:41734 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262519AbVE0Sr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:47:57 -0400
Date: Fri, 27 May 2005 14:47:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       mchan@broadcom.com
Subject: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
Message-ID: <20050527184750.GB11592@tuxdriver.com>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
	mchan@broadcom.com
References: <04132005193844.8410@laptop> <04132005193844.8474@laptop> <20050421165956.55bdcb14.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421165956.55bdcb14.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update pci.ids for BCM5752

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/pci/pci.ids |    1 +
 1 files changed, 1 insertion(+)

--- tg3-pci/drivers/pci/pci.ids.orig	2005-05-27 14:41:25.243607911 -0400
+++ tg3-pci/drivers/pci/pci.ids	2005-05-27 14:43:45.553326412 -0400
@@ -7173,6 +7173,7 @@
 	080f  Sentry5 DDR/SDR RAM Controller
 	0811  Sentry5 External Interface Core
 	0816  BCM3302 Sentry5 MIPS32 CPU
+	1600  NetXtreme BCM5752 Gigabit Ethernet PCI Express
 	1644  NetXtreme BCM5700 Gigabit Ethernet
 		1014 0277  Broadcom Vigil B5700 1000Base-T
 		1028 00d1  Broadcom BCM5700
-- 
John W. Linville
linville@tuxdriver.com
