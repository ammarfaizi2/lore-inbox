Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267635AbUHMWLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267635AbUHMWLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUHMWKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:10:55 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:21769 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264704AbUHMWKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:10:02 -0400
Date: Fri, 13 Aug 2004 17:09:23 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss update [5/5] maintainers update for HP drivers
Message-ID: <20040813220923.GE1016@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 5 of 5.
This patch updates the MAINTAINERS for HP drivers.
Applies to 2.4.27. Please consider this for inclusion.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burNp lx2427-p004/MAINTAINERS lx2427/MAINTAINERS
--- lx2427-p004/MAINTAINERS	2004-08-07 18:26:04.000000000 -0500
+++ lx2427/MAINTAINERS	2004-08-13 16:21:04.527090112 -0500
@@ -456,14 +456,20 @@ L:	omnibook@zurich.ai.mit.edu
 S:      Maintained
 
 
+HP 66Mhz FIBRE CHANNEL DRIVER
+P:	Chirag Kantharia
+M:	chirag.kantharia@hp.com
+L:	iss_storagedev@hp.com
+S:	Maintained
+
 HP SMART2 RAID DRIVER
-P:     Francis Wiran
-M:     francis.wiran@hp.com
+P:	Chirag Kantharia
+M:	chirag.kantharia@hp.com
 L:     iss_storagedev@hp.com
-S:	Odd Fixes
+S:	Maintained
 
-HP SMART CISS RAID DRIVER
-P:     Mike Miller, Michael Ni
+HP SMART ARRAY CISS RAID DRIVER (cciss)
+P:	Mike Miller
 M:     mike.miller@hp.com
 L:     iss_storagedev@hp.com
 S:	Supported
