Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267491AbUHJQgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbUHJQgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUHJQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:36:04 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:26640 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267529AbUHJQP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:15:57 -0400
Date: Tue, 10 Aug 2004 11:15:17 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [8/8] maintainers updates for HP drivers
Message-ID: <20040810161517.GH19909@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch 8 of 8
This patch updates the maintainers list for HP drivers.
Patch applies to 2.6.8-rc4.
Please consider this for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc3-p007/MAINTAINERS lx268-rc3/MAINTAINERS
--- lx268-rc3-p007/MAINTAINERS	2004-08-05 09:55:56.000000000 -0500
+++ lx268-rc3/MAINTAINERS	2004-08-06 10:34:58.684553448 -0500
@@ -905,18 +905,18 @@ L:	linux-hippi@sunsite.dk
 S:	Maintained
 
 HEWLETT-PACKARD FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
-P:	Chase Maupin
-M:	chase.maupin@hp.com
+P:	Chirag Kantharia
+M:	chirag.kantharia@hp.com
 L:	iss_storagedev@hp.com
 S:	Maintained
  
 HEWLETT-PACKARD SMART2 RAID DRIVER
-P:	Francis Wiran
-M:	francis.wiran@hp.com
+P:	Chirag Kantharia
+M:	chirag.kantharia@hp.com
 L:	iss_storagedev@hp.com
 S:	Maintained
  
-HEWLETT-PACKARD SMART CISS RAID DRIVER 
+HEWLETT-PACKARD SMART CISS RAID DRIVER (cciss)
 P:	Mike Miller
 M:	mike.miller@hp.com
 L:	iss_storagedev@hp.com
