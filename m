Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266015AbTFWNMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbTFWNKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:10:42 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:4487 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S266016AbTFWNAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 09:00:03 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>, torvalds@osdl.org
Subject: [PATCH] Please restore my (c)
Date: Mon, 23 Jun 2003 15:15:05 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306231515.05621.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch restores my copyright notice for the HTree directory index, 
inadvertently omitted during the conversion from Ext2 to Ext3.

Linus, please apply.

--- 2.5.72.clean/fs/ext3/dir.c	2003-06-17 06:20:02.000000000 +0200
+++ 2.5.72/fs/ext3/dir.c	2003-06-19 04:29:27.000000000 +0200
@@ -16,6 +16,9 @@
  *
  *  Big-endian to little-endian byte-swapping/bitmaps by
  *        David S. Miller (davem@caip.rutgers.edu), 1995
+ *
+ * Hash Tree Directory indexing (c) 2001  Daniel Phillips
+ *
  */
 
 #include <linux/fs.h>


