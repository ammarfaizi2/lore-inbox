Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWF2SAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWF2SAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWF2SAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:00:06 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:65038 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751122AbWF2SAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:00:02 -0400
Date: Thu, 29 Jun 2006 13:59:47 -0400
From: Matt LaPlante <laplam@rpi.edu>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH] arch/arm26/Kconfig typos
Message-Id: <20060629135947.62fc0b9f.laplam@rpi.edu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 13:59:56 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 13:59:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three typos in arch/arm26/Kconfig...

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
laplam@rpi.edu

--

--- a/arch/arm26/Kconfig	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/arm26/Kconfig	2006-06-29 13:57:04.000000000 -0400
@@ -79,7 +79,7 @@
         bool "A5000"
 	select ARCH_MAY_HAVE_PC_FDC
         help
-          Say Y here to to support the Acorn A5000.
+          Say Y here to support the Acorn A5000.
 
 	  Linux can support the
           internal IDE disk and CD-ROM interface, serial and parallel port,
@@ -129,7 +129,7 @@
 config XIP_KERNEL
 	bool "Execute In Place (XIP) kernel image"
 	help
-	  Select this option to create a kernel that can be programed into
+	  Select this option to create a kernel that can be programmed into
 	  the OS ROMs.
 
 comment "At least one math emulation must be selected"
@@ -140,7 +140,7 @@
 	  Say Y to include the NWFPE floating point emulator in the kernel.
 	  This is necessary to run most binaries. Linux does not currently
 	  support floating point hardware so you need to say Y here even if
-	  your machine has an FPA or floating point co-processor podule.
+	  your machine has an FPA or floating point co-processor module.
 
 	  It is also possible to say M to build the emulator as a module
 	  (nwfpe) or indeed to leave it out altogether. However, unless you

