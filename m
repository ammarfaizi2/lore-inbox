Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTEBPTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTEBPTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:19:15 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:39979 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262942AbTEBPTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:19:13 -0400
Subject: [PATCH] include/linux/pci_ids.h
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051889501.1718.2.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 02 May 2003 10:31:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added new PCI ID macro.
Please apply.

--- linux-2.5.68/include/linux/pci_ids.h	2003-04-21 09:14:02.000000000 -0500
+++ linux-2.5.68-mg/include/linux/pci_ids.h	2003-05-01 15:42:38.000000000 -0500
@@ -2025,6 +2025,7 @@
 #define PCI_DEVICE_ID_MICROGATE_USC	0x0010
 #define PCI_DEVICE_ID_MICROGATE_SCC	0x0020
 #define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
+#define PCI_DEVICE_ID_MICROGATE_USC2	0x0210
 
 #define PCI_VENDOR_ID_HINT		0x3388
 #define PCI_DEVICE_ID_HINT_VXPROII_IDE	0x8013


-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


