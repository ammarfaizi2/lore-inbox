Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbVDLUOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVDLUOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVDLUNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:13:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:27592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbVDLKbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:32 -0400
Message-Id: <200504121030.j3CAUgLq005127@shell0.pdx.osdl.net>
Subject: [patch 004/198] arm: fix help text for ixdp465
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rmk@arm.linux.org.uk
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Russell King <rmk+lkml@arm.linux.org.uk>

For some reason, this help text was missed when the file was last audited
by the documentation referencing folk.  Fix this incorrect documentation
reference.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/arm/mach-ixp4xx/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/arm/mach-ixp4xx/Kconfig~arm-fix-help-text-for-ixdp465 arch/arm/mach-ixp4xx/Kconfig
--- 25/arch/arm/mach-ixp4xx/Kconfig~arm-fix-help-text-for-ixdp465	2005-04-12 03:21:04.547445584 -0700
+++ 25-akpm/arch/arm/mach-ixp4xx/Kconfig	2005-04-12 03:21:04.550445128 -0700
@@ -41,7 +41,7 @@ config MACH_IXDP465
 	help
 	  Say 'Y' here if you want your kernel to support Intel's
 	  IXDP465 Development Platform (Also known as BMP).
-	  For more information on this platform, see Documentation/arm/IXP4xx.
+	  For more information on this platform, see <file:Documentation/arm/IXP4xx>.
 
 
 #
_
