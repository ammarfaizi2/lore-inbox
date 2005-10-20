Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVJTRmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVJTRmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 13:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVJTRmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 13:42:11 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:3458 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S932503AbVJTRmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 13:42:10 -0400
Date: Thu, 20 Oct 2005 19:42:02 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix typo drivers/char/watchdog/w83627hf_wdt.c
Message-ID: <20051020174202.GA30201@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The most trivial typo fix in the world.

Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>

--- a/drivers/char/watchdog/w83627hf_wdt.c	2005-10-11 03:19:19.000000000 +0200
+++ b/drivers/char/watchdog/w83627hf_wdt.c	2005-10-20 19:39:01.000000000 +0200
@@ -359,5 +359,5 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Pdraig Brady <P@draigBrady.com>");
-MODULE_DESCRIPTION("w38627hf WDT driver");
+MODULE_DESCRIPTION("w83627hf WDT driver");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);


-- 
pozsy
