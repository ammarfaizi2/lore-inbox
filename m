Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVCZBY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVCZBY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 20:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVCZBY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 20:24:27 -0500
Received: from mail.dif.dk ([193.138.115.101]:48072 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261905AbVCZBYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 20:24:24 -0500
Date: Sat, 26 Mar 2005 02:26:22 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][trivial] fix tiny spelling error in init/Kconfig
Message-ID: <Pine.LNX.4.62.0503260225170.2463@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix spelling in init/Kconfig

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/init/Kconfig	2005-03-25 15:29:08.000000000 +0100
+++ linux-2.6.12-rc1-mm3/init/Kconfig	2005-03-26 02:24:33.000000000 +0100
@@ -83,7 +83,7 @@
 	default y
 	help
 	  This option allows you to choose whether you want to have support
-	  for socalled swap devices or swap files in your kernel that are
+	  for so called swap devices or swap files in your kernel that are
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 

