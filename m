Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbUKCP0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbUKCP0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUKCP0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:26:17 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:38824 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261653AbUKCPXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:23:11 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041103152307.24869.18325.53451@localhost.localdomain>
In-Reply-To: <20041103152246.24869.2759.68945@localhost.localdomain>
References: <20041103152246.24869.2759.68945@localhost.localdomain>
Subject: [PATCH 4/5] documentation: Remove drivers/char/README.scc
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [68.238.31.6] at Wed, 3 Nov 2004 09:23:07 -0600
Date: Wed, 3 Nov 2004 09:23:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded file in drivers/char.  

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/drivers/char/README.scc linux-2.6.9/drivers/char/README.scc
--- linux-2.6.9-original/drivers/char/README.scc	2004-10-18 17:53:22.000000000 -0400
+++ linux-2.6.9/drivers/char/README.scc	1969-12-31 19:00:00.000000000 -0500
@@ -1,5 +0,0 @@
-The z8530drv is now a network device driver, you can find it in
-	../net/scc.c
-
-A subset of the documentation is in
-	Documentation/networking/z8530drv.txt
