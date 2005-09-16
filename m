Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbVIPReS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbVIPReS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbVIPReR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:34:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38618 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030602AbVIPReQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:34:16 -0400
Date: Fri, 16 Sep 2005 19:34:17 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cleanup whitespace in pci_ids.h
Message-ID: <20050916173417.GB25036@pingi3.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 include/linux/pci_ids.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e7e498d57e45fd8e43625fd9c7fb2848ef7194c0
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2254,7 +2254,7 @@
 
 #define PCI_VENDOR_ID_SITECOM		0x182d
 #define PCI_DEVICE_ID_SITECOM_DC105V2	0x3069
-        
+
 #define PCI_VENDOR_ID_TOPSPIN		0x1867
 
 #define PCI_VENDOR_ID_TDI               0x192E

-- 
Karsten Keil
SuSE Labs
ISDN development
