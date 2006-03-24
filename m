Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423170AbWCXGMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423170AbWCXGMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423168AbWCXGMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:36826 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161011AbWCXGLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:44 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/12] aoe [8/8]: update driver version number
In-Reply-To: <1143180653135-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:54 -0800
Message-Id: <1143180654383-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update aoe driver version number.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/block/aoe/aoe.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

a712c0efbffb09f7b837577e29d0efb043fea0ea
diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index bb7dd91..7ff5f94 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "14"
+#define VERSION "21"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 
-- 
1.2.4


