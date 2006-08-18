Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbWHRSzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbWHRSzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWHRSzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:55:16 -0400
Received: from ns1.coraid.com ([65.14.39.133]:61541 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161081AbWHRSzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:55:10 -0400
Message-ID: <be31f61ee6da74e7cf029116d94b447f@coraid.com>
Date: Fri, 18 Aug 2006 13:40:24 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [13/13]: update driver version
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Update aoe driver version number to 32.

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoe.h 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h
--- 2.6.18-rc4-orig/drivers/block/aoe/aoe.h	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoe.h	2006-08-17 16:45:35.000000000 -0400
@@ -1,5 +1,5 @@
 /* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "22"
+#define VERSION "32"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
