Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbULTHoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbULTHoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbULTHna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:43:30 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19125 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261458AbULTGPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:15:21 -0500
Cc: openib-general@openib.org
In-Reply-To: <200412192215.pKjErOfjUaT6gtSk@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 19 Dec 2004 22:15:20 -0800
Message-Id: <200412192215.TKOr0u539NEw6MPp@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v4][24/24] InfiniBand MAINTAINERS entry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 20 Dec 2004 06:15:20.0332 (UTC) FILETIME=[485774C0:01C4E65B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add OpenIB maintainers information to MAINTAINERS.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/MAINTAINERS	2004-12-19 21:09:20.000000000 -0800
+++ linux-bk/MAINTAINERS	2004-12-19 22:04:20.988606172 -0800
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

