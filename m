Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263693AbUJ3A2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbUJ3A2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263704AbUJ3ATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:19:47 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:63371 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S263739AbUJ3AOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:14:41 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041030001436.12226.99920.80944@localhost.localdomain>
In-Reply-To: <20041030001423.12226.74257.30654@localhost.localdomain>
References: <20041030001423.12226.74257.30654@localhost.localdomain>
Subject: [PATCH 2/2] to MAINTAINERS
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.211.53] at Fri, 29 Oct 2004 19:14:36 -0500
Date: Fri, 29 Oct 2004 19:14:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Update status of digiecpa driver in MAINTAINERS.
Apply against 2.6.9.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/MAINTAINERS linux-2.6.9/MAINTAINERS
--- linux-2.6.9-original/MAINTAINERS	2004-10-18 17:54:37.000000000 -0400
+++ linux-2.6.9/MAINTAINERS	2004-10-29 19:41:30.570556137 -0400
@@ -670,7 +670,7 @@
 M:	Eng.Linux@digi.com
 L:	Eng.Linux@digi.com
 W:	http://www.digi.com
-S:	Maintained
+S:	Orphaned
 
 DIGI RIGHTSWITCH NETWORK DRIVER
 P:	Rick Richardson
