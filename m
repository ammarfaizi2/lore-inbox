Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbTFSAUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265645AbTFSAUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:20:08 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:60043 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S265644AbTFSAUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:20:05 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Please restore my (c)
Date: Thu, 19 Jun 2003 02:34:46 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306190234.46557.phillips@arcor.de>
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

