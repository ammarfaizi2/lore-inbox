Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVCIXrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVCIXrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVCIXos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:44:48 -0500
Received: from baikonur.stro.at ([213.239.196.228]:56468 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S262118AbVCIXm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:42:27 -0500
Date: Thu, 10 Mar 2005 00:42:23 +0100
From: maximilian attems <janitor@sternwelten.at>
To: lmkl <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Subject: [patch trivial] as-iosched fix path to Documentation
Message-ID: <20050309234223.GD10685@sputnik.stro.at>
References: <20041208174401.GC2237@stro.at> <20041209190721.GA15918@ai.wu-wien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209190721.GA15918@ai.wu-wien.ac.at>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Klaus Ita <klaus@worstofall.com>

subject says all, patch still applies.

#signed-off-by: maximilian attems <janitor@sternwelten.at>

diff --unified --recursive --new-file linux-2.6.9/drivers/block/as-iosched.c linux-2.6.9_klaus/drivers/block/as-iosched.c
--- linux-2.6.9/drivers/block/as-iosched.c	2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6.9_klaus/drivers/block/as-iosched.c	2004-12-09 20:00:34.000000000 +0100
@@ -25,7 +25,7 @@
 #define REQ_ASYNC	0
 
 /*
- * See Documentation/as-iosched.txt
+ * See Documentation/block/as-iosched.txt
  */
 
 /*


