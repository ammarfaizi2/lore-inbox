Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbUJ1PrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUJ1PrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUJ1Pop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:44:45 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:1949 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261739AbUJ1Pjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:39:33 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rusty@rustcorp.com.au, james4765@verizon.net
Message-Id: <20041028153928.3882.66291.42285@localhost.localdomain>
Subject: [PATCH] to Documentation/00-INDEX
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:39:28 -0500
Date: Thu, 28 Oct 2004 10:39:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot this one in the previous patches - relies upon the removal of mkdev.ida.

Description: Removes reference to to-be-deleted file in 00-INDEX.

Apply against 2.6.9.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/00-INDEX linux-2.6.9/Documentation/00-INDEX
--- linux-2.6.9-original/Documentation/00-INDEX	2004-10-18 17:53:43.000000000 -0400
+++ linux-2.6.9/Documentation/00-INDEX	2004-10-28 11:29:57.950387706 -0400
@@ -158,8 +158,6 @@
 	- directory with info about Linux on MIPS architecture.
 mkdev.cciss
 	- script to make /dev entries for SMART controllers (see cciss.txt).
-mkdev.ida
-	- script to make /dev entries for Intelligent Disk Array Controllers.
 moxa-smartio
 	- info on installing/using Moxa multiport serial driver.
 mtrr.txt
