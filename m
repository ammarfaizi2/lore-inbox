Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbUKCP0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUKCP0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUKCP0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:26:32 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:45525 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261658AbUKCPXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:23:19 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041103152314.24869.56459.88722@localhost.localdomain>
In-Reply-To: <20041103152246.24869.2759.68945@localhost.localdomain>
References: <20041103152246.24869.2759.68945@localhost.localdomain>
Subject: [PATCH 5/5] documentation: Remove drivers/char/README.cycladesZ
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [68.238.31.6] at Wed, 3 Nov 2004 09:23:14 -0600
Date: Wed, 3 Nov 2004 09:23:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove obsolete file in drivers/char.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/drivers/char/README.cycladesZ linux-2.6.9/drivers/char/README.cycladesZ
--- linux-2.6.9-original/drivers/char/README.cycladesZ	2004-10-18 17:54:32.000000000 -0400
+++ linux-2.6.9/drivers/char/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
@@ -1,8 +0,0 @@
-
-The Cyclades-Z must have firmware loaded onto the card before it will
-operate.  This operation should be performed during system startup,
-
-The firmware, loader program and the latest device driver code are
-available from Cyclades at
-    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
-
