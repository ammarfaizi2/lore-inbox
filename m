Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266259AbUHNW5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUHNW5H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 18:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUHNW5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 18:57:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:62397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266259AbUHNW5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 18:57:02 -0400
Date: Sat, 14 Aug 2004 15:56:58 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typos in security/security.c
Message-ID: <20040814155658.A1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos in security/security.c.
                                                                                
From: Nicolas Kaiser <nikai@nikai.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/security.c 1.9 vs edited =====
--- 1.9/security/security.c	2003-09-12 08:41:47 -07:00
+++ edited/security/security.c	2004-08-13 11:26:14 -07:00
@@ -49,7 +49,7 @@
 }
 
 /**
- * security_scaffolding_startup - initialzes the security scaffolding framework
+ * security_scaffolding_startup - initializes the security scaffolding framework
  *
  * This should be called early in the kernel initialization sequence.
  */
@@ -183,7 +183,7 @@
  * capable - calls the currently loaded security module's capable() function with the specified capability
  * @cap: the requested capability level.
  *
- * This function calls the currently loaded security module's cabable()
+ * This function calls the currently loaded security module's capable()
  * function with a pointer to the current task and the specified @cap value.
  *
  * This allows the security module to implement the capable function call

