Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVKJRbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVKJRbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKJRbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:31:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:25020 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750954AbVKJRbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:31:04 -0500
Date: Thu, 10 Nov 2005 11:29:04 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update email address for Kumar
Message-ID: <Pine.LNX.4.44.0511101128310.18480-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changed jobs and the Freescale address is no longer valid.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 088e1877063f09813e0c5559190e50ae02b8ce82
tree 56debf9d3256cfdf8f3e13bd91c59b474c3fe4df
parent 3b44f137b9a846c5452d9e6e1271b79b1dbcc942
author Kumar Gala <galak@kernel.crashing.org> Thu, 10 Nov 2005 11:29:35 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 10 Nov 2005 11:29:35 -0600

 CREDITS                                      |    2 +-
 MAINTAINERS                                  |    2 +-
 arch/powerpc/kernel/head_fsl_booke.S         |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c              |    2 +-
 arch/powerpc/oprofile/op_model_fsl_booke.c   |    2 +-
 arch/ppc/kernel/head_fsl_booke.S             |    2 +-
 arch/ppc/mm/fsl_booke_mmu.c                  |    2 +-
 arch/ppc/platforms/83xx/mpc834x_sys.c        |    2 +-
 arch/ppc/platforms/83xx/mpc834x_sys.h        |    2 +-
 arch/ppc/platforms/85xx/mpc8540_ads.c        |    2 +-
 arch/ppc/platforms/85xx/mpc8540_ads.h        |    2 +-
 arch/ppc/platforms/85xx/mpc8555_cds.h        |    2 +-
 arch/ppc/platforms/85xx/mpc8560_ads.c        |    2 +-
 arch/ppc/platforms/85xx/mpc8560_ads.h        |    2 +-
 arch/ppc/platforms/85xx/mpc85xx_ads_common.c |    2 +-
 arch/ppc/platforms/85xx/mpc85xx_ads_common.h |    2 +-
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    2 +-
 arch/ppc/platforms/85xx/mpc85xx_cds_common.h |    2 +-
 arch/ppc/platforms/85xx/sbc8560.c            |    2 +-
 arch/ppc/platforms/pq2ads.c                  |    2 +-
 arch/ppc/syslib/ipic.h                       |    2 +-
 arch/ppc/syslib/mpc83xx_devices.c            |    2 +-
 arch/ppc/syslib/mpc83xx_sys.c                |    2 +-
 arch/ppc/syslib/mpc85xx_devices.c            |    2 +-
 arch/ppc/syslib/mpc85xx_sys.c                |    2 +-
 arch/ppc/syslib/mpc8xx_devices.c             |    2 +-
 arch/ppc/syslib/mpc8xx_sys.c                 |    2 +-
 arch/ppc/syslib/ppc83xx_setup.c              |    2 +-
 arch/ppc/syslib/ppc83xx_setup.h              |    2 +-
 arch/ppc/syslib/ppc85xx_common.c             |    2 +-
 arch/ppc/syslib/ppc85xx_common.h             |    2 +-
 arch/ppc/syslib/ppc85xx_setup.c              |    2 +-
 arch/ppc/syslib/ppc85xx_setup.h              |    2 +-
 arch/ppc/syslib/ppc_sys.c                    |    2 +-
 arch/ppc/syslib/pq2_devices.c                |    2 +-
 arch/ppc/syslib/pq2_sys.c                    |    2 +-
 drivers/char/watchdog/booke_wdt.c            |    2 +-
 drivers/net/gianfar.c                        |    2 +-
 drivers/net/gianfar.h                        |    2 +-
 drivers/net/gianfar_ethtool.c                |    2 +-
 drivers/net/gianfar_mii.c                    |    2 +-
 drivers/net/gianfar_mii.h                    |    2 +-
 drivers/serial/cpm_uart/cpm_uart_core.c      |    2 +-
 drivers/serial/cpm_uart/cpm_uart_cpm1.c      |    2 +-
 drivers/serial/cpm_uart/cpm_uart_cpm2.c      |    2 +-
 include/asm-ppc/immap_85xx.h                 |    2 +-
 include/asm-ppc/ipic.h                       |    2 +-
 include/asm-ppc/mpc83xx.h                    |    2 +-
 include/asm-ppc/mpc85xx.h                    |    2 +-
 include/asm-ppc/ppc_sys.h                    |    2 +-
 include/linux/fsl_devices.h                  |    2 +-
 51 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/CREDITS b/CREDITS
