Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272610AbTHKOGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272611AbTHKNmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:42:47 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:34699 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272610AbTHKNk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:58 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove version.h from bttv
Message-Id: <E19mCuP-0003dj-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/media/video/bttvp.h linux-2.5/drivers/media/video/bttvp.h
--- bk-linus/drivers/media/video/bttvp.h	2003-08-07 19:45:39.000000000 +0100
+++ linux-2.5/drivers/media/video/bttvp.h	2003-08-07 22:20:17.000000000 +0100
@@ -24,7 +24,7 @@
 #ifndef _BTTVP_H_
 #define _BTTVP_H_
 
-#include <linux/version.h>
+
 #define BTTV_VERSION_CODE KERNEL_VERSION(0,9,11)
 
 #include <linux/types.h>
