Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVAGWzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVAGWzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVAGWy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:54:59 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:53270 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261686AbVAGWux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:50:53 -0500
Date: Fri, 7 Jan 2005 23:50:48 +0100
Message-Id: <200501072250.j07MomZo012294@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 537] M68k: Update defconfigs for 2.6.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update defconfigs for 2.6.10

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10/arch/m68k/configs/amiga_defconfig	2004-12-26 11:04:51.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/amiga_defconfig	2004-12-26 11:22:54.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:25 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:22:54 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -734,6 +734,11 @@ CONFIG_DMASOUND=m
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 CONFIG_AMIGA_BUILTIN_SERIAL=y
--- linux-2.6.10/arch/m68k/configs/apollo_defconfig	2004-12-26 10:46:32.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/apollo_defconfig	2004-12-26 11:22:58.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:29 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:22:58 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -591,6 +591,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 CONFIG_DN_SERIAL=y
--- linux-2.6.10/arch/m68k/configs/atari_defconfig	2004-12-26 10:46:32.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/atari_defconfig	2004-12-26 11:23:11.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:34 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:23:11 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -644,6 +644,11 @@ CONFIG_DMASOUND=m
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 CONFIG_ATARI_MFPSER=m
--- linux-2.6.10/arch/m68k/configs/bvme6000_defconfig	2004-12-26 11:04:51.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/bvme6000_defconfig	2004-12-26 11:23:15.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:38 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:23:15 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -592,6 +592,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 CONFIG_BVME6000_SCC=y
--- linux-2.6.10/arch/m68k/configs/hp300_defconfig	2004-12-26 10:46:32.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/hp300_defconfig	2004-12-26 11:23:40.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:44 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:23:40 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -592,6 +592,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 
--- linux-2.6.10/arch/m68k/configs/mac_defconfig	2004-12-26 10:46:32.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/mac_defconfig	2004-12-26 11:23:44.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:47 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:23:44 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -653,6 +653,11 @@ CONFIG_LOGO_MAC_CLUT224=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 CONFIG_MAC_SCC=y
--- linux-2.6.10/arch/m68k/configs/mvme147_defconfig	2004-12-26 10:46:32.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/mvme147_defconfig	2004-12-26 11:23:49.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:49 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:23:49 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -607,6 +607,11 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 CONFIG_MVME147_SCC=y
--- linux-2.6.10/arch/m68k/configs/mvme16x_defconfig	2004-12-26 11:04:51.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/mvme16x_defconfig	2004-12-26 11:23:53.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:52 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:23:53 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -608,6 +608,11 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 CONFIG_MVME162_SCC=y
--- linux-2.6.10/arch/m68k/configs/q40_defconfig	2004-12-26 10:46:32.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/q40_defconfig	2004-12-26 11:23:57.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:55 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:23:57 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -683,6 +683,11 @@ CONFIG_DMASOUND=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 
--- linux-2.6.10/arch/m68k/configs/sun3_defconfig	2004-12-26 10:46:32.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/sun3_defconfig	2004-12-26 11:24:01.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:58 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:24:01 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -596,6 +596,11 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 
--- linux-2.6.10/arch/m68k/configs/sun3x_defconfig	2004-12-26 10:46:32.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/configs/sun3x_defconfig	2004-12-26 11:24:05.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:22:01 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:24:05 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -606,6 +606,11 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 
--- linux-2.6.10/arch/m68k/defconfig	2004-12-26 11:04:51.000000000 +0100
+++ linux-m68k-2.6.10/arch/m68k/defconfig	2004-12-26 11:23:36.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc3-m68k
-# Sun Dec  5 14:21:41 2004
+# Linux kernel version: 2.6.10-m68k
+# Sun Dec 26 11:23:36 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -464,6 +464,11 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
 # Character devices
 #
 CONFIG_AMIGA_BUILTIN_SERIAL=y

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
