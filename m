Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbUKXALA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUKXALA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUKWRef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:34:35 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:896 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261360AbUKWQRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:17:37 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123816.Z3lNI0kVfxRLOphJ@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:16:27 -0800
Message-Id: <20041123816.kKEP5asEjoRbLoxS@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][21/21] InfiniBand MAINTAINERS entry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:16:32.0552 (UTC) FILETIME=[CBE82A80:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add OpenIB maintainers information to MAINTAINERS.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/MAINTAINERS	2004-11-23 08:09:38.208775343 -0800
+++ linux-bk/MAINTAINERS	2004-11-23 08:10:24.658926423 -0800
@@ -1075,6 +1075,17 @@
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

