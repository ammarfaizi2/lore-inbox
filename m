Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVKGHF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVKGHF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVKGHFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:05:34 -0500
Received: from [85.8.13.51] ([85.8.13.51]:49815 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964802AbVKGHF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:05:26 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] wbsd version 1.5
Date: Mon, 07 Nov 2005 08:05:25 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051107070524.6673.89553.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New kernel, new patches, new version.

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

