Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWACVaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWACVaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWACVaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:30:09 -0500
Received: from ns1.coraid.com ([65.14.39.133]:61129 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751486AbWACV3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:29:49 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-rc7] aoe [7/7]: update driver version number
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <87hd8l2fb4.fsf@coraid.com>
Date: Tue, 03 Jan 2006 16:08:33 -0500
Message-ID: <87bqytyq7i.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Update aoe driver version number.

Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoe.h
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoe.h	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoe.h	2006-01-02 13:35:15.000000000 -0500
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "14"
+#define VERSION "18"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 


-- 
  Ed L. Cashin <ecashin@coraid.com>

