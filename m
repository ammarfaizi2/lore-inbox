Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758637AbWK1M6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758637AbWK1M6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758647AbWK1M6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:58:34 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:52153 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1758637AbWK1M6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:58:33 -0500
Message-ID: <1164720530.456c39921d80c@imp8-g19.free.fr>
Date: Tue, 28 Nov 2006 14:28:50 +0100
From: Remi <remi.colinet@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Typo fix for 2.6.19-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 81.255.27.251
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Typo fix for 2.6.19-rc6.

--- linux-2.6.19-rc6/fs/ext2/ext2.h        2006-11-20 19:25:16.000000000 +0100
+++ linux-2.6.19-rc6.fixed/fs/ext2/ext2.h        2006-11-28 10:39:04.000000000
+0100
@@ -27,7 +27,7 @@
         /*
          * i_block_group is the number of the block group which contains
          * this file's inode.  Constant across the lifetime of the inode,
-         * it is ued for making block allocation decisions - we try to
+         * it is used for making block allocation decisions - we try to
          * place a file's data blocks near its inode block, and new inodes
          * near to their parent directory's inode.
          */

Remi


