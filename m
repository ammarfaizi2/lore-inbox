Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbUJ1PMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUJ1PMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUJ1PJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:09:04 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:58534 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261691AbUJ1PB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:01:28 -0400
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041028150125.2776.85757.89489@localhost.localdomain>
In-Reply-To: <20041028150029.2776.69333.50087@localhost.localdomain>
References: <20041028150029.2776.69333.50087@localhost.localdomain>
Subject: [PATCH 9/9] to kernel/power/Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:01:25 -0500
Date: Thu, 28 Oct 2004 10:01:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Fix a couple of misspellings in kernel/power/Kconfig.
Apply against 2.6.9.

Signed-off-by:  James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/kernel/power/Kconfig linux-2.6.9/kernel/power/Kconfig
--- linux-2.6.9-original/kernel/power/Kconfig	2004-10-18 17:54:55.000000000 -0400
+++ linux-2.6.9/kernel/power/Kconfig	2004-10-28 10:53:02.583350353 -0400
@@ -29,7 +29,7 @@
 	bool "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
 	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
+	  Enable the possibility of suspending machine. It doesn't need APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
 	  (patch for sysvinit needed). 
 
