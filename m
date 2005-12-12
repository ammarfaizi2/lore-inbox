Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVLLBfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVLLBfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 20:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVLLBfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 20:35:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13072 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750978AbVLLBfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 20:35:36 -0500
Date: Mon, 12 Dec 2005 02:35:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/Kconfig: indentation fix
Message-ID: <20051212013536.GG23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a wrong indentation.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Nov 2005

--- linux-2.6.15-rc1-mm2-full/drivers/net/Kconfig.old	2005-11-19 04:03:27.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/net/Kconfig	2005-11-19 04:03:38.000000000 +0100
@@ -129,7 +129,7 @@
 
 	  If you don't have this card, of course say N.
 
-	source "drivers/net/arcnet/Kconfig"
+source "drivers/net/arcnet/Kconfig"
 
 source "drivers/net/phy/Kconfig"
 


