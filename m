Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSIZNua>; Thu, 26 Sep 2002 09:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSIZNua>; Thu, 26 Sep 2002 09:50:30 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:21123 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261287AbSIZNu2>; Thu, 26 Sep 2002 09:50:28 -0400
Date: Thu, 26 Sep 2002 14:55:32 +0100
Message-Id: <200209261355.g8QDtWv17014@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 7/7] 2.4.20-pre4/ext3: Bump ext3 version number
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext3 version -> 2.4-0.9.19

--- linux-2.4-ext3merge/include/linux/ext3_fs.h.=K0006=.orig	Thu Sep 26 12:19:14 2002
+++ linux-2.4-ext3merge/include/linux/ext3_fs.h	Thu Sep 26 12:25:37 2002
@@ -36,8 +36,8 @@
 /*
  * The second extended file system version
  */
-#define EXT3FS_DATE		"10 Jan 2002"
-#define EXT3FS_VERSION		"2.4-0.9.17"
+#define EXT3FS_DATE		"19 August 2002"
+#define EXT3FS_VERSION		"2.4-0.9.19"
 
 /*
  * Debug code
