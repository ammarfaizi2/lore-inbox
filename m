Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319092AbSIJJXU>; Tue, 10 Sep 2002 05:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319080AbSIJJWU>; Tue, 10 Sep 2002 05:22:20 -0400
Received: from dp.samba.org ([66.70.73.150]:43483 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319087AbSIJJWC>;
	Tue, 10 Sep 2002 05:22:02 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] typo: include_linux_pci_ids.h s_DEVIDE_DEVICE
Date: Tue, 10 Sep 2002 19:15:21 +1000
Message-Id: <20020910092648.B1EC02C382@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Looks right to me ... --RR ]
From:  Bernhard Fischer <berny.f@aon.at>


--- trivial-2.5.34/include/linux/pci_ids.h.orig	2002-09-10 19:10:41.000000000 +1000
+++ trivial-2.5.34/include/linux/pci_ids.h	2002-09-10 19:10:41.000000000 +1000
@@ -370,7 +370,7 @@
 #define PCI_DEVICE_ID_AMD_FE_GATE_7006	0x7006
 #define PCI_DEVICE_ID_AMD_FE_GATE_7007	0x7007
 #define PCI_DEVICE_ID_AMD_FE_GATE_700C	0x700C
-#define PCI_DEVIDE_ID_AMD_FE_GATE_700D	0x700D
+#define PCI_DEVICE_ID_AMD_FE_GATE_700D	0x700D
 #define PCI_DEVICE_ID_AMD_FE_GATE_700E	0x700E
 #define PCI_DEVICE_ID_AMD_FE_GATE_700F	0x700F
 #define PCI_DEVICE_ID_AMD_COBRA_7400	0x7400
-- 
  Don't blame me: the Monkey is driving
  File: Bernhard Fischer <berny.f@aon.at>: [TRIVIAL] typo: include_linux_pci_ids.h s_DEVIDE_DEVICE
