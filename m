Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135772AbRDTB0e>; Thu, 19 Apr 2001 21:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135773AbRDTB0T>; Thu, 19 Apr 2001 21:26:19 -0400
Received: from upb.de ([131.234.22.30]:62689 "EHLO uni-paderborn.de")
	by vger.kernel.org with ESMTP id <S135772AbRDTB0G>;
	Thu, 19 Apr 2001 21:26:06 -0400
Date: Fri, 20 Apr 2001 03:25:53 +0200 (MET DST)
Message-Id: <200104200125.DAA17072@linde.uni-paderborn.de>
From: Axel Boldt <axel@uni-paderborn.de>
To: linux-kernel@vger.kernel.org
CC: esr@thyrsus.com, torvalds@transmeta.com
Subject: Configure.help maintainer change
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric has worked on Configure.help for some time now and I haven't,
so he will take over official maintenance of that file.

The attached patch is against 2.4.3.

Axel

--- linux/MAINTAINERS	Mon Mar 26 04:14:20 2001
+++ linux/MAINTAINERS.new	Fri Apr 20 03:05:23 2001
@@ -273,8 +273,8 @@
 S:	Maintained
 
 CONFIGURE.HELP
-P:	Axel Boldt
-M:	axel@uni-paderborn.de
+P:	Eric S. Raymond
+M:	esr@thyrsus.com
 S:	Maintained
 
 COSA/SRP SYNC SERIAL DRIVER
--- linux/Documentation/Configure.help	Mon Mar 26 04:24:31 2001
+++ linux/Documentation/Configure.help.new	Fri Apr 20 03:06:50 2001
@@ -1,4 +1,4 @@
-# Maintained by Axel Boldt (axel@uni-paderborn.de)
+# Maintained by Eric S. Raymond (esr@thyrsus.com)
 #
 # This version of the Linux kernel configuration help texts
 # corresponds to the kernel versions 2.4.x.

