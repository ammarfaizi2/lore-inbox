Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVCVXZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVCVXZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVCVXZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:25:05 -0500
Received: from mail.dif.dk ([193.138.115.101]:17092 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262394AbVCVXYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:24:47 -0500
Date: Wed, 23 Mar 2005 00:26:36 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: [Trivial PATCH] Spelling fix in init/Kconfig for the help of
 CONFIG_SWAP
Message-ID: <Pine.LNX.4.62.0503230022400.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial spelling fix s/socalled/so called/ 


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm1-orig/init/Kconfig	2005-03-21 23:12:43.000000000 +0100
+++ linux-2.6.12-rc1-mm1/init/Kconfig	2005-03-23 00:21:54.000000000 +0100
@@ -75,7 +75,7 @@
 	default y
 	help
 	  This option allows you to choose whether you want to have support
-	  for socalled swap devices or swap files in your kernel that are
+	  for so called swap devices or swap files in your kernel that are
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 


