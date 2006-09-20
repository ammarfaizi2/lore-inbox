Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWITS5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWITS5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWITS5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:57:17 -0400
Received: from ns1.coraid.com ([65.14.39.133]:47992 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932266AbWITS5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:57:12 -0400
Message-ID: <3aa1a14a4fd04248ac5eedb42869234e@coraid.com>
Date: Wed, 20 Sep 2006 14:36:51 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [13/14]: update driver version
References: <E1GQ6uv-0001qi-00@kokone>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update aoe driver version number to 32.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
---

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoe.h 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h
--- 2.6.18-rc4-orig/drivers/block/aoe/aoe.h	2006-09-20 14:29:36.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h	2006-09-20 14:29:36.000000000 -0400
@@ -1,5 +1,5 @@
 /* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "22"
+#define VERSION "32"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
