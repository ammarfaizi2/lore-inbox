Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTJ2TEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTJ2TEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:04:38 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:34579 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261270AbTJ2TEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:04:36 -0500
Date: Wed, 29 Oct 2003 13:24:44 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, fred.harris@hp.com, mike.miller@hp.com
Subject: Maintainers list update for HP
Message-ID: <Pine.LNX.4.58.0310291312410.11806@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch updates the MAINTAINERS file for the HP storage
drivers. The previous contacts email addresses are no longer valid. Please
include this update. It was built using pre7 and tested against
2.4.23-pre8.

Thanks,
mikem
mike.miller@hp.com
_______________________________________________________________________________
diff -burN lx2423-pre7.orig/MAINTAINERS lx2423-pre7/MAINTAINERS
--- lx2423-pre7.orig/MAINTAINERS	2003-10-20 17:45:34.000000000 -0500
+++ lx2423-pre7/MAINTAINERS	2003-10-29 11:35:06.000000000 -0600
@@ -430,25 +430,22 @@
 W:	http://www.coda.cs.cmu.edu/
 S:	Maintained

-HP (was COMPAQ) FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
-P:      Stephen Cameron
-M:      arrays@hp.com
-M:      steve.cameron@hp.com
-L:	cpqfc-discuss@lists.sourceforge.net
+HP FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
+P:      Chase Maupin
+M:      chase.maupin@hp.com
+L:	iss_storagedev@hp.com
 S:      Odd Fixes

-HP (was COMPAQ) SMART2 RAID DRIVER
-P:	Stephen Cameron
-M:	arrays@hp.com
-M:	steve.cameron@hp.com
-L:	cpqarray-discuss@lists.sourceforge.net
+HP SMART2 RAID DRIVER
+P:	Francis Wiran
+M:	francis.wiran@hp.com
+L:	iss_storagedev@hp.com
 S:	Odd Fixes

-HP (was COMPAQ) SMART CISS RAID DRIVER
-P:	Stephen Cameron
-M:	arrays@hp.com
-M:	steve.cameron@hp.com
-L:	cciss-discuss@lists.sourceforge.net
+HP SMART CISS RAID DRIVER
+P:	Mike Miller, Michael Ni
+M:	mike.miller@hp.com
+L:	iss_storagedev@hp.com
 S:	Supported

 COMPUTONE INTELLIPORT MULTIPORT CARD
_______________________________________________________________________________


