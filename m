Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUENOYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUENOYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUENOYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:24:37 -0400
Received: from aun.it.uu.se ([130.238.12.36]:42986 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261234AbUENOOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:14:04 -0400
Date: Fri, 14 May 2004 16:13:52 +0200 (MEST)
Message-Id: <200405141413.i4EEDqi7018437@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][7/7] perfctr-2.7.2 for 2.6.6-mm2: misc
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


perfctr-2.7.2 for 2.6.6-mm2, part 7/7:

- remaining small changes

 CREDITS     |    1 +
 MAINTAINERS |    6 ++++++
 2 files changed, 7 insertions(+)

diff -ruN linux-2.6.6-mm2/CREDITS linux-2.6.6-mm2.perfctr-2.7.2.misc/CREDITS
--- linux-2.6.6-mm2/CREDITS	2004-05-14 14:02:09.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.misc/CREDITS	2004-05-14 14:43:16.847899174 +0200
@@ -2527,6 +2527,7 @@
 E: mikpe@csd.uu.se
 W: http://www.csd.uu.se/~mikpe/
 D: Miscellaneous fixes
+D: Performance-monitoring counters driver
 
 N: Reed H. Petty
 E: rhp@draper.net
diff -ruN linux-2.6.6-mm2/MAINTAINERS linux-2.6.6-mm2.perfctr-2.7.2.misc/MAINTAINERS
--- linux-2.6.6-mm2/MAINTAINERS	2004-05-14 14:02:13.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.misc/MAINTAINERS	2004-05-14 14:43:16.847899174 +0200
@@ -1633,6 +1633,12 @@
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
