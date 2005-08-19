Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVHSVdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVHSVdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVHSVdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:33:35 -0400
Received: from ns1.coraid.com ([65.14.39.133]:28025 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932293AbVHSVde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:33:34 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.13-rc6] aoe [2/2]: update driver version number to
 twelve
From: Ed L Cashin <ecashin@coraid.com>
References: <87fyt5k5po.fsf@coraid.com>
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Aug 2005 17:05:21 -0400
Message-ID: <874q9lk57y.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update driver version number to twelve.

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

Index: 2.6.13-rc6-aoe/drivers/block/aoe/aoe.h
===================================================================
--- 2.6.13-rc6-aoe.orig/drivers/block/aoe/aoe.h	2005-08-19 11:57:04.000000000 -0400
+++ 2.6.13-rc6-aoe/drivers/block/aoe/aoe.h	2005-08-19 11:57:05.000000000 -0400
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "10"
+#define VERSION "12"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 


-- 
  Ed L. Cashin <ecashin@coraid.com>

