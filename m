Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbUBIX06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbUBIX0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:26:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:5053 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265465AbUBIXWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:53 -0500
Subject: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <20040209231308.GB2393@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:15 -0800
Message-Id: <10763689351999@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.1, 2004/01/30 16:31:28-08:00, greg@kroah.com

[PATCH] PCI: add back some pci.ids entries that got deleted in the last big update.


 drivers/pci/pci.ids |    8 ++++++++
 1 files changed, 8 insertions(+)


diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Mon Feb  9 14:59:48 2004
+++ b/drivers/pci/pci.ids	Mon Feb  9 14:59:48 2004
@@ -5871,6 +5871,11 @@
 		14f1 2004  Dynalink 56PMi
 	8234  RS8234 ATM SAR Controller [ServiceSAR Plus]
 14f2  MOBILITY Electronics
+	0120  EV1000 bridge
+	0121  EV1000 Parallel port
+	0122  EV1000 Serial port
+	0123  EV1000 Keyboard controller
+	0124  EV1000 Mouse controller
 14f3  BROADLOGIC
 14f4  TOKYO Electronic Industry CO Ltd
 14f5  SOPAC Ltd
@@ -6667,6 +6672,9 @@
 	1040  536EP Data Fax Modem
 		16be 1040  V.9X DSP Data Fax Modem
 	1043  PRO/Wireless LAN 2100 3B Mini PCI Adapter
+	1048  82597EX 10GbE Ethernet Controller
+		8086 a01f  PRO/10GbE LR Server Adapter
+		8086 a11f  PRO/10GbE LR Server Adapter
 	1059  82551QM Ethernet Controller
 	1130  82815 815 Chipset Host Bridge and Memory Controller Hub
 		1025 1016  Travelmate 612 TX

