Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422844AbWJRUPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422844AbWJRUPC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422837AbWJRUOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:14:43 -0400
Received: from ns1.suse.de ([195.135.220.2]:23986 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422844AbWJRUJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:47 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/15] aoe: update driver version
Date: Wed, 18 Oct 2006 13:09:04 -0700
Message-Id: <11612021882386-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <1161202185862-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com> <11612021641240-git-send-email-greg@kroah.com> <11612021682148-git-send-email-greg@kroah.com> <1161202171977-git-send-email-greg@kroah.com> <11612021753859-git-send-email-greg@kroah.com> <1161202179462-git-send-email-greg@kroah.com> <11612021821994-git-send-email-greg@kroah.com> <1161202185862-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Update aoe driver version number to 32.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoe.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index b41fdfe..188bf09 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -1,5 +1,5 @@
 /* Copyright (c) 2006 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "22"
+#define VERSION "32"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 
-- 
1.4.2.4

