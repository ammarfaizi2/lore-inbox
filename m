Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161340AbWASTMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161340AbWASTMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161343AbWASTMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:12:36 -0500
Received: from ns1.coraid.com ([65.14.39.133]:20392 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161342AbWASTL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:11:58 -0500
Message-ID: <ae14a7e9f114e74d4e297f0f8813bc43@coraid.com>
Date: Thu, 19 Jan 2006 13:46:31 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-git9] aoe [8/8]: update driver version number
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <E1EzelK-0006sT-00@kokone>
Gcc: nnfolder:Mail/sent-200601
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Update aoe driver version number.

diff -upr 2.6.15-git9-orig/drivers/block/aoe/aoe.h 2.6.15-git9-aoe/drivers/block/aoe/aoe.h
--- 2.6.15-git9-orig/drivers/block/aoe/aoe.h	2006-01-19 13:31:22.000000000 -0500
+++ 2.6.15-git9-aoe/drivers/block/aoe/aoe.h	2006-01-19 13:31:23.000000000 -0500
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "14"
+#define VERSION "21"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
