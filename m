Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTEODYe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263773AbTEODWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:22:51 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:21996 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263809AbTEODSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:25 -0400
Date: Thu, 15 May 2003 04:31:13 +0100
Message-Id: <200305150331.h4F3VDcZ000703@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: typo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/init/Kconfig linux-2.5/init/Kconfig
--- bk-linus/init/Kconfig	2003-04-22 00:40:43.000000000 +0100
+++ linux-2.5/init/Kconfig	2003-04-22 17:33:51.000000000 +0100
@@ -142,7 +142,7 @@ config MODULE_FORCE_UNLOAD
 	  This option allows you to force a module to unload, even if the
 	  kernel believes it is unsafe: the kernel will remove the module
 	  without waiting for anyone to stop using it (using the -f option to
-	  rmmod).  This is mainly for kernel developers and desparate users.
+	  rmmod).  This is mainly for kernel developers and desperate users.
 	  If unsure, say N.
 
 config OBSOLETE_MODPARM
