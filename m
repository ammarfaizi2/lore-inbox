Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUKCPXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUKCPXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUKCPXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:23:04 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:51101 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261648AbUKCPWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:22:50 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041103152246.24869.2759.68945@localhost.localdomain>
Subject: [PATCH 1/5] documentation: Remove drivers/char/README.computone
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [68.238.31.6] at Wed, 3 Nov 2004 09:22:47 -0600
Date: Wed, 3 Nov 2004 09:22:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove depreciated file in drivers/char.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/drivers/char/README.computone linux-2.6.9/drivers/char/README.computone
--- linux-2.6.9-original/drivers/char/README.computone	2004-10-18 17:55:28.000000000 -0400
+++ linux-2.6.9/drivers/char/README.computone	1969-12-31 19:00:00.000000000 -0500
@@ -1,10 +0,0 @@
-Computone Intelliport II/Plus Multiport Serial Driver
------------------------------------------------------
-
-Release Notes For Linux Kernel 2.2 and higher
-
-This file is now deprecated and will be removed at some point.
-
-Please refer to the file Documentation/computone.txt instead.
-
-Michael H. Warfield 08/12/2001
