Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbUKNCAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUKNCAg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 21:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUKNCAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 21:00:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3082 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261235AbUKNCAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 21:00:31 -0500
Date: Sun, 14 Nov 2004 02:59:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove obsolete Computone MAINTAINERS entry
Message-ID: <20041114015958.GI2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure whether it makes sense to list the previous maintainers for 
orphaned code, but if such entries contain buouncing mail addresses it's 
IMHO time to simply remove them.



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/MAINTAINERS.old	2004-11-14 02:57:45.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/MAINTAINERS	2004-11-14 02:57:55.000000000 +0100
@@ -528,13 +528,6 @@
 L:	pcihpd-discuss@lists.sourceforge.net
 S:	Supported
 
-COMPUTONE INTELLIPORT MULTIPORT CARD
-P:	Michael H. Warfield
-M:	Michael H. Warfield <mhw@wittsend.com>
-W:	http://www.wittsend.com/computone.html
-L:	linux-computone@lazuli.wittsend.com
-S:	Orphaned
-
 COSA/SRP SYNC SERIAL DRIVER
 P:	Jan "Yenya" Kasprzak
 M:	kas@fi.muni.cz
