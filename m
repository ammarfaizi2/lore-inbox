Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWBGQqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWBGQqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWBGQp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:45:59 -0500
Received: from ns1.coraid.com ([65.14.39.133]:60034 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1750961AbWBGQp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:45:57 -0500
Message-ID: <bacfe5c43a5ba2020719b4506ea3244f@coraid.com>
Date: Tue, 7 Feb 2006 11:37:36 -0500
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.16-rc2-git2-gkh] aoe [3/3]: update version to 22
References: <E1F6Vgr-0005nf-02@kokone>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Increase version number to 22.

diff -upr 2.6.16-rc2-git2-gkh-orig/drivers/block/aoe/aoe.h 2.6.16-rc2-git2-gkh-aoe/drivers/block/aoe/aoe.h
--- 2.6.16-rc2-git2-gkh-orig/drivers/block/aoe/aoe.h	2006-02-06 17:41:05.000000000 -0500
+++ 2.6.16-rc2-git2-gkh-aoe/drivers/block/aoe/aoe.h	2006-02-06 17:56:59.000000000 -0500
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "21"
+#define VERSION "22"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
