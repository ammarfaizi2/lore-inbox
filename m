Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVLTLVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVLTLVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 06:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVLTLVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 06:21:17 -0500
Received: from host234-100.pool8255.interbusiness.it ([82.55.100.234]:8332
	"EHLO zion.home.lan") by vger.kernel.org with ESMTP
	id S1750837AbVLTLVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 06:21:16 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] Resync Documentation/filesystems/00-INDEX
Date: Mon, 19 Dec 2005 22:24:31 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051219212425.1753.86715.stgit@zion.home.lan>
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

