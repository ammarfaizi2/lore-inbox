Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbULLNBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbULLNBG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 08:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbULLNBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 08:01:06 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:28847 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262073AbULLNA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 08:00:58 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041212130119.10564.77657.47866@localhost.localdomain>
In-Reply-To: <20041212130113.10564.41012.78969@localhost.localdomain>
References: <20041212130113.10564.41012.78969@localhost.localdomain>
Subject: [PATCH] moxa: Remove ancient changelog README.moxa
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Sun, 12 Dec 2004 07:00:57 -0600
Date: Sun, 12 Dec 2004 07:00:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver at Moxa's website is version 1.8.  There is no need for this file.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-original/Documentation/README.moxa linux-2.6.10-rc3/Documentation/README.moxa
--- linux-2.6.10-rc3-original/Documentation/README.moxa	2004-12-03 16:52:41.000000000 -0500
+++ linux-2.6.10-rc3/Documentation/README.moxa	1969-12-31 19:00:00.000000000 -0500
@@ -1,18 +0,0 @@
- ===================================================================	
- Release Note of Linux Driver for Moxa's C104/C168/CI-104J
- ===================================================================	
-
- -------------------------------------------------------------------
- Ver. 1.1  				               Sep.  1, 1999
- -------------------------------------------------------------------
- 1. Improved:
-   a. Static driver (kernel) and dynamic driver (loadable module) 
-      modes are supported.
-   b. Multiple Smartio PCI series boards sharing the same IRQ 
-      supported.
-
- -------------------------------------------------------------------
- Ver. 1.0  				               Feb  17, 1997
- -------------------------------------------------------------------
- 1. Newly release.
-