index 7fb4c73..192f749 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1097,7 +1097,7 @@ S: 80050-430 - Curitiba - Paraná
 S: Brazil
 
 N: Kumar Gala
-E: kumar.gala@freescale.com
+E: galak@kernel.crashing.org
 D: Embedded PowerPC 6xx/7xx/74xx/82xx/83xx/85xx support
 S: Austin, Texas 78729
 S: USA
diff --git a/MAINTAINERS b/MAINTAINERS
index 5541f99..87bd15f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1565,7 +1565,7 @@ S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
 P:     Kumar Gala
-M:     kumar.gala@freescale.com
+M:     galak@kernel.crashing.org
 W:     http://www.penguinppc.org/
 L:     linuxppc-embedded@ozlabs.org
 S:     Maintained
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 5063c60..8d60fa9 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -24,7 +24,7 @@
  *    Copyright 2002-2004 MontaVista Software, Inc.
  *      PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
  *    Copyright 2004 Freescale Semiconductor, Inc
- *      PowerPC e500 modifications, Kumar Gala <kumar.gala@freescale.com>
+ *      PowerPC e500 modifications, Kumar Gala <galak@kernel.crashing.org>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index af9ca0e..5d581bb 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -1,5 +1,5 @@
 /*
- * Modifications by Kumar Gala (kumar.gala@freescale.com) to support
+ * Modifications by Kumar Gala (galak@kernel.crashing.org) to support
  * E500 Book E processors.
  *
  * Copyright 2004 Freescale Semiconductor, Inc
diff --git a/arch/powerpc/oprofile/op_model_fsl_booke.c b/arch/powerpc/oprofile/op_model_fsl_booke.c
index 86124a9..26539cd 100644
--- a/arch/powerpc/oprofile/op_model_fsl_booke.c
+++ b/arch/powerpc/oprofile/op_model_fsl_booke.c
@@ -7,7 +7,7 @@
  * Copyright (c) 2004 Freescale Semiconductor, Inc
  *
  * Author: Andy Fleming
- * Maintainer: Kumar Gala <Kumar.Gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
index 5063c60..8d60fa9 100644
--- a/arch/ppc/kernel/head_fsl_booke.S
+++ b/arch/ppc/kernel/head_fsl_booke.S
@@ -24,7 +24,7 @@
  *    Copyright 2002-2004 MontaVista Software, Inc.
  *      PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
  *    Copyright 2004 Freescale Semiconductor, Inc
- *      PowerPC e500 modifications, Kumar Gala <kumar.gala@freescale.com>
+ *      PowerPC e500 modifications, Kumar Gala <galak@kernel.crashing.org>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/ppc/mm/fsl_booke_mmu.c b/arch/ppc/mm/fsl_booke_mmu.c
index af9ca0e..5d581bb 100644
--- a/arch/ppc/mm/fsl_booke_mmu.c
+++ b/arch/ppc/mm/fsl_booke_mmu.c
@@ -1,5 +1,5 @@
 /*
- * Modifications by Kumar Gala (kumar.gala@freescale.com) to support
+ * Modifications by Kumar Gala (galak@kernel.crashing.org) to support
  * E500 Book E processors.
  *
  * Copyright 2004 Freescale Semiconductor, Inc
diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
index 98edc75..84efc0c 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -3,7 +3,7 @@
  *
  * MPC834x SYS board specific routines
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h b/arch/ppc/platforms/83xx/mpc834x_sys.h
index 58e44c0..2e514d3 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.h
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.h
@@ -3,7 +3,7 @@
  *
  * MPC834X SYS common board definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor, Inc.
  *
diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
index 7e952c1..c5cde97 100644
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
@@ -3,7 +3,7 @@
  *
  * MPC8540ADS board specific routines
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.h b/arch/ppc/platforms/85xx/mpc8540_ads.h
index 3d05d7c..e48ca3a 100644
--- a/arch/ppc/platforms/85xx/mpc8540_ads.h
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.h
@@ -3,7 +3,7 @@
  *
  * MPC8540ADS board definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/platforms/85xx/mpc8555_cds.h b/arch/ppc/platforms/85xx/mpc8555_cds.h
index e0e7556..1a8e6c6 100644
--- a/arch/ppc/platforms/85xx/mpc8555_cds.h
+++ b/arch/ppc/platforms/85xx/mpc8555_cds.h
@@ -3,7 +3,7 @@
  *
  * MPC8555CDS board definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
index 208433f..8e39a55 100644
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -3,7 +3,7 @@
  *
  * MPC8560ADS board specific routines
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.h b/arch/ppc/platforms/85xx/mpc8560_ads.h
index 7df885d..143ae7e 100644
--- a/arch/ppc/platforms/85xx/mpc8560_ads.h
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.h
@@ -3,7 +3,7 @@
  *
  * MPC8540ADS board definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
index 16ad092..17ce48f 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
@@ -3,7 +3,7 @@
  *
  * MPC85xx ADS board common routines
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
index 84acf6e..7b26bcc 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
@@ -3,7 +3,7 @@
  *
  * MPC85XX ADS common board definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
index a211569..d8991b8 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -3,7 +3,7 @@
  *
  * MPC85xx CDS board specific routines
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor, Inc
  *
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.h b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h
index 12b292c..5b588cf 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.h
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h
@@ -3,7 +3,7 @@
  *
  * MPC85xx CDS board definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor, Inc
  *
diff --git a/arch/ppc/platforms/85xx/sbc8560.c b/arch/ppc/platforms/85xx/sbc8560.c
index b4ee170..45a5b81 100644
--- a/arch/ppc/platforms/85xx/sbc8560.c
+++ b/arch/ppc/platforms/85xx/sbc8560.c
@@ -3,7 +3,7 @@
  * 
  * Wind River SBC8560 board specific routines
  * 
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  * 
diff --git a/arch/ppc/platforms/pq2ads.c b/arch/ppc/platforms/pq2ads.c
index 6a1475c..71c9fca 100644
--- a/arch/ppc/platforms/pq2ads.c
+++ b/arch/ppc/platforms/pq2ads.c
@@ -3,7 +3,7 @@
  *
  * PQ2ADS platform support
  *
- * Author: Kumar Gala <kumar.gala@freescale.com>
+ * Author: Kumar Gala <galak@kernel.crashing.org>
  * Derived from: est8260_setup.c by Allen Curtis
  *
  * Copyright 2004 Freescale Semiconductor, Inc.
diff --git a/arch/ppc/syslib/ipic.h b/arch/ppc/syslib/ipic.h
index 2b56a4f..a7ce7da 100644
--- a/arch/ppc/syslib/ipic.h
+++ b/arch/ppc/syslib/ipic.h
@@ -3,7 +3,7 @@
  *
  * IPIC private definitions and structure.
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor, Inc
  *
diff --git a/arch/ppc/syslib/mpc83xx_devices.c b/arch/ppc/syslib/mpc83xx_devices.c
index f43fbf9..847df44 100644
--- a/arch/ppc/syslib/mpc83xx_devices.c
+++ b/arch/ppc/syslib/mpc83xx_devices.c
@@ -3,7 +3,7 @@
  *
  * MPC83xx Device descriptions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/mpc83xx_sys.c b/arch/ppc/syslib/mpc83xx_sys.c
index da74344..a152398 100644
--- a/arch/ppc/syslib/mpc83xx_sys.c
+++ b/arch/ppc/syslib/mpc83xx_sys.c
@@ -3,7 +3,7 @@
  *
  * MPC83xx System descriptions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/mpc85xx_devices.c b/arch/ppc/syslib/mpc85xx_devices.c
index 2ede677..69949d2 100644
--- a/arch/ppc/syslib/mpc85xx_devices.c
+++ b/arch/ppc/syslib/mpc85xx_devices.c
@@ -3,7 +3,7 @@
  *
  * MPC85xx Device descriptions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/mpc85xx_sys.c b/arch/ppc/syslib/mpc85xx_sys.c
index cb68d8c..397cfbc 100644
--- a/arch/ppc/syslib/mpc85xx_sys.c
+++ b/arch/ppc/syslib/mpc85xx_sys.c
@@ -3,7 +3,7 @@
  *
  * MPC85xx System descriptions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/mpc8xx_devices.c b/arch/ppc/syslib/mpc8xx_devices.c
index 2b5f0e7..92dc98b 100644
--- a/arch/ppc/syslib/mpc8xx_devices.c
+++ b/arch/ppc/syslib/mpc8xx_devices.c
@@ -3,7 +3,7 @@
  *
  * MPC8xx Device descriptions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 MontaVista Software, Inc. by Vitaly Bordug<vbordug@ru.mvista.com>
  *
diff --git a/arch/ppc/syslib/mpc8xx_sys.c b/arch/ppc/syslib/mpc8xx_sys.c
index 3cc27d2..d3c6175 100644
--- a/arch/ppc/syslib/mpc8xx_sys.c
+++ b/arch/ppc/syslib/mpc8xx_sys.c
@@ -3,7 +3,7 @@
  *
  * MPC8xx System descriptions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 MontaVista Software, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>
  *
diff --git a/arch/ppc/syslib/ppc83xx_setup.c b/arch/ppc/syslib/ppc83xx_setup.c
index 4da168a..1b5fe9e 100644
--- a/arch/ppc/syslib/ppc83xx_setup.c
+++ b/arch/ppc/syslib/ppc83xx_setup.c
@@ -3,7 +3,7 @@
  *
  * MPC83XX common board code
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/ppc83xx_setup.h b/arch/ppc/syslib/ppc83xx_setup.h
index c766c1a..a122a73 100644
--- a/arch/ppc/syslib/ppc83xx_setup.h
+++ b/arch/ppc/syslib/ppc83xx_setup.h
@@ -3,7 +3,7 @@
  *
  * MPC83XX common board definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/ppc85xx_common.c b/arch/ppc/syslib/ppc85xx_common.c
index da841da..19ad537 100644
--- a/arch/ppc/syslib/ppc85xx_common.c
+++ b/arch/ppc/syslib/ppc85xx_common.c
@@ -3,7 +3,7 @@
  *
  * MPC85xx support routines
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/ppc85xx_common.h b/arch/ppc/syslib/ppc85xx_common.h
index 2c8f304..94edf32 100644
--- a/arch/ppc/syslib/ppc85xx_common.h
+++ b/arch/ppc/syslib/ppc85xx_common.h
@@ -3,7 +3,7 @@
  *
  * MPC85xx support routines
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/ppc85xx_setup.c b/arch/ppc/syslib/ppc85xx_setup.c
index de2f905..1a47ff4 100644
--- a/arch/ppc/syslib/ppc85xx_setup.c
+++ b/arch/ppc/syslib/ppc85xx_setup.c
@@ -3,7 +3,7 @@
  *
  * MPC85XX common board code
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/ppc85xx_setup.h b/arch/ppc/syslib/ppc85xx_setup.h
index 6e6cfe1..e340b05 100644
--- a/arch/ppc/syslib/ppc85xx_setup.h
+++ b/arch/ppc/syslib/ppc85xx_setup.h
@@ -3,7 +3,7 @@
  *
  * MPC85XX common board definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
  *
diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
index 603f011..c0b93c4 100644
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -3,7 +3,7 @@
  *
  * PPC System library functions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
  * Copyright 2005 MontaVista, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>
diff --git a/arch/ppc/syslib/pq2_devices.c b/arch/ppc/syslib/pq2_devices.c
index e960fe9..6ff3aab 100644
--- a/arch/ppc/syslib/pq2_devices.c
+++ b/arch/ppc/syslib/pq2_devices.c
@@ -3,7 +3,7 @@
  *
  * PQ2 Device descriptions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
diff --git a/arch/ppc/syslib/pq2_sys.c b/arch/ppc/syslib/pq2_sys.c
index 7b6c9eb..36d6e21 100644
--- a/arch/ppc/syslib/pq2_sys.c
+++ b/arch/ppc/syslib/pq2_sys.c
@@ -3,7 +3,7 @@
  *
  * PQ2 System descriptions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index abc30cc..65830ec 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -4,7 +4,7 @@
  * Watchdog timer for PowerPC Book-E systems
  *
  * Author: Matthew McClintock
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
  *
diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 54d294a..0cdff81 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -6,7 +6,7 @@
  * Based on 8260_io/fcc_enet.c
  *
  * Author: Andy Fleming
- * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ * Maintainer: Kumar Gala
  *
  * Copyright (c) 2002-2004 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 220084e..5065ba8 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -6,7 +6,7 @@
  * Based on 8260_io/fcc_enet.c
  *
  * Author: Andy Fleming
- * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ * Maintainer: Kumar Gala
  *
  * Copyright (c) 2002-2004 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/net/gianfar_ethtool.c b/drivers/net/gianfar_ethtool.c
index 5a2d810..cfa3cd7 100644
--- a/drivers/net/gianfar_ethtool.c
+++ b/drivers/net/gianfar_ethtool.c
@@ -6,7 +6,7 @@
  *  Based on e1000 ethtool support
  *
  *  Author: Andy Fleming
- *  Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ *  Maintainer: Kumar Gala
  *
  *  Copyright (c) 2003,2004 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/net/gianfar_mii.c b/drivers/net/gianfar_mii.c
index 7263395..1d9e103 100644
--- a/drivers/net/gianfar_mii.c
+++ b/drivers/net/gianfar_mii.c
@@ -5,7 +5,7 @@
  * Provides Bus interface for MIIM regs
  *
  * Author: Andy Fleming
- * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ * Maintainer: Kumar Gala
  *
  * Copyright (c) 2002-2004 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/net/gianfar_mii.h b/drivers/net/gianfar_mii.h
index 56e5665..e85eb21 100644
--- a/drivers/net/gianfar_mii.h
+++ b/drivers/net/gianfar_mii.h
@@ -5,7 +5,7 @@
  * Driver for the MDIO bus controller in the Gianfar register space
  *
  * Author: Andy Fleming
- * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ * Maintainer: Kumar Gala
  *
  * Copyright (c) 2002-2004 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 25825f2..987d22b 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -7,7 +7,7 @@
  *  Based on ppc8xx.c by Thomas Gleixner
  *  Based on drivers/serial/amba.c by Russell King
  *
- *  Maintainer: Kumar Gala (kumar.gala@freescale.com) (CPM2)
+ *  Maintainer: Kumar Gala (galak@kernel.crashing.org) (CPM2)
  *              Pantelis Antoniou (panto@intracom.gr) (CPM1)
  *
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 4b0786e..d789ee5 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -3,7 +3,7 @@
  *
  *  Driver for CPM (SCC/SMC) serial ports; CPM1 definitions
  *
- *  Maintainer: Kumar Gala (kumar.gala@freescale.com) (CPM2)
+ *  Maintainer: Kumar Gala (galak@kernel.crashing.org) (CPM2)
  *              Pantelis Antoniou (panto@intracom.gr) (CPM1)
  *
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 15ad58d..fd9e53e 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -3,7 +3,7 @@
  *
  *  Driver for CPM (SCC/SMC) serial ports; CPM2 definitions
  *
- *  Maintainer: Kumar Gala (kumar.gala@freescale.com) (CPM2)
+ *  Maintainer: Kumar Gala (galak@kernel.crashing.org) (CPM2)
  *              Pantelis Antoniou (panto@intracom.gr) (CPM1)
  * 
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
diff --git a/include/asm-ppc/immap_85xx.h b/include/asm-ppc/immap_85xx.h
index 50fb5e4..9383d0c 100644
--- a/include/asm-ppc/immap_85xx.h
+++ b/include/asm-ppc/immap_85xx.h
@@ -3,7 +3,7 @@
  *
  * MPC85xx Internal Memory Map
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor, Inc
  *
diff --git a/include/asm-ppc/ipic.h b/include/asm-ppc/ipic.h
index 9092b92..0fe396a 100644
--- a/include/asm-ppc/ipic.h
+++ b/include/asm-ppc/ipic.h
@@ -3,7 +3,7 @@
  *
  * IPIC external definitions and structure.
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor, Inc
  *
diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
index ce21220..7cdf60f 100644
--- a/include/asm-ppc/mpc83xx.h
+++ b/include/asm-ppc/mpc83xx.h
@@ -3,7 +3,7 @@
  *
  * MPC83xx definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor, Inc
  *
diff --git a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
index d98db98..9d14bae 100644
--- a/include/asm-ppc/mpc85xx.h
+++ b/include/asm-ppc/mpc85xx.h
@@ -3,7 +3,7 @@
  *
  * MPC85xx definitions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor, Inc
  *
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
index bba5305..83d8c77 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -3,7 +3,7 @@
  *
  * PPC system definitions and library functions
  *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2005 Freescale Semiconductor, Inc
  *
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 114d5d5..934aa9b 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -4,7 +4,7 @@
  * Definitions for any platform device related flags or structures for
  * Freescale processor devices
  *
- * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
  *
  * Copyright 2004 Freescale Semiconductor, Inc
  *

