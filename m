Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbUKVP1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbUKVP1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUKVPQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 10:16:00 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:62915 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262137AbUKVPPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:15:39 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041122714.AyIOvRY195EGFTaO@topspin.com>
X-Mailer: roland_patchbomb
Date: Mon, 22 Nov 2004 07:14:27 -0800
Message-Id: <20041122714.y3rav5uMdVVNMNlz@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v1][12/12] InfiniBand MAINTAINERS entry
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 15:14:32.0759 (UTC) FILETIME=[F8530C70:01C4D0A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add OpenIB maintainers information to MAINTAINERS.

Signed-off-by: Roland Dreier <roland@topspin.com>


Index: linux-bk/MAINTAINERS
===================================================================
--- linux-bk.orig/MAINTAINERS	2004-11-21 21:07:06.694491878 -0800
+++ linux-bk/MAINTAINERS	2004-11-21 21:25:58.537516680 -0800
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

