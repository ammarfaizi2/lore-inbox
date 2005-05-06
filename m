Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVEFUFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVEFUFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 16:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVEFUFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 16:05:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56324 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261280AbVEFUF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 16:05:28 -0400
Date: Fri, 6 May 2005 22:05:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mhw@wittsend.com
Subject: [2.6 patch] update Computone MAINTAINERS entry
Message-ID: <20050506200523.GL3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch states that Michael still maintains this driver and removes 
a no longer mailing list.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 2 Feb 2005

--- linux-2.6.11-rc2-mm2-full/MAINTAINERS.old	2005-02-02 18:51:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/MAINTAINERS	2005-02-02 18:52:13.000000000 +0100
@@ -561,10 +561,9 @@
 
 COMPUTONE INTELLIPORT MULTIPORT CARD
 P:	Michael H. Warfield
-M:	Michael H. Warfield <mhw@wittsend.com>
+M:	mhw@wittsend.com
 W:	http://www.wittsend.com/computone.html
-L:	linux-computone@lazuli.wittsend.com
-S:	Orphaned
+S:	Maintained
 
 COSA/SRP SYNC SERIAL DRIVER
 P:	Jan "Yenya" Kasprzak

