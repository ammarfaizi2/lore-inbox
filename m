Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUEaWcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUEaWcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbUEaWcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:32:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:37309 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264833AbUEaWWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:22:13 -0400
Date: Tue, 1 Jun 2004 00:22:04 +0200 (MEST)
Message-Id: <200405312222.i4VMM4ZQ012384@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.3 for 2.6.7-rc1-mm1, part 6/6:

- remaining small changes

 CREDITS     |    1 +
 MAINTAINERS |    6 ++++++
 2 files changed, 7 insertions(+)

diff -ruN linux-2.6.7-rc1-mm1/CREDITS linux-2.6.7-rc1-mm1.perfctr-2.7.3.misc/CREDITS
--- linux-2.6.7-rc1-mm1/CREDITS	2004-05-30 15:59:07.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.misc/CREDITS	2004-05-31 23:48:34.752821000 +0200
@@ -2527,6 +2527,7 @@
 E: mikpe@csd.uu.se
 W: http://www.csd.uu.se/~mikpe/
 D: Miscellaneous fixes
+D: Performance-monitoring counters driver
 
 N: Reed H. Petty
 E: rhp@draper.net
diff -ruN linux-2.6.7-rc1-mm1/MAINTAINERS linux-2.6.7-rc1-mm1.perfctr-2.7.3.misc/MAINTAINERS
--- linux-2.6.7-rc1-mm1/MAINTAINERS	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.misc/MAINTAINERS	2004-05-31 23:48:34.752821000 +0200
@@ -1643,6 +1643,12 @@
 L:	linux-net@vger.kernel.org
 S:	Supported
 
+PERFORMANCE-MONITORING COUNTERS DRIVER
+P:	Mikael Pettersson
+M:	mikpe@csd.uu.se
+W:	http://www.csd.uu.se/~mikpe/linux/perfctr/
+S:	Maintained
+
 PNP SUPPORT
 P:	Adam Belay
 M:	ambx1@neo.rr.com
