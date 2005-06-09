Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVFIXeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVFIXeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVFIXeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:34:03 -0400
Received: from hockin.org ([66.35.79.110]:24985 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262438AbVFIXdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:33:33 -0400
Date: Thu, 9 Jun 2005 16:33:12 -0700
From: Tim Hockin <thockin@hockin.org>
To: mj@ucw.cz, pciids-devel@lists.sourceforge.net
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: PCI IDs for NVida nForce
Message-ID: <20050609233312.GA3089@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Info from a CK804 (nForce4, nForce Pro, etc) board:

Signed-off-by: Tim Hockin <thockin@hockin.org>


--- old/drivers/pci/pci.ids	2005-06-09 16:29:08.000000000 -0700
+++ new/drivers/pci/pci.ids	2005-05-11 19:37:07.000000000 -0700
@@ -3116,6 +3116,22 @@
 	002e  NV6 [Vanta]
 	002f  NV6 [Vanta]
 	0041  NV40 OS1RT00B30
+	0050  nForce Professional ISA Bridge (LPC)
+	0051  nForce Professional ISA Bridge (LPC)
+	0052  nForce Professional SMBus Controller
+	0053  nForce Professional IDE Controller
+	0054  nForce Professional SATA Controller
+	0055  nForce Professional SATA Controller
+	0056  nForce Professional Ethernet Controller
+	0057  nForce Professional Ethernet Controller
+	0058  nForce Professional AC'97 Modem Codec
+	0059  nForce Professional AC'97 Audio Codec
+	005a  nForce Professional USB 1.1 Controller
+	005b  nForce Professional USB 2.0 Controller
+	005c  nForce Professional PCI Bridge
+	005d  nForce Professional PCI Express Port
+	005e  nForce Professional HyperTransport Bridge
+	005f  nForce Professional Memory Controller
 	0060  nForce2 ISA Bridge
 		1043 80ad  A7N8X Mainboard
 	0064  nForce2 SMBus (MCP)
