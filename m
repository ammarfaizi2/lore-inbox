Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbUJ1PHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbUJ1PHd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUJ1PBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:01:22 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:63367 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261691AbUJ1PAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:00:48 -0400
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041028150043.2776.92620.93420@localhost.localdomain>
In-Reply-To: <20041028150029.2776.69333.50087@localhost.localdomain>
References: <20041028150029.2776.69333.50087@localhost.localdomain>
Subject: [PATCH 3/9] to arch/sparc64/Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:00:43 -0500
Date: Thu, 28 Oct 2004 10:00:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Remove x86-specific help in arch/sparc64/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>

diff -u ./arch/sparc64/Kconfig.orig ./arch/sparc64/Kconfig
--- ./arch/sparc64/Kconfig.orig	2004-10-16 11:23:24.940665125 -0400
+++ ./arch/sparc64/Kconfig	2004-10-16 11:23:55.089644059 -0400
@@ -79,8 +79,8 @@
 	  terminal (/dev/tty0) will be used as system console. You can change
 	  that with a kernel command line option such as "console=tty3" which
 	  would use the third virtual terminal as system console. (Try "man
-	  bootparam" or see the documentation of your boot loader (lilo or
-	  loadlin) about how to pass options to the kernel at boot time.)
+	  bootparam" or see the documentation of your boot loader (silo)
+	  about how to pass options to the kernel at boot time.)
 
 	  If unsure, say Y.
 
