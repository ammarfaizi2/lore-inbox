Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbULMTck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbULMTck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbULMT3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:29:32 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:49464 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262272AbULMSLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:11:16 -0500
Cc: openib-general@openib.org
In-Reply-To: <200412131010.qyAMW5NxoiM4CntC@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 13 Dec 2004 10:10:07 -0800
Message-Id: <200412131010.czsQg0IIemnlj3gy@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v3][21/21] InfiniBand MAINTAINERS entry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 13 Dec 2004 18:10:07.0771 (UTC) FILETIME=[FA5B0EB0:01C4E13E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add OpenIB maintainers information to MAINTAINERS.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/MAINTAINERS	2004-12-11 15:16:16.000000000 -0800
+++ linux-bk/MAINTAINERS	2004-12-13 09:44:51.816091929 -0800
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

