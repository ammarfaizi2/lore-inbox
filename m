Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWFUO05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWFUO05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWFUO0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:26:40 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751616AbWFUO0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:32 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 17/21] [MMC] Version bump sdhci
Date: Wed, 21 Jun 2006 16:26:33 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142633.8857.46514.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New version number for sdhci driver.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 1e08acc..1a12427 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -21,7 +21,7 @@ #include <asm/scatterlist.h>
 #include "sdhci.h"
 
 #define DRIVER_NAME "sdhci"
-#define DRIVER_VERSION "0.11"
+#define DRIVER_VERSION "0.12"
 
 #define BUGMAIL "<sdhci-devel@list.drzeus.cx>"
 

