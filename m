Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423164AbWCXGMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423164AbWCXGMB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbWCXGMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:42970 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161018AbWCXGLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:54 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>
Subject: [PATCH 12/12] aoe [3/3]: update version to 22
In-Reply-To: <11431806542227-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:54 -0800
Message-Id: <11431806541278-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase version number to 22.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

---

 drivers/block/aoe/aoe.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

0fdf109676d1eda4ff8199a9a3ee3f11c555c1b3
diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 7ff5f94..6eebcb7 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "21"
+#define VERSION "22"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 
-- 
1.2.4


