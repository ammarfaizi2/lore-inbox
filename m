Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVAaVpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVAaVpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVAaVpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:45:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2574 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261381AbVAaVpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:45:06 -0500
Date: Mon, 31 Jan 2005 22:45:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jonathan@buzzard.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove subscribers-only tlinux-users address
Message-ID: <20050131214503.GE21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's generally agreed that subscribers-only mailing lists shouldn't be 
listed in MAINTAINERS (since it's impossible to send a simple Cc to such 
a list).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Dec 2004
- 20 Dec 2004

--- linux-2.6.10-rc2-mm4-full/MAINTAINERS.old	2004-12-06 19:40:38.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/MAINTAINERS	2004-12-06 19:40:54.000000000 +0100
@@ -2188,7 +2188,6 @@
 TOSHIBA SMM DRIVER
 P:	Jonathan Buzzard
 M:	jonathan@buzzard.org.uk
-L:	tlinux-users@tce.toshiba-dme.co.jp
 W:	http://www.buzzard.org.uk/toshiba/
 S:	Maintained
 

