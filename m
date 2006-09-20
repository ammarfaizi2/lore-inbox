Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWITSwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWITSwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWITSwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:52:37 -0400
Received: from ns1.coraid.com ([65.14.39.133]:41080 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932248AbWITSwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:52:36 -0400
Message-ID: <8230e2515e9d8d399c9e01843b999c1d@coraid.com>
Date: Wed, 20 Sep 2006 14:36:48 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [02/14]: update copyright date
References: <E1GQ6uv-0001qi-00@kokone>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the copyright year to 2006.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
---

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoe.h 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h
--- 2.6.18-rc4-orig/drivers/block/aoe/aoe.h	2006-08-17 16:45:33.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h	2006-09-20 14:29:35.000000000 -0400
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 #define VERSION "22"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c	2006-08-17 16:45:33.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c	2006-09-20 14:29:35.000000000 -0400
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoeblk.c
  * block device routines
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoechr.c 2.6.18-rc4-aoe/drivers/block/aoe/aoechr.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoechr.c	2006-08-17 16:45:33.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoechr.c	2006-09-20 14:29:35.000000000 -0400
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoechr.c
  * AoE character device driver
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:33.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-09-20 14:29:35.000000000 -0400
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoecmd.c
  * Filesystem request handling methods
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoedev.c	2006-09-20 14:29:35.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoedev.c	2006-09-20 14:29:35.000000000 -0400
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoedev.c
  * AoE device utility functions; maintains device list.
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoemain.c 2.6.18-rc4-aoe/drivers/block/aoe/aoemain.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoemain.c	2006-08-17 16:45:33.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoemain.c	2006-09-20 14:29:35.000000000 -0400
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoemain.c
  * Module initialization routines, discover timer
diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoenet.c 2.6.18-rc4-aoe/drivers/block/aoe/aoenet.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoenet.c	2006-08-17 16:45:33.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoenet.c	2006-09-20 14:29:35.000000000 -0400
@@ -1,4 +1,4 @@
-/* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
+/* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
 /*
  * aoenet.c
  * Ethernet portion of AoE driver


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
