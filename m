Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268190AbUHFRVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268190AbUHFRVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268186AbUHFRTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:19:54 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:51985 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S268216AbUHFRLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:11:01 -0400
Date: Fri, 6 Aug 2004 11:37:22 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update 8 maintainers update for HP
Message-ID: <20040806163722.GB19967@beardog.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 8
This patch updates the maintainers list for HP drivers.
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
