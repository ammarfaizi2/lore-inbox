Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132711AbRDJQsR>; Tue, 10 Apr 2001 12:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbRDJQsH>; Tue, 10 Apr 2001 12:48:07 -0400
Received: from dryline-fw.yyz.somanetworks.com ([216.126.67.45]:60796 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S132465AbRDJQrz>; Tue, 10 Apr 2001 12:47:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15059.14646.729508.404327@somanetworks.com>
Date: Tue, 10 Apr 2001 12:47:50 -0400
From: "Georg Nikodym" <georgn@somanetworks.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Minor addition to pci.ids
X-Mailer: VM 6.90 under 21.2  (beta44) "Thalia" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For a cPCI card I'm working with...

Cheers.


--- 1.23.1.1/drivers/pci/pci.ids	Sun Mar 25 13:14:20 2001
+++ 1.25/drivers/pci/pci.ids	Mon Apr  9 11:46:36 2001
@@ -920,6 +920,7 @@
 	ac51  PCI1420
 	ac52  PCI1451 PC card Cardbus Controller
 	ac53  PCI1421 PC card Cardbus Controller
+	ac60  PCI2040 PCI to DSP Bridge Controller
 	fe00  FireWire Host Controller
 	fe03  12C01A FireWire Host Controller
 104d  Sony Corporation
