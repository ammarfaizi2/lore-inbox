Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbSKOKl2>; Fri, 15 Nov 2002 05:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbSKOKl2>; Fri, 15 Nov 2002 05:41:28 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:11906 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266041AbSKOKl1>; Fri, 15 Nov 2002 05:41:27 -0500
Message-ID: <3DD4D0EA.C44F5ED7@cinet.co.jp>
Date: Fri, 15 Nov 2002 19:48:10 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.47-ac4-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PC-9800 patch for 2.5.47-ac4 pci_ids.h typo fix
References: <3DD4C5A7.84AB38B6@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------75845339CFBCBFE83F581546"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------75845339CFBCBFE83F581546
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

Fix typo in pci_ids.h, already in 2.5.47-ac4.

diffstat:
 include/linux/pci_ids.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

-- 
Osamu Tomita
tomita@cinet.co.jp
--------------75845339CFBCBFE83F581546
Content-Type: text/plain; charset=iso-2022-jp;
 name="pci_ids_h-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_ids_h-typo.patch"

--- linux/include/linux/pci_ids.h	Fri Nov 15 12:10:13 2002
+++ linux98/include/linux/pci_ids.h	Fri Nov 15 12:28:04 2002
@@ -468,7 +468,7 @@
 #define PCI_DEVICE_ID_NEC_486		0x0005 /* 486 Like Peripheral Bus Bridge */
 #define PCI_DEVICE_ID_NEC_ACCEL_1	0x0006 /* Graphic Accelerator */
 #define PCI_DEVICE_ID_NEC_UXBUS		0x0007 /* UX-Bus Bridge */
-#define PCI_DEVICE_ID_NEC_ACCEL_2	0x0006 /* Graphic Accelerator */
+#define PCI_DEVICE_ID_NEC_ACCEL_2	0x0008 /* Graphic Accelerator */
 #define PCI_DEVICE_ID_NEC_GRAPH		0x0009 /* PCI-CoreGraph Bridge */
 #define PCI_DEVICE_ID_NEC_VL		0x0016 /* PCI-VL Bridge */
 #define PCI_DEVICE_ID_NEC_STARALPHA2	0x002c /* STAR ALPHA2 */

--------------75845339CFBCBFE83F581546--

