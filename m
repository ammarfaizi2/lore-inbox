Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUGSJQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUGSJQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 05:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUGSJQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 05:16:10 -0400
Received: from village.ehouse.ru ([193.111.92.18]:16389 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264270AbUGSJQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 05:16:07 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Subject: Fwd: [PATCH] Remove prototypes of nonexistent functions from fs/befs files
Date: Mon, 19 Jul 2004 13:15:52 +0400
User-Agent: KMail/1.6.2
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Carl Spalletta <cspalletta@yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407191315.52063.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply.

Thank you Carl!

----------  Forwarded Message  ----------

Subject: [PATCH] Remove prototypes of nonexistent functions from fs/befs files
Date: Sunday 18 July 2004 23:01
From: Carl Spalletta <cspalletta@yahoo.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rathamahata@php4.ru

diff -ru linux-2.6.7-orig/fs/befs/befs.h linux-2.6.7-new/fs/befs/befs.h
--- linux-2.6.7-orig/fs/befs/befs.h     2004-06-15 22:19:52.000000000 -0700
+++ linux-2.6.7-new/fs/befs/befs.h      2004-07-18 08:42:01.000000000 -0700
@@ -96,7 +96,6 @@
 void befs_dump_inode(const struct super_block *sb, befs_inode *);
 void befs_dump_index_entry(const struct super_block *sb, befs_btree_super *);
 void befs_dump_index_node(const struct super_block *sb, befs_btree_nodehead *);
-void befs_dump_inode_addr(const struct super_block *sb, befs_inode_addr);
 /****************************/




-------------------------------------------------------
Signed-off-by: Sergey S. Kostyliov <rathamahata@php4.ru>

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
