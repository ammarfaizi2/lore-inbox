Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUEVGpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUEVGpj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 02:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUEVGpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 02:45:39 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:30470 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264880AbUEVGpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 02:45:16 -0400
Date: Sat, 22 May 2004 14:43:17 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, joe@perches.com
Subject: [PATCH] autofs4 maintainer 
Message-ID: <Pine.LNX.4.58.0405221417260.4426@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

This is a patch to change the autofs4 maintainer to me. Recommended by Joe 
Perches and OKed with Jeremy.

--- linux-2.6.6-mm4.orig/MAINTAINERS	2004-05-22 13:57:14.000000000 +0800
+++ linux-2.6.6-mm4/MAINTAINERS	2004-05-22 14:07:27.000000000 +0800
@@ -1189,8 +1189,8 @@
 S:	Odd Fixes
 
 KERNEL AUTOMOUNTER v4 (AUTOFS4)
-P:	Jeremy Fitzhardinge
-M:	jeremy@goop.org
+P:	Ian Kent
+M:	raven@themaw.net
 L:	autofs@linux.kernel.org
 S:	Maintained
 

