Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161304AbWALV2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbWALV2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161299AbWALV2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:28:48 -0500
Received: from mail0.lsil.com ([147.145.40.20]:53665 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1161220AbWALV2r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:28:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] - pci_ids - adding pci device id support for FC949ES
Date: Thu, 12 Jan 2006 14:28:45 -0700
Message-ID: <F331B95B72AFFB4B87467BE1C8E9CF5F1AA29A@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] - pci_ids - adding pci device id support for FC949ES
Thread-Index: AcYXvyr9+Gva1DjyTMiB34KvaVsVpQ==
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 12 Jan 2006 21:28:45.0909 (UTC) FILETIME=[2B49D850:01C617BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for new LSI Logic Fibre Channel controller.

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>

--- b/include/linux/pci_ids.h	2006-01-11 19:04:18.000000000 -0700
+++ a/include/linux/pci_ids.h	2006-01-12 14:19:43.000000000 -0700
@@ -181,6 +181,7 @@
 #define PCI_DEVICE_ID_LSI_FC929X	0x0626
 #define PCI_DEVICE_ID_LSI_FC939X	0x0642
 #define PCI_DEVICE_ID_LSI_FC949X	0x0640
+#define PCI_DEVICE_ID_LSI_FC949ES	0x0646
 #define PCI_DEVICE_ID_LSI_FC919X	0x0628
 #define PCI_DEVICE_ID_NCR_YELLOWFIN	0x0701
 #define PCI_DEVICE_ID_LSI_61C102	0x0901
