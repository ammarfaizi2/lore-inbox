Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVGGWn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVGGWn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVGGWlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 18:41:10 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:30877 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262124AbVGGWjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 18:39:23 -0400
Date: Thu, 7 Jul 2005 15:39:18 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] feature-removal-schedule corrections
Message-Id: <20050707153918.41669a35.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

Correct email address and a small typo.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 Documentation/feature-removal-schedule.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp linux-2613-rc2/Documentation/feature-removal-schedule.txt~doc-fixes linux-2613-rc2/Documentation/feature-removal-schedule.txt
--- linux-2613-rc2/Documentation/feature-removal-schedule.txt~doc-fixes	2005-07-07 14:46:18.000000000 -0700
+++ linux-2613-rc2/Documentation/feature-removal-schedule.txt	2005-07-07 15:05:06.000000000 -0700
@@ -39,7 +39,7 @@ When:	September 2005
 Why:	Replaced by io_remap_pfn_range() which allows more memory space
 	addressabilty (by using a pfn) and supports sparc & sparc64
 	iospace as part of the pfn.
-Who:	Randy Dunlap <rddunlap@osdl.org>
+Who:	Randy Dunlap <rdunlap@xenotime.net>
 
 ---------------------------
 
@@ -54,7 +54,7 @@ Who:	Adrian Bunk <bunk@stusta.de>
 What:	register_ioctl32_conversion() / unregister_ioctl32_conversion()
 When:	April 2005
 Why:	Replaced by ->compat_ioctl in file_operations and other method
-	vecors.
+	vectors.
 Who:	Andi Kleen <ak@muc.de>, Christoph Hellwig <hch@lst.de>
 
 ---------------------------

---
