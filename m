Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263783AbTCUSrr>; Fri, 21 Mar 2003 13:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263788AbTCUSqt>; Fri, 21 Mar 2003 13:46:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21124
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263783AbTCUSqE>; Fri, 21 Mar 2003 13:46:04 -0500
Date: Fri, 21 Mar 2003 20:01:19 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212001.h2LK1JWe026192@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update compaq idents, correct and update intel idents
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/linux/pci_ids.h linux-2.5.65-ac2/include/linux/pci_ids.h
--- linux-2.5.65/include/linux/pci_ids.h	2003-03-18 16:46:52.000000000 +0000
+++ linux-2.5.65-ac2/include/linux/pci_ids.h	2003-03-21 00:05:00.000000000 +0000
@@ -144,6 +144,7 @@
 #define PCI_DEVICE_ID_COMPAQ_NETEL100I	0xb011
 #define PCI_DEVICE_ID_COMPAQ_CISS	0xb060
 #define PCI_DEVICE_ID_COMPAQ_CISSB	0xb178
+#define PCI_DEVICE_ID_COMPAQ_CISSC	0x46
 #define PCI_DEVICE_ID_COMPAQ_THUNDER	0xf130
 #define PCI_DEVICE_ID_COMPAQ_NETFLEX3B	0xf150
 
@@ -1832,8 +1833,8 @@
 #define PCI_DEVICE_ID_INTEL_82801E_0	0x2450
 #define PCI_DEVICE_ID_INTEL_82801E_2	0x2452
 #define PCI_DEVICE_ID_INTEL_82801E_3	0x2453
-#define PCI_DEVICE_ID_INTEL_82801E_9	0x245b
-#define PCI_DEVICE_ID_INTEL_82801E_11	PCI_DEVICE_ID_INTEL_82801E_9
+#define PCI_DEVICE_ID_INTEL_82801E_9	0x2459
+#define PCI_DEVICE_ID_INTEL_82801E_11	0x245b
 #define PCI_DEVICE_ID_INTEL_82801E_13	0x245d
 #define PCI_DEVICE_ID_INTEL_82801E_14	0x245e
 #define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
@@ -1853,10 +1854,20 @@
 #define PCI_DEVICE_ID_INTEL_82801DB_5	0x24c5
 #define PCI_DEVICE_ID_INTEL_82801DB_6	0x24c6
 #define PCI_DEVICE_ID_INTEL_82801DB_7	0x24c7
-#define PCI_DEVICE_ID_INTEL_82801DB_9	0x24cb
-#define PCI_DEVICE_ID_INTEL_82801DB_11	PCI_DEVICE_ID_INTEL_82801DB_9
+#define PCI_DEVICE_ID_INTEL_82801DB_9	0x24c9
+#define PCI_DEVICE_ID_INTEL_82801DB_10	0x24ca
+#define PCI_DEVICE_ID_INTEL_82801DB_11	0x24cb
 #define PCI_DEVICE_ID_INTEL_82801DB_12  0x24cc
 #define PCI_DEVICE_ID_INTEL_82801DB_13	0x24cd
+#define PCI_DEVICE_ID_INTEL_82801EB_0	0x24d0
+#define PCI_DEVICE_ID_INTEL_82801EB_2	0x24d2
+#define PCI_DEVICE_ID_INTEL_82801EB_3	0x24d3
+#define PCI_DEVICE_ID_INTEL_82801EB_4	0x24d4
+#define PCI_DEVICE_ID_INTEL_82801EB_5	0x24d5
+#define PCI_DEVICE_ID_INTEL_82801EB_6	0x24d6
+#define PCI_DEVICE_ID_INTEL_82801EB_7	0x24d7
+#define PCI_DEVICE_ID_INTEL_82801EB_11	0x24db
+#define PCI_DEVICE_ID_INTEL_82801EB_13	0x24dd
 #define PCI_DEVICE_ID_INTEL_82820_HB	0x2500
 #define PCI_DEVICE_ID_INTEL_82820_UP_HB	0x2501
 #define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
