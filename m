Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbUJ1URf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbUJ1URf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUJ1UQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:16:14 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:41190 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262890AbUJ1UFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:05:54 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, james4765@verizon.net
Message-Id: <20041028200553.4340.23043.71399@localhost.localdomain>
In-Reply-To: <20041028200540.4340.4431.73847@localhost.localdomain>
References: <20041028200540.4340.4431.73847@localhost.localdomain>
Subject: [PATCH 2/3] to Documentation/00-INDEX.txt
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 15:05:53 -0500
Date: Thu, 28 Oct 2004 15:05:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Remove reference to to-be-deleted file in Documentation/00-INDEX.

Signed-off-by: <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/00-INDEX linux-2.6.9/Documentation/00-INDEX
--- linux-2.6.9-original/Documentation/00-INDEX	2004-10-18 17:53:43.000000000 -0400
+++ linux-2.6.9/Documentation/00-INDEX	2004-10-28 15:23:21.129340479 -0400
@@ -72,8 +72,6 @@
 	- some notes on debugging modules after Linux 2.6.3.
 devices.txt
 	- plain ASCII listing of all the nodes in /dev/ with major minor #'s.
-digiboard.txt
-	- info on the Digiboard PC/X{i,e,eve} multiport boards.
 digiepca.txt
 	- info on Digi Intl. {PC,PCI,EISA}Xx and Xem series cards.
 dnotify.txt
