Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWCDRKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWCDRKE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbWCDRKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:10:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1299 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751881AbWCDRKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:10:03 -0500
Date: Sat, 4 Mar 2006 18:10:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove MAINTAINERS entry for rtlinux
Message-ID: <20060304171002.GF9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's already big enough and there's no reason to list maintainers of
external patches.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm2-full/MAINTAINERS.old	2006-03-04 18:06:42.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/MAINTAINERS	2006-03-04 18:06:50.000000000 +0100
@@ -2241,13 +2241,6 @@
 RISCOM8 DRIVER
 S:	Orphan
 
-RTLINUX  REALTIME  LINUX
-P:	Victor Yodaiken
-M:	yodaiken@fsmlabs.com
-L:	rtl@rtlinux.org
-W:	www.rtlinux.org
-S:	Maintained
-
 S3 SAVAGE FRAMEBUFFER DRIVER
 P:      Antonino Daplas
 M:      adaplas@pol.net

