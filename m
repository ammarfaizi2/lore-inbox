Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTB0Pvt>; Thu, 27 Feb 2003 10:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbTB0Pvt>; Thu, 27 Feb 2003 10:51:49 -0500
Received: from inmail.compaq.com ([161.114.1.205]:22029 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S265373AbTB0Pvr>; Thu, 27 Feb 2003 10:51:47 -0500
Date: Thu, 27 Feb 2003 10:04:31 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: charles.white@hp.com, amy.vanzant-hodge@hp.com
Subject: [PATCH] 2.5.21-pre5, MAINTAINTERS, cciss/cpqarray/cpqfc
Message-ID: <20030227040431.GA2813@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Charles White and Amy Vanzant-Hodge have moved on
to do other things. 

-- steve

--- lx2421p5/MAINTAINERS~maint	2003-02-27 09:57:04.000000000 +0600
+++ lx2421p5-scameron/MAINTAINERS	2003-02-27 09:59:38.000000000 +0600
@@ -335,25 +335,25 @@ L:	codalist@coda.cs.cmu.edu
 W:	http://www.coda.cs.cmu.edu/
 S:	Maintained
 
-COMPAQ FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
-P:      Amy Vanzant-Hodge 
-M:      Amy Vanzant-Hodge (fibrechannel@compaq.com)
-L:	compaqandlinux@cpqlin.van-dijk.net
-W:	ftp.compaq.com/pub/products/drivers/linux
-S:      Supported
+HP (was COMPAQ) FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
+P:      Stephen Cameron
+M:      arrays@hp.com 
+M:      steve.cameron@hp.com
+L:	cpqfc-discuss@lists.sourceforge.net
+S:      Odd Fixes
+
+HP (was COMPAQ) SMART2 RAID DRIVER
+P:	Stephen Cameron
+M:	arrays@hp.com
+M:	steve.cameron@hp.com
+L:	cpqarray-discuss@lists.sourceforge.net
+S:	Odd Fixes
 
-COMPAQ SMART2 RAID DRIVER
-P:	Charles White	
-M:	Charles White <arrays@compaq.com>
-L:	compaqandlinux@cpqlin.van-dijk.net
-W:	ftp.compaq.com/pub/products/drivers/linux
-S:	Supported	
-
-COMPAQ SMART CISS RAID DRIVER 
-P:	Charles White
-M:	Charles White <arrays@compaq.com>
-L:	compaqandlinux@cpqlin.van-dijk.net
-W:	ftp.compaq.com/pub/products/drivers/linux	
+HP (was COMPAQ) SMART CISS RAID DRIVER 
+P:	Stephen Cameron
+M:	arrays@hp.com
+M:	steve.cameron@hp.com
+L:	cciss-discuss@lists.sourceforge.net
 S:	Supported 
 
 COMPUTONE INTELLIPORT MULTIPORT CARD

_
