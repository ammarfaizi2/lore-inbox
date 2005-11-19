Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVKSUdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVKSUdS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVKSUcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:32:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42501 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750811AbVKSUct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:32:49 -0500
Date: Sat, 19 Nov 2005 09:03:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/Kconfig: indentation fix
Message-ID: <20051119080322.GF16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a wrong indentation.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm2-full/drivers/net/Kconfig.old	2005-11-19 04:03:27.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/net/Kconfig	2005-11-19 04:03:38.000000000 +0100
@@ -129,7 +129,7 @@
 
 	  If you don't have this card, of course say N.
 
-	source "drivers/net/arcnet/Kconfig"
+source "drivers/net/arcnet/Kconfig"
 
 source "drivers/net/phy/Kconfig"
 

