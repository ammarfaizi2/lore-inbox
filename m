Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263129AbTCSTlD>; Wed, 19 Mar 2003 14:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbTCSTlD>; Wed, 19 Mar 2003 14:41:03 -0500
Received: from maestro.symsys.com ([208.223.9.37]:50699 "EHLO
	maestro.symsys.com") by vger.kernel.org with ESMTP
	id <S263129AbTCSTlC>; Wed, 19 Mar 2003 14:41:02 -0500
Date: Wed, 19 Mar 2003 13:52:01 -0600 (CST)
From: Greg Ingram <ingram@symsys.com>
To: linux-kernel@vger.kernel.org
Subject: init/Kconfig typo
Message-ID: <Pine.LNX.4.44.0303191334110.24482-100000@maestro.symsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unless it's valid non-U.S. English, there's a misspelling in the help for
the force-module-unload config option: "deparate" should be "desperate".

Regards,

- Greg

--- init/Kconfig-orig	2003-03-19 13:41:48.000000000 -0600
+++ init/Kconfig	2003-03-19 13:42:06.000000000 -0600
@@ -142,7 +142,7 @@
 	  This option allows you to force a module to unload, even if the
 	  kernel believes it is unsafe: the kernel will remove the module
 	  without waiting for anyone to stop using it (using the -f option to
-	  rmmod).  This is mainly for kernel developers and desparate users.
+	  rmmod).  This is mainly for kernel developers and desperate users.
 	  If unsure, say N.

 config OBSOLETE_MODPARM

