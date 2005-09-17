Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVIQNBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVIQNBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 09:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVIQNBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 09:01:35 -0400
Received: from [85.8.12.41] ([85.8.12.41]:44418 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750795AbVIQNBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 09:01:35 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] wbsd version bump
Date: Sat, 17 Sep 2005 15:01:38 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050917130137.5185.81106.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase wbsd version number.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -42,7 +42,7 @@
 #include "wbsd.h"
 
 #define DRIVER_NAME "wbsd"
-#define DRIVER_VERSION "1.4"
+#define DRIVER_VERSION "1.5"
 
 #ifdef CONFIG_MMC_DEBUG
 #define DBG(x...) \

