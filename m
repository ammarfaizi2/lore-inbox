Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVBFTaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVBFTaV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVBFTaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:30:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3844 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261267AbVBFTaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:30:17 -0500
Date: Sun, 6 Feb 2005 20:30:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/input/gameport/cs461x.c: remove bouncing email address
Message-ID: <20050206193013.GB3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remoces the bouncing email address of Victor Krapivin from 
MODULE_AUTHOR.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm1-full/drivers/input/gameport/cs461x.c.old	2005-02-06 20:24:35.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/input/gameport/cs461x.c	2005-02-06 20:24:49.000000000 +0100
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 
-MODULE_AUTHOR("Victor Krapivin <vik@belcaf.minsk.by>");
+MODULE_AUTHOR("Victor Krapivin");
 MODULE_LICENSE("GPL");
 
 /*

