Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266259AbSKLG3h>; Tue, 12 Nov 2002 01:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266248AbSKLG1q>; Tue, 12 Nov 2002 01:27:46 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:13714 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266241AbSKLG0h>;
	Tue, 12 Nov 2002 01:26:37 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [4/4]: Ext2/3 updates: Update required e2fsprogs version
From: tytso@mit.edu
Message-Id: <E18BUc1-0005j3-00@snap.thunk.org>
Date: Tue, 12 Nov 2002 01:33:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update required e2fsprogs version in Documentation/Changes.

Changes |    4 ++--
1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/Documentation/Changes b/Documentation/Changes
--- a/Documentation/Changes	Tue Nov 12 01:14:08 2002
+++ b/Documentation/Changes	Tue Nov 12 01:14:08 2002
@@ -53,7 +53,7 @@
 o  binutils               2.9.5.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
 o  modutils               2.4.2                   # insmod -V
-o  e2fsprogs              1.29                    # tune2fs
+o  e2fsprogs              1.32                    # e2fsck -V
 o  jfsutils               1.0.14                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
 o  xfsprogs               2.1.0                   # xfs_db -V
@@ -313,7 +313,7 @@
 
 E2fsprogs
 ---------
-o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
+o  <http://e2fsprogs.sourceforge.net>
 
 JFSutils
 --------
