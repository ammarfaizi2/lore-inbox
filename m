Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUL1Hd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUL1Hd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 02:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUL1HXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 02:23:53 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:49490 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262103AbUL1F7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:59:10 -0500
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       openib-general@openib.org
In-Reply-To: <200412272151.S29WkrmlJifc5kHZ@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 27 Dec 2004 21:51:20 -0800
Message-Id: <200412272151.hCBo2fMh4Io7Xy87@topspin.com>
Mime-Version: 1.0
To: davem@davemloft.net
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v5][24/24] InfiniBand MAINTAINERS entry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 28 Dec 2004 05:51:21.0204 (UTC) FILETIME=[41DBF340:01C4ECA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add OpenIB maintainers information to MAINTAINERS.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/MAINTAINERS	2004-12-27 21:47:44.140300651 -0800
+++ linux-bk/MAINTAINERS	2004-12-27 21:48:28.966702428 -0800
@@ -1081,6 +1081,17 @@
 L:	linux-fbdev-devel@lists.sourceforge.net
 S:	Maintained
 
+INFINIBAND SUBSYSTEM
+P:	Roland Dreier
+M:	roland@topspin.com
+P:	Sean Hefty
+M:	mshefty@ichips.intel.com
+P:	Hal Rosenstock
+M:	halr@voltaire.com
+L:	openib-general@openib.org
+W:	http://www.openib.org/
+S:	Supported
+
 INPUT (KEYBOARD, MOUSE, JOYSTICK) DRIVERS
 P:	Vojtech Pavlik
 M:	vojtech@suse.cz

