Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422859AbWJRUQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422859AbWJRUQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422815AbWJRUJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:17 -0400
Received: from mx1.suse.de ([195.135.220.2]:6066 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422810AbWJRUJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:12 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/15] aoe: update copyright date
Date: Wed, 18 Oct 2006 13:08:53 -0700
Message-Id: <11612021491255-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021463993-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Update the copyright year to 2006.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoe.h     |    2 +-
 drivers/block/aoe/aoeblk.c  |    2 +-
 drivers/block/aoe/aoechr.c  |    2 +-
 drivers/block/aoe/aoecmd.c  |    2 +-
 drivers/block/aoe/aoedev.c  |    2 +-
 drivers/block/aoe/aoemain.c |    2 +-
 drivers/block/aoe/aoenet.c  |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 6eebcb7..507c377 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 #define VERSION "22"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 393b86a..fa0e8ca 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoeblk.c
  * block device routines
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index 1bc1cf9..8a7a081 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoechr.c
  * AoE character device driver
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 39da28d..d1d8759 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoecmd.c
  * Filesystem request handling methods
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index c2bc3ed..c7e05ed 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoedev.c
  * AoE device utility functions; maintains device list.
diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index de08491..727c34d 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoemain.c
  * Module initialization routines, discover timer
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index c1434ed..1bba140 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoenet.c
  * Ethernet portion of AoE driver
-- 
1.4.2.4

