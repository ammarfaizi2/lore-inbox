Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVCXPNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVCXPNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVCXPNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:13:49 -0500
Received: from geode.he.net ([216.218.230.98]:29966 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262555AbVCXPNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:13:14 -0500
From: ecashin@noserose.net
Message-Id: <1111677190.26362@geode.he.net>
Date: Thu, 24 Mar 2005 07:13:10 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [3/12]: update driver version to 6
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


update driver version to 6

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-03-10 12:19:11.000000000 -0500
+++ b/drivers/block/aoe/aoe.h	2005-03-10 12:19:14.000000000 -0500
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "5"
+#define VERSION "6"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 


-- 
  Ed L. Cashin <ecashin@coraid.com>
