Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVLRQXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVLRQXE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 11:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbVLRQXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 11:23:04 -0500
Received: from host229-46.pool8259.interbusiness.it ([82.59.46.229]:9403 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965216AbVLRQXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 11:23:03 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] Resync Documentation/filesystems/00-INDEX
Date: Sun, 18 Dec 2005 17:22:41 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051218162241.31849.90249.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Remove non-existing entry for fat_cvf.txt (was it ever supported?).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 Documentation/filesystems/00-INDEX |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/00-INDEX b/Documentation/filesystems/00-INDEX
index bcfbab8..7e17712 100644
--- a/Documentation/filesystems/00-INDEX
+++ b/Documentation/filesystems/00-INDEX
@@ -18,8 +18,6 @@ devfs/
 	- directory containing devfs documentation.
 ext2.txt
 	- info, mount options and specifications for the Ext2 filesystem.
-fat_cvf.txt
-	- info on the Compressed Volume Files extension to the FAT filesystem
 hpfs.txt
 	- info and mount options for the OS/2 HPFS.
 isofs.txt

