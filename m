Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVKGHFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVKGHFR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVKGHFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:05:16 -0500
Received: from [85.8.13.51] ([85.8.13.51]:49815 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964797AbVKGHFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:05:15 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Add MODULE_AUTHOR to wbsd
Date: Mon, 07 Nov 2005 08:05:07 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051107070507.6655.60008.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'cause I'm in it for the chicks. ;)

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -2198,6 +2198,7 @@ module_param(irq, uint, 0444);
 module_param(dma, int, 0444);
 
 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pierre Ossman <drzeus@drzeus.cx>");
 MODULE_DESCRIPTION("Winbond W83L51xD SD/MMC card interface driver");
 MODULE_VERSION(DRIVER_VERSION);
 

