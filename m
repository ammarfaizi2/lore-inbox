Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263736AbTCUSiL>; Fri, 21 Mar 2003 13:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263741AbTCUShZ>; Fri, 21 Mar 2003 13:37:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4996
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263736AbTCUSfZ>; Fri, 21 Mar 2003 13:35:25 -0500
Date: Fri, 21 Mar 2003 19:50:40 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211950.h2LJoeVd026055@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: typo fix for befs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/befs/debug.c linux-2.5.65-ac2/fs/befs/debug.c
--- linux-2.5.65/fs/befs/debug.c	2003-02-10 18:39:17.000000000 +0000
+++ linux-2.5.65-ac2/fs/befs/debug.c	2003-03-20 18:47:37.000000000 +0000
@@ -80,7 +80,7 @@
 
 	befs_block_run tmp_run;
 
-	befs_debug(sb, "befs_inode infomation");
+	befs_debug(sb, "befs_inode information");
 
 	befs_debug(sb, "  magic1 %08x", fs32_to_cpu(sb, inode->magic1));
 
