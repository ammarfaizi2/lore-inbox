Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVKTTKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVKTTKE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 14:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbVKTTKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 14:10:04 -0500
Received: from host222-100.pool871.interbusiness.it ([87.1.100.222]:29892 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750795AbVKTTKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 14:10:01 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/2] Resync Documentation/filesystems/00-INDEX
Date: Sun, 20 Nov 2005 20:09:05 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051120190905.4091.60463.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

