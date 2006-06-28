Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWF1Q7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWF1Q7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWF1QzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:55:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43780 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751459AbWF1QzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:17 -0400
Date: Wed, 28 Jun 2006 18:55:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo fix: parititions -> partitions
Message-ID: <20060628165516.GC13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm3-full/Documentation/DocBook/mtdnand.tmpl.old	2006-06-27 20:45:29.000000000 +0200
+++ linux-2.6.17-mm3-full/Documentation/DocBook/mtdnand.tmpl	2006-06-27 20:45:49.000000000 +0200
@@ -189,7 +189,7 @@
 	<sect1>
 		<title>Partition defines</title>
 		<para>
-			If you want to divide your device into parititions, then
+			If you want to divide your device into partitions, then
 			enable the configuration switch CONFIG_MTD_PARITIONS and define
 			a paritioning scheme suitable to your board.
 		</para>

