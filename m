Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVI2RDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVI2RDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVI2RDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:03:31 -0400
Received: from ns1.coraid.com ([65.14.39.133]:43608 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932264AbVI2RDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:03:08 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.14-rc2] aoe [3/3]: update to version 14
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <87wtkzbz5z.fsf@coraid.com>
Date: Thu, 29 Sep 2005 12:47:55 -0400
Message-ID: <87ek77akhw.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Update driver version number to 14.

Index: 2.6.14-rc2-aoe/drivers/block/aoe/aoe.h
===================================================================
--- 2.6.14-rc2-aoe.orig/drivers/block/aoe/aoe.h	2005-09-29 12:06:25.000000000 -0400
+++ 2.6.14-rc2-aoe/drivers/block/aoe/aoe.h	2005-09-29 12:06:41.000000000 -0400
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "12"
+#define VERSION "14"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 


-- 
  Ed L. Cashin <ecashin@coraid.com>

