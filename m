Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVILUPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVILUPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVILUPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:15:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:25285 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932199AbVILUPW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:15:22 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe [2/2]: update driver version number to twelve
In-Reply-To: <11265558641200@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 12 Sep 2005 13:11:05 -0700
Message-Id: <11265558652786@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe [2/2]: update driver version number to twelve

Update driver version number to twelve.

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 49a1fd60d2a8e671222515cf6055e91781278517
tree 4d27a330c7944c8d67ab192fb30cab7659bdeb86
parent e39526e6e7a96904c9f1c85375d49ff437c18c44
author Ed L Cashin <ecashin@coraid.com> Fri, 19 Aug 2005 17:05:21 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 09 Sep 2005 14:23:19 -0700

 drivers/block/aoe/aoe.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "10"
+#define VERSION "12"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 

