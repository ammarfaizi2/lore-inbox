Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264382AbTCXRPQ>; Mon, 24 Mar 2003 12:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264289AbTCXQth>; Mon, 24 Mar 2003 11:49:37 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:52202 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264288AbTCXQbA>; Mon, 24 Mar 2003 11:31:00 -0500
Message-Id: <200303241642.h2OGgA35008328@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:58 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: various PCI ID updates.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/pci_ids.h linux-2.5/include/linux/pci_ids.h
--- bk-linus/include/linux/pci_ids.h	2003-03-22 12:36:23.000000000 +0000
+++ linux-2.5/include/linux/pci_ids.h	2003-03-22 12:41:47.000000000 +0000
@@ -397,6 +397,8 @@
 #define PCI_DEVICE_ID_IBM_MPIC		0x0046
 #define PCI_DEVICE_ID_IBM_3780IDSP	0x007d
 #define PCI_DEVICE_ID_IBM_CHUKAR	0x0096
+#define PCI_DEVICE_ID_IBM_CPC710_PCI64	0x00fc
+#define PCI_DEVICE_ID_IBM_CPC710_PCI32	0x0105
 #define	PCI_DEVICE_ID_IBM_405GP		0x0156
 #define PCI_DEVICE_ID_IBM_SERVERAIDI960	0x01bd
 #define PCI_DEVICE_ID_IBM_MPIC_2	0xffff
@@ -1248,6 +1250,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_LE	  0x0009
 #define PCI_DEVICE_ID_SERVERWORKS_CIOB30  0x0010
 #define PCI_DEVICE_ID_SERVERWORKS_CMIC_HE 0x0011
+#define PCI_DEVICE_ID_SERVERWORKS_GCNB_LE 0x0017
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4	  0x0200
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5	  0x0201
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6    0x0203
@@ -1257,6 +1260,9 @@
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2 0x0217
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4USB 0x0220
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5USB PCI_DEVICE_ID_SERVERWORKS_OSB4USB
+#define PCI_DEVICE_ID_SERVERWORKS_CSB6USB 0x0221
+#define PCI_DEVICE_ID_SERVERWORKS_GCLE    0x0225
+#define PCI_DEVICE_ID_SERVERWORKS_GCLE2   0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5ISA 0x0230
 
 #define PCI_VENDOR_ID_SBE		0x1176
@@ -1759,6 +1765,9 @@
 #define PCI_DEVICE_ID_S3_ViRGE_MXPMV	0x8c03
 #define PCI_DEVICE_ID_S3_SONICVIBES	0xca00
 
+#define PCI_VENDOR_ID_DUNORD		0x5544
+#define PCI_DEVICE_ID_DUNORD_I3000	0x0001
+
 #define PCI_VENDOR_ID_DCI		0x6666
 #define PCI_DEVICE_ID_DCI_PCCOM4	0x0001
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
