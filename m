Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVG2UkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVG2UkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVG2UiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:38:16 -0400
Received: from fmr18.intel.com ([134.134.136.17]:16536 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262781AbVG2UgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:36:23 -0400
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: mj@ucw.cz, akpm@osdl.org
Subject: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Date: Fri, 29 Jul 2005 09:24:40 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507290924.40952.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ICH7R SATA RAID DID to the pci_ids.h file.  This patch was built against the 2.6.13-rc4 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.13-rc4/include/linux/pci_ids.h.orig	2005-07-29 09:06:03.841520568 -0700
+++ linux-2.6.13-rc4/include/linux/pci_ids.h	2005-07-29 09:06:42.256680576 -0700
@@ -2454,6 +2454,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1
 #define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
 #define PCI_DEVICE_ID_INTEL_ICH7_31	0x27bd
+#define PCI_DEVICE_ID_INTEL_ICH7_4	0x27c3
 #define PCI_DEVICE_ID_INTEL_ICH7_5	0x27c4
 #define PCI_DEVICE_ID_INTEL_ICH7_6	0x27c5
 #define PCI_DEVICE_ID_INTEL_ICH7_7	0x27c8
