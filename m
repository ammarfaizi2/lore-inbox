Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWF1Qzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWF1Qzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWF1Qze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:55:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43012 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751452AbWF1QzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:10 -0400
Date: Wed, 28 Jun 2006 18:55:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo fixes: indepedent -> independent
Message-ID: <20060628165510.GZ13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/ia64/Kconfig    |    2 +-
 arch/powerpc/Kconfig |    2 +-
 arch/ppc/Kconfig     |    2 +-
 arch/sh/Kconfig      |    2 +-
 arch/x86_64/Kconfig  |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.17-mm3-full/arch/ia64/Kconfig.old	2006-06-27 20:42:36.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/ia64/Kconfig	2006-06-27 20:43:13.000000000 +0200
@@ -438,7 +438,7 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
+	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
 	  The name comes from the similiarity to the exec system call.
--- linux-2.6.17-mm3-full/arch/powerpc/Kconfig.old	2006-06-27 20:43:19.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/powerpc/Kconfig	2006-06-27 20:43:22.000000000 +0200
@@ -628,7 +628,7 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
+	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
 	  The name comes from the similiarity to the exec system call.
--- linux-2.6.17-mm3-full/arch/ppc/Kconfig.old	2006-06-27 20:43:30.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/ppc/Kconfig	2006-06-27 20:43:33.000000000 +0200
@@ -219,7 +219,7 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
+	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
 	  The name comes from the similiarity to the exec system call.
--- linux-2.6.17-mm3-full/arch/sh/Kconfig.old	2006-06-27 20:43:44.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/sh/Kconfig	2006-06-27 20:43:47.000000000 +0200
@@ -465,7 +465,7 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.  And like a reboot
+	  but it is independent of the system firmware.  And like a reboot
 	  you can start any kernel with it, not just Linux.
 
 	  The name comes from the similiarity to the exec system call.
--- linux-2.6.17-mm3-full/arch/x86_64/Kconfig.old	2006-06-27 20:43:55.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/x86_64/Kconfig	2006-06-27 20:43:58.000000000 +0200
@@ -467,7 +467,7 @@
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
+	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
 	  The name comes from the similiarity to the exec system call.

