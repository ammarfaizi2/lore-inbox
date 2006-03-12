Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWCLVWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWCLVWA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWCLVV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:21:56 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:29706 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1751794AbWCLVVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:21:53 -0500
Message-Id: <20060312205304.924074000@mercator.sirena.org.uk>
References: <20060312192259.929734000@mercator.sirena.org.uk>
Date: Sun, 12 Mar 2006 19:23:02 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Tim Hockin <thockin@hockin.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 3/4] Add a PCI vendor ID definition for Aculab
Content-Disposition: inline; filename=pci-vendor-aculab.patch
X-Spam-Score: -2.4 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Add a vendor ID definition for Aculab. Signed-Off-By:
	Mark Brown <broonie@sirena.org.uk> Index:
	e1000-queue/include/linux/pci_ids.h
	=================================================================== ---
	e1000-queue.orig/include/linux/pci_ids.h 2006-02-25 12:50:12.000000000
	+0000 +++ e1000-queue/include/linux/pci_ids.h 2006-02-25
	12:51:51.000000000 +0000 @@ -1572,6 +1572,8 @@ #define
	PCI_VENDOR_ID_NVIDIA_SGS 0x12d2 #define
	PCI_DEVICE_ID_NVIDIA_SGS_RIVA128 0x0018 [...] 
	Content analysis details:   (-2.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor ID definition for Aculab.

Signed-Off-By: Mark Brown <broonie@sirena.org.uk>

Index: e1000-queue/include/linux/pci_ids.h
===================================================================
--- e1000-queue.orig/include/linux/pci_ids.h	2006-02-25 12:50:12.000000000 +0000
+++ e1000-queue/include/linux/pci_ids.h	2006-02-25 12:51:51.000000000 +0000
@@ -1572,6 +1572,8 @@
 #define PCI_VENDOR_ID_NVIDIA_SGS	0x12d2
 #define PCI_DEVICE_ID_NVIDIA_SGS_RIVA128 0x0018
 
+#define PCI_VENDOR_ID_ACULAB 0x12d9
+
 #define PCI_SUBVENDOR_ID_CHASE_PCIFAST		0x12E0
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST4		0x0031
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST8		0x0021

--
"You grabbed my hand and we fell into it, like a daydream - or a fever."
