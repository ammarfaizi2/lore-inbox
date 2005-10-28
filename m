Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbVJ1Gbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVJ1Gbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbVJ1Gbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:48618 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965151AbVJ1Gb0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:26 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: update to version 14
In-Reply-To: <20051028062921.GA6397@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:21 -0700
Message-Id: <11304810212914@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe: update to version 14

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Update driver version number to 14.

---
commit 271c0df6e700b3f208b1802a1e96bb9eeeaa880c
tree 9ef2a3d1fff7584bf8ffc4513500e4af580d2fb7
parent 786fbf6c1eb91e7e70a1ef42ff2523aff0f09850
author Ed L. Cashin <ecashin@coraid.com> Thu, 29 Sep 2005 12:47:55 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:47:58 -0700

 drivers/block/aoe/aoe.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 0e9e586..881c48d 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "12"
+#define VERSION "14"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 

