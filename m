Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265873AbUAHSmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUAHSmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:42:49 -0500
Received: from bender.bawue.de ([193.7.176.20]:39881 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S265873AbUAHSlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:41:16 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.1-rc3] Canonically reference files in Documentation/,
 code comments part
From: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Date: Thu, 08 Jan 2004 19:31:29 +0100
Message-ID: <86ad4y70n2.fsf@n-dimensional.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/01/07 12:45:49+01:00 kdim@n-dimensional.de 
#   Canonically reference files in Documentation/.
#   This changes all references to Documentation/ in code comments.
# 
# sound/oss/vwsnd.c
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# sound/oss/via82cxxx_audio.c
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# scripts/MAKEDEV.snd
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# scripts/MAKEDEV.ide
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# mm/swap.c
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# include/scsi/sg.h
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# include/asm-arm26/setup.h
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# include/asm-arm26/io.h
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# include/asm-arm/setup.h
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# include/asm-arm/io.h
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# include/asm-arm/cacheflush.h
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# fs/locks.c
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# fs/hfs/FAQ.txt
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/usb/misc/tiglusb.c
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/usb/media/ov511.c
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/scsi/tmscsim.c
#   2004/01/07 12:45:39+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/scsi/aha152x.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/pcmcia/sa11xx_core.h
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/pcmcia/sa11xx_core.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/pcmcia/sa1100_generic.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/net/wan/Kconfig
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/net/tlan.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/net/hamradio/scc.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/media/dvb/ttusb-dec/Kconfig
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/i4l/isdn_x25iface.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +2 -2
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/tei.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/md5sums.asc
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/l3dss1.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/l3_1tr6.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/isdnl3.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/isdnl2.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/isdnl1.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/isac.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/hfc_pci.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/elsa.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/diva.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/config.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/cert.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/isdn/hisax/callc.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/ieee1394/dv1394.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/cpufreq/Kconfig
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +3 -3
#   Canonically reference files in Documentation/
# 
# drivers/char/specialix.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/char/README.scc
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/cdrom/sbpcd.h
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/cdrom/sbpcd.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/cdrom/optcd.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/cdrom/aztcd.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/block/floppy98.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# drivers/block/floppy.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# arch/x86_64/kernel/cpufreq/Kconfig
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +2 -2
#   Canonically reference files in Documentation/
# 
# arch/sparc64/Kconfig
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +3 -3
#   Canonically reference files in Documentation/
# 
# arch/ppc/Kconfig
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# arch/i386/kernel/cpu/cpufreq/Kconfig
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +13 -13
#   Canonically reference files in Documentation/
# 
# arch/arm/Kconfig
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# arch/alpha/kernel/srm_env.c
#   2004/01/07 12:45:38+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
diff -Nru a/arch/alpha/kernel/srm_env.c b/arch/alpha/kernel/srm_env.c
--- a/arch/alpha/kernel/srm_env.c	Thu Jan  8 18:48:58 2004
+++ b/arch/alpha/kernel/srm_env.c	Thu Jan  8 18:48:58 2004
@@ -5,7 +5,7 @@
  * Copyright (C) 2001-2002 Jan-Benedict Glaw <jbglaw@lug-owl.de>
  *
  * This driver is at all a modified version of Erik Mouw's
- * ./linux/Documentation/DocBook/procfs_example.c, so: thank
+ * Documentation/DocBook/procfs_example.c, so: thank
  * you, Erik! He can be reached via email at
  * <J.A.K.Mouw@its.tudelft.nl>. It is based on an idea
  * provided by DEC^WCompaq^WIntel's "Jumpstart" CD. They
diff -Nru a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig	Thu Jan  8 18:48:58 2004
+++ b/arch/arm/Kconfig	Thu Jan  8 18:48:58 2004
@@ -353,7 +353,7 @@
 	help
 	  This enables the CPUfreq driver for ARM Integrator CPUs.
 
-	  For details, take a look at linux/Documentation/cpufreq.
+	  For details, take a look at Documentation/cpu-freq.
 
 	  If in doubt, say Y.
 
diff -Nru a/arch/i386/kernel/cpu/cpufreq/Kconfig b/arch/i386/kernel/cpu/cpufreq/Kconfig
--- a/arch/i386/kernel/cpu/cpufreq/Kconfig	Thu Jan  8 18:48:58 2004
+++ b/arch/i386/kernel/cpu/cpufreq/Kconfig	Thu Jan  8 18:48:58 2004
@@ -11,7 +11,7 @@
 	  fly. This is a nice method to save battery power on notebooks,
 	  because the lower the clock speed, the less power the CPU consumes.
 
-	  For more information, take a look at linux/Documentation/cpu-freq or
+	  For more information, take a look at Documentation/cpu-freq or
 	  at <http://www.codemonkey.org.uk/projects/cpufreq/>
 
 	  If in doubt, say N.
@@ -38,7 +38,7 @@
 	  This driver adds a CPUFreq driver which utilizes the ACPI
 	  Processor Performance States.
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -63,7 +63,7 @@
 	  parameter: elanfreq=maxspeed (in kHz) or as module
 	  parameter "max_freq".
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -74,7 +74,7 @@
 	  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
 	  AMD K6-3+ processors.
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -84,7 +84,7 @@
 	help
 	  This adds the CPUFreq driver for mobile AMD K7 mobile processors.
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -94,7 +94,7 @@
 	help
 	  This adds the CPUFreq driver for mobile AMD Opteron/Athlon64 processors.
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -105,7 +105,7 @@
 	 This add the CPUFreq driver for NatSemi Geode processors which
 	 support suspend modulation.
 
-	 For details, take a look at linux/Documentation/cpu-freq.
+	 For details, take a look at Documentation/cpu-freq.
 
 	 If in doubt, say N.
 
@@ -116,7 +116,7 @@
 	  This adds the CPUFreq driver for Enhanced SpeedStep enabled
 	  mobile CPUs.  This means Intel Pentium M (Centrino) CPUs.
 	  
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 	  
 	  If in doubt, say N.
 
@@ -129,7 +129,7 @@
 	  mobile Intel Pentium 4 P4-M on systems which have an Intel ICH2, 
 	  ICH3 or ICH4 southbridge.
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -141,7 +141,7 @@
 	  (Coppermine), all mobile Intel Pentium III-M (Tualatin)  
 	  on systems which have an Intel 440BX/ZX/MX southbridge.
 
-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at Documentation/cpu-freq.
 
 	  If in doubt, say N.
 
@@ -157,7 +157,7 @@
 	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
 	  processors.
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -168,7 +168,7 @@
 	  This adds the CPUFreq driver for Transmeta Crusoe processors which
 	  support LongRun.
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -180,7 +180,7 @@
 	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 
 	  processors.
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Thu Jan  8 18:48:58 2004
+++ b/arch/ppc/Kconfig	Thu Jan  8 18:48:58 2004
@@ -159,7 +159,7 @@
 	  fly. This is a nice method to save battery power on notebooks,
 	  because the lower the clock speed, the less power the CPU consumes.
 
-	  For more information, take a look at linux/Documentation/cpufreq or
+	  For more information, take a look at Documentation/cpu-freq or
 	  at <http://www.brodo.de/cpufreq/>
 
 	  If in doubt, say N.
diff -Nru a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	Thu Jan  8 18:48:58 2004
+++ b/arch/sparc64/Kconfig	Thu Jan  8 18:48:58 2004
@@ -138,7 +138,7 @@
 	  fly.  Currently there are only sparc64 drivers for UltraSPARC-III
 	  and UltraSPARC-IIe processors.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -158,7 +158,7 @@
 	help
 	  This adds the CPUFreq driver for UltraSPARC-III processors.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
@@ -168,7 +168,7 @@
 	help
 	  This adds the CPUFreq driver for UltraSPARC-IIe processors.
 
-	  For details, take a look at linux/Documentation/cpufreq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
diff -Nru a/arch/x86_64/kernel/cpufreq/Kconfig b/arch/x86_64/kernel/cpufreq/Kconfig
--- a/arch/x86_64/kernel/cpufreq/Kconfig	Thu Jan  8 18:48:58 2004
+++ b/arch/x86_64/kernel/cpufreq/Kconfig	Thu Jan  8 18:48:58 2004
@@ -11,7 +11,7 @@
 	  fly. This is a nice method to save battery power on notebooks,
 	  because the lower the clock speed, the less power the CPU consumes.
 
-	  For more information, take a look at linux/Documentation/cpu-freq or
+	  For more information, take a look at Documentation/cpu-freq or
 	  at <http://www.brodo.de/cpufreq/>
 
 	  If in doubt, say N.
@@ -37,7 +37,7 @@
 	help
 	  This adds the CPUFreq driver for mobile AMD Opteron/Athlon64 processors.
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
 
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/block/floppy.c	Thu Jan  8 18:48:58 2004
@@ -4200,7 +4200,7 @@
 		printk("\n");
 	} else
 		DPRINT("botched floppy option\n");
-	DPRINT("Read linux/Documentation/floppy.txt\n");
+	DPRINT("Read Documentation/floppy.txt\n");
 	return 0;
 }
 
diff -Nru a/drivers/block/floppy98.c b/drivers/block/floppy98.c
--- a/drivers/block/floppy98.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/block/floppy98.c	Thu Jan  8 18:48:58 2004
@@ -4226,7 +4226,7 @@
 		printk("\n");
 	} else
 		DPRINT("botched floppy option\n");
-	DPRINT("Read linux/Documentation/floppy.txt\n");
+	DPRINT("Read Documentation/floppy.txt\n");
 	return 0;
 }
 
diff -Nru a/drivers/cdrom/aztcd.c b/drivers/cdrom/aztcd.c
--- a/drivers/cdrom/aztcd.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/cdrom/aztcd.c	Thu Jan  8 18:48:58 2004
@@ -129,7 +129,7 @@
                 Werner Zimmermann, August 8, 1995
         V1.70   Multisession support now is completed, but there is still not 
                 enough testing done. If you can test it, please contact me. For
-                details please read /usr/src/linux/Documentation/cdrom/aztcd
+                details please read Documentation/cdrom/aztcd
                 Werner Zimmermann, August 19, 1995
         V1.80   Modification to suit the new kernel boot procedure introduced
                 with kernel 1.3.33. Will definitely not work with older kernels.
diff -Nru a/drivers/cdrom/optcd.c b/drivers/cdrom/optcd.c
--- a/drivers/cdrom/optcd.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/cdrom/optcd.c	Thu Jan  8 18:48:58 2004
@@ -964,7 +964,7 @@
 #endif /* MULTISESSION */
 	if (disk_info.multi)
 		printk(KERN_WARNING "optcd: Multisession support experimental, "
-			"see linux/Documentation/cdrom/optcd\n");
+			"see Documentation/cdrom/optcd\n");
 
 	DEBUG((DEBUG_TOC, "exiting update_toc"));
 
diff -Nru a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/cdrom/sbpcd.c	Thu Jan  8 18:48:58 2004
@@ -5715,7 +5715,7 @@
 	
 	if (port_index>0)
           {
-            msg(DBG_INF, "You should read linux/Documentation/cdrom/sbpcd\n");
+            msg(DBG_INF, "You should read Documentation/cdrom/sbpcd\n");
             msg(DBG_INF, "and then configure sbpcd.h for your hardware.\n");
           }
 	check_datarate();
diff -Nru a/drivers/cdrom/sbpcd.h b/drivers/cdrom/sbpcd.h
--- a/drivers/cdrom/sbpcd.h	Thu Jan  8 18:48:58 2004
+++ b/drivers/cdrom/sbpcd.h	Thu Jan  8 18:48:58 2004
@@ -5,7 +5,7 @@
 /*
  * Attention! This file contains user-serviceable parts!
  * I recommend to make use of it...
- * If you feel helpless, look into linux/Documentation/cdrom/sbpcd
+ * If you feel helpless, look into Documentation/cdrom/sbpcd
  * (good idea anyway, at least before mailing me).
  *
  * The definitions for the first controller can get overridden by
diff -Nru a/drivers/char/README.scc b/drivers/char/README.scc
--- a/drivers/char/README.scc	Thu Jan  8 18:48:58 2004
+++ b/drivers/char/README.scc	Thu Jan  8 18:48:58 2004
@@ -2,4 +2,4 @@
 	../net/scc.c
 
 A subset of the documentation is in
-	../../Documentation/networking/z8530drv.txt
+	Documentation/networking/z8530drv.txt
diff -Nru a/drivers/char/specialix.c b/drivers/char/specialix.c
--- a/drivers/char/specialix.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/char/specialix.c	Thu Jan  8 18:48:58 2004
@@ -72,7 +72,7 @@
 /*
  * There is a bunch of documentation about the card, jumpers, config
  * settings, restrictions, cables, device names and numbers in
- * ../../Documentation/specialix.txt 
+ * Documentation/specialix.txt 
  */
 
 #include <linux/config.h>
diff -Nru a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
--- a/drivers/cpufreq/Kconfig	Thu Jan  8 18:48:58 2004
+++ b/drivers/cpufreq/Kconfig	Thu Jan  8 18:48:58 2004
@@ -6,7 +6,7 @@
 	  CPUFreq. Please note that it is recommended to use the sysfs
 	  interface instead (which is built automatically). 
 	  
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 	  
 	  If in doubt, say N.
 
@@ -64,7 +64,7 @@
           be able to set the CPU dynamically, like on LART 
 	  <http://www.lart.tudelft.nl/>
 
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say Y.
 
@@ -78,6 +78,6 @@
 	  the same functionality as long as "userspace" is the
 	  selected governor for the specified CPU.
 	
-	  For details, take a look at linux/Documentation/cpu-freq. 
+	  For details, take a look at Documentation/cpu-freq. 
 
 	  If in doubt, say N.
diff -Nru a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
--- a/drivers/ieee1394/dv1394.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/ieee1394/dv1394.c	Thu Jan  8 18:48:58 2004
@@ -1322,7 +1322,7 @@
 static int dv1394_fasync(int fd, struct file *file, int on)
 {
 	/* I just copied this code verbatim from Alan Cox's mouse driver example
-	   (linux/Documentation/DocBook/) */
+	   (Documentation/DocBook/) */
 	
 	struct video_card *video = file_to_video_card(file);
 	
diff -Nru a/drivers/isdn/hisax/callc.c b/drivers/isdn/hisax/callc.c
--- a/drivers/isdn/hisax/callc.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/callc.c	Thu Jan  8 18:48:58 2004
@@ -7,7 +7,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * based on the teles driver from Jan den Ouden
  *
diff -Nru a/drivers/isdn/hisax/cert.c b/drivers/isdn/hisax/cert.c
--- a/drivers/isdn/hisax/cert.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/cert.c	Thu Jan  8 18:48:58 2004
@@ -7,7 +7,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  */
  
diff -Nru a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
--- a/drivers/isdn/hisax/config.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/config.c	Thu Jan  8 18:48:58 2004
@@ -8,7 +8,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * based on the teles driver from Jan den Ouden
  *
diff -Nru a/drivers/isdn/hisax/diva.c b/drivers/isdn/hisax/diva.c
--- a/drivers/isdn/hisax/diva.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/diva.c	Thu Jan  8 18:48:58 2004
@@ -9,7 +9,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to Eicon Technology for documents and information
  *
diff -Nru a/drivers/isdn/hisax/elsa.c b/drivers/isdn/hisax/elsa.c
--- a/drivers/isdn/hisax/elsa.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/elsa.c	Thu Jan  8 18:48:58 2004
@@ -9,7 +9,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Elsa GmbH for documents and information
  *
diff -Nru a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
--- a/drivers/isdn/hisax/hfc_pci.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/hfc_pci.c	Thu Jan  8 18:48:58 2004
@@ -11,7 +11,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  */
 
diff -Nru a/drivers/isdn/hisax/isac.c b/drivers/isdn/hisax/isac.c
--- a/drivers/isdn/hisax/isac.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/isac.c	Thu Jan  8 18:48:58 2004
@@ -9,7 +9,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  */
 
diff -Nru a/drivers/isdn/hisax/isdnl1.c b/drivers/isdn/hisax/isdnl1.c
--- a/drivers/isdn/hisax/isdnl1.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/isdnl1.c	Thu Jan  8 18:48:58 2004
@@ -10,7 +10,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -Nru a/drivers/isdn/hisax/isdnl2.c b/drivers/isdn/hisax/isdnl2.c
--- a/drivers/isdn/hisax/isdnl2.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/isdnl2.c	Thu Jan  8 18:48:58 2004
@@ -8,7 +8,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -Nru a/drivers/isdn/hisax/isdnl3.c b/drivers/isdn/hisax/isdnl3.c
--- a/drivers/isdn/hisax/isdnl3.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/isdnl3.c	Thu Jan  8 18:48:58 2004
@@ -8,7 +8,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -Nru a/drivers/isdn/hisax/l3_1tr6.c b/drivers/isdn/hisax/l3_1tr6.c
--- a/drivers/isdn/hisax/l3_1tr6.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/l3_1tr6.c	Thu Jan  8 18:48:58 2004
@@ -9,7 +9,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  */
 
diff -Nru a/drivers/isdn/hisax/l3dss1.c b/drivers/isdn/hisax/l3dss1.c
--- a/drivers/isdn/hisax/l3dss1.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/l3dss1.c	Thu Jan  8 18:48:58 2004
@@ -12,7 +12,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -Nru a/drivers/isdn/hisax/md5sums.asc b/drivers/isdn/hisax/md5sums.asc
--- a/drivers/isdn/hisax/md5sums.asc	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/md5sums.asc	Thu Jan  8 18:48:58 2004
@@ -4,7 +4,7 @@
 # Eicon Technology Diva 2.01 PCI, Sedlbauer SpeedFax+, 
 # HFC-S PCI A based cards and HFC-S USB based isdn tas 
 # in the moment.
-# Read ../../../Documentation/isdn/HiSax.cert for more informations.
+# Read Documentation/isdn/HiSax.cert for more informations.
 # 
 d08b59f56fb9ed1fbd17713342c75081  isac.c
 e81e6e96f307e55f8b9777aca2b356d9  isdnl1.c
diff -Nru a/drivers/isdn/hisax/tei.c b/drivers/isdn/hisax/tei.c
--- a/drivers/isdn/hisax/tei.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/hisax/tei.c	Thu Jan  8 18:48:58 2004
@@ -8,7 +8,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -Nru a/drivers/isdn/i4l/isdn_x25iface.c b/drivers/isdn/i4l/isdn_x25iface.c
--- a/drivers/isdn/i4l/isdn_x25iface.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/isdn/i4l/isdn_x25iface.c	Thu Jan  8 18:48:58 2004
@@ -8,7 +8,7 @@
  * stuff needed to support the Linux X.25 PLP code on top of devices that
  * can provide a lab_b service using the concap_proto mechanism.
  * This module supports a network interface wich provides lapb_sematics
- * -- as defined in ../../Documentation/networking/x25-iface.txt -- to
+ * -- as defined in Documentation/networking/x25-iface.txt -- to
  * the upper layer and assumes that the lower layer provides a reliable
  * data link service by means of the concap_device_ops callbacks.
  *
@@ -275,7 +275,7 @@
 }
 
 /* process a frame handed over to us from linux network layer. First byte
-   semantics as defined in ../../Documentation/networking/x25-iface.txt 
+   semantics as defined in Documentation/networking/x25-iface.txt 
    */
 int isdn_x25iface_xmit(struct concap_proto *cprot, struct sk_buff *skb)
 {
diff -Nru a/drivers/media/dvb/ttusb-dec/Kconfig b/drivers/media/dvb/ttusb-dec/Kconfig
--- a/drivers/media/dvb/ttusb-dec/Kconfig	Thu Jan  8 18:48:58 2004
+++ b/drivers/media/dvb/ttusb-dec/Kconfig	Thu Jan  8 18:48:58 2004
@@ -13,6 +13,6 @@
 
 	  The DEC devices require firmware in order to boot into a mode in
 	  which they are slaves to the PC.  See
-	  linux/Documentation/dvb/ttusb-dec.txt for details.
+	  Documentation/dvb/ttusb-dec.txt for details.
 
 	  Say Y if you own such a device and want to use it.
diff -Nru a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
--- a/drivers/net/hamradio/scc.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/net/hamradio/scc.c	Thu Jan  8 18:48:58 2004
@@ -7,7 +7,7 @@
  *            ------------------
  *
  * You can find a subset of the documentation in 
- * linux/Documentation/networking/z8530drv.txt.
+ * Documentation/networking/z8530drv.txt.
  */
 
 /*
diff -Nru a/drivers/net/tlan.c b/drivers/net/tlan.c
--- a/drivers/net/tlan.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/net/tlan.c	Thu Jan  8 18:48:58 2004
@@ -212,7 +212,7 @@
 /* Define this to enable Link beat monitoring */
 #undef MONITOR
 
-/* Turn on debugging. See linux/Documentation/networking/tlan.txt for details */
+/* Turn on debugging. See Documentation/networking/tlan.txt for details */
 static  int		debug;
 
 static	int		bbuf;
diff -Nru a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
--- a/drivers/net/wan/Kconfig	Thu Jan  8 18:48:58 2004
+++ b/drivers/net/wan/Kconfig	Thu Jan  8 18:48:58 2004
@@ -126,7 +126,7 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called comx-hw-munich.
 
-	  Read linux/Documentation/networking/slicecom.txt for help on
+	  Read Documentation/networking/slicecom.txt for help on
 	  configuring and using SliceCOM interfaces. Further info on these cards
 	  can be found at http://www.itc.hu or <info@itc.hu>.
 
diff -Nru a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
--- a/drivers/pcmcia/sa1100_generic.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/pcmcia/sa1100_generic.c	Thu Jan  8 18:48:58 2004
@@ -30,7 +30,7 @@
     
 ======================================================================*/
 /*
- * Please see linux/Documentation/arm/SA1100/PCMCIA for more information
+ * Please see Documentation/arm/SA1100/PCMCIA for more information
  * on the low-level kernel interface.
  */
 
diff -Nru a/drivers/pcmcia/sa11xx_core.c b/drivers/pcmcia/sa11xx_core.c
--- a/drivers/pcmcia/sa11xx_core.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/pcmcia/sa11xx_core.c	Thu Jan  8 18:48:58 2004
@@ -30,7 +30,7 @@
     
 ======================================================================*/
 /*
- * Please see linux/Documentation/arm/SA1100/PCMCIA for more information
+ * Please see Documentation/arm/SA1100/PCMCIA for more information
  * on the low-level kernel interface.
  */
 
diff -Nru a/drivers/pcmcia/sa11xx_core.h b/drivers/pcmcia/sa11xx_core.h
--- a/drivers/pcmcia/sa11xx_core.h	Thu Jan  8 18:48:58 2004
+++ b/drivers/pcmcia/sa11xx_core.h	Thu Jan  8 18:48:58 2004
@@ -4,7 +4,7 @@
  * Copyright (C) 2000 John G Dorsey <john+@cs.cmu.edu>
  *
  * This file contains definitions for the low-level SA-1100 kernel PCMCIA
- * interface. Please see linux/Documentation/arm/SA1100/PCMCIA for details.
+ * interface. Please see Documentation/arm/SA1100/PCMCIA for details.
  */
 #ifndef _ASM_ARCH_PCMCIA
 #define _ASM_ARCH_PCMCIA
diff -Nru a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
--- a/drivers/scsi/aha152x.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/scsi/aha152x.c	Thu Jan  8 18:48:58 2004
@@ -1814,7 +1814,7 @@
 				       "aha152x: unable to verify geometry for disk with >1GB.\n"
 				       "         Using default translation. Please verify yourself.\n"
 				       "         Perhaps you need to enable extended translation in the driver.\n"
-				       "         See /usr/src/linux/Documentation/scsi/aha152x.txt for details.\n");
+				       "         See Documentation/scsi/aha152x.txt for details.\n");
 			}
 		} else {
 			info_array[0] = info[0];
diff -Nru a/drivers/scsi/tmscsim.c b/drivers/scsi/tmscsim.c
--- a/drivers/scsi/tmscsim.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/scsi/tmscsim.c	Thu Jan  8 18:48:58 2004
@@ -1469,7 +1469,7 @@
     DC390_write32 (DMA_ScsiBusCtrl, EN_INT_ON_PCI_ABORT);
     PDEVSET1; PCI_READ_CONFIG_WORD(PDEV, PCI_STATUS, &pstat);
     printk ("DC390: Register dump: PCI Status: %04x\n", pstat);
-    printk ("DC390: In case of driver trouble read linux/Documentation/scsi/tmscsim.txt\n");
+    printk ("DC390: In case of driver trouble read Documentation/scsi/tmscsim.txt\n");
 }
 
 
diff -Nru a/drivers/usb/media/ov511.c b/drivers/usb/media/ov511.c
--- a/drivers/usb/media/ov511.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/usb/media/ov511.c	Thu Jan  8 18:48:58 2004
@@ -16,7 +16,7 @@
  * Based on the Linux CPiA driver written by Peter Pregler,
  * Scott J. Bertin and Johannes Erdfelt.
  * 
- * Please see the file: linux/Documentation/usb/ov511.txt 
+ * Please see the file: Documentation/usb/ov511.txt 
  * and the website at:  http://alpha.dyndns.org/ov511
  * for more info.
  *
diff -Nru a/drivers/usb/misc/tiglusb.c b/drivers/usb/misc/tiglusb.c
--- a/drivers/usb/misc/tiglusb.c	Thu Jan  8 18:48:58 2004
+++ b/drivers/usb/misc/tiglusb.c	Thu Jan  8 18:48:58 2004
@@ -10,7 +10,7 @@
  *
  * Based on dabusb.c, printer.c & scanner.c
  *
- * Please see the file: linux/Documentation/usb/SilverLink.txt
+ * Please see the file: Documentation/usb/SilverLink.txt
  * and the website at:  http://lpg.ticalc.org/prj_usb/
  * for more info.
  *
diff -Nru a/fs/hfs/FAQ.txt b/fs/hfs/FAQ.txt
--- a/fs/hfs/FAQ.txt	Thu Jan  8 18:48:58 2004
+++ b/fs/hfs/FAQ.txt	Thu Jan  8 18:48:58 2004
@@ -264,7 +264,7 @@
   mount option.  More information is provided in the ``afpd'' subsection
   of the ``Mount Options'' section of the HFS documentation (HFS.txt if
   you have the stand-alone HFS distribution or
-  linux/Documentation/filesystems/hfs.txt if HFS is in your kernel
+  Documentation/filesystems/hfs.txt if HFS is in your kernel
   source tree.)
 
   1199..  WWhhyy ddooeess mmyy MMaacciinnttoosshh sshhooww ggeenneerriicc aapppplliiccaattiioonn aanndd ddooccuummeenntt
diff -Nru a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c	Thu Jan  8 18:48:58 2004
+++ b/fs/locks.c	Thu Jan  8 18:48:58 2004
@@ -60,7 +60,7 @@
  *
  *  Initial implementation of mandatory locks. SunOS turned out to be
  *  a rotten model, so I implemented the "obvious" semantics.
- *  See 'linux/Documentation/mandatory.txt' for details.
+ *  See 'Documentation/mandatory.txt' for details.
  *  Andy Walker (andy@lysaker.kvaerner.no), April 06, 1996.
  *
  *  Don't allow mandatory locks on mmap()'ed files. Added simple functions to
diff -Nru a/include/asm-arm/cacheflush.h b/include/asm-arm/cacheflush.h
--- a/include/asm-arm/cacheflush.h	Thu Jan  8 18:48:58 2004
+++ b/include/asm-arm/cacheflush.h	Thu Jan  8 18:48:58 2004
@@ -89,7 +89,7 @@
  *	Start addresses are inclusive and end addresses are exclusive;
  *	start addresses should be rounded down, end addresses up.
  *
- *	See linux/Documentation/cachetlb.txt for more information.
+ *	See Documentation/cachetlb.txt for more information.
  *	Please note that the implementation of these, and the required
  *	effects are cache-type (VIVT/VIPT/PIPT) specific.
  *
diff -Nru a/include/asm-arm/io.h b/include/asm-arm/io.h
--- a/include/asm-arm/io.h	Thu Jan  8 18:48:58 2004
+++ b/include/asm-arm/io.h	Thu Jan  8 18:48:58 2004
@@ -260,7 +260,7 @@
  * ioremap and friends.
  *
  * ioremap takes a PCI memory address, as specified in
- * linux/Documentation/IO-mapping.txt.
+ * Documentation/IO-mapping.txt.
  */
 extern void * __ioremap(unsigned long, size_t, unsigned long, unsigned long);
 extern void __iounmap(void *addr);
diff -Nru a/include/asm-arm/setup.h b/include/asm-arm/setup.h
--- a/include/asm-arm/setup.h	Thu Jan  8 18:48:58 2004
+++ b/include/asm-arm/setup.h	Thu Jan  8 18:48:58 2004
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  *  Structure passed to kernel to tell it about the
- *  hardware it's running on.  See linux/Documentation/arm/Setup
+ *  hardware it's running on.  See Documentation/arm/Setup
  *  for more info.
  */
 #ifndef __ASMARM_SETUP_H
diff -Nru a/include/asm-arm26/io.h b/include/asm-arm26/io.h
--- a/include/asm-arm26/io.h	Thu Jan  8 18:48:58 2004
+++ b/include/asm-arm26/io.h	Thu Jan  8 18:48:58 2004
@@ -383,7 +383,7 @@
  * ioremap and friends.
  *
  * ioremap takes a PCI memory address, as specified in
- * linux/Documentation/IO-mapping.txt.
+ * Documentation/IO-mapping.txt.
  */
 extern void * __ioremap(unsigned long, size_t, unsigned long, unsigned long);
 extern void __iounmap(void *addr);
diff -Nru a/include/asm-arm26/setup.h b/include/asm-arm26/setup.h
--- a/include/asm-arm26/setup.h	Thu Jan  8 18:48:58 2004
+++ b/include/asm-arm26/setup.h	Thu Jan  8 18:48:58 2004
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  *  Structure passed to kernel to tell it about the
- *  hardware it's running on.  See linux/Documentation/arm/Setup
+ *  hardware it's running on.  See Documentation/arm/Setup
  *  for more info.
  */
 #ifndef __ASMARM_SETUP_H
diff -Nru a/include/scsi/sg.h b/include/scsi/sg.h
--- a/include/scsi/sg.h	Thu Jan  8 18:48:58 2004
+++ b/include/scsi/sg.h	Thu Jan  8 18:48:58 2004
@@ -76,7 +76,7 @@
 	http://www.torque.net/sg/p/scsi-generic_long.txt
  A version of this document (potentially out of date) may also be found in
  the kernel source tree, probably at:
-        /usr/src/linux/Documentation/scsi/scsi-generic.txt .
+        Documentation/scsi/scsi-generic.txt .
 
  Utility and test programs are available at the sg web site. They are 
  bundled as sg_utils (for the lk 2.2 series) and sg3_utils (for the
diff -Nru a/mm/swap.c b/mm/swap.c
--- a/mm/swap.c	Thu Jan  8 18:48:58 2004
+++ b/mm/swap.c	Thu Jan  8 18:48:58 2004
@@ -7,7 +7,7 @@
 /*
  * This file contains the default values for the opereation of the
  * Linux VM subsystem. Fine-tuning documentation can be found in
- * linux/Documentation/sysctl/vm.txt.
+ * Documentation/sysctl/vm.txt.
  * Started 18.12.91
  * Swap aging added 23.2.95, Stephen Tweedie.
  * Buffermem limits added 12.3.98, Rik van Riel.
diff -Nru a/scripts/MAKEDEV.ide b/scripts/MAKEDEV.ide
--- a/scripts/MAKEDEV.ide	Thu Jan  8 18:48:58 2004
+++ b/scripts/MAKEDEV.ide	Thu Jan  8 18:48:58 2004
@@ -2,7 +2,7 @@
 #
 # This script creates the proper /dev/ entries for IDE devices
 # on the primary, secondary, tertiary, and quaternary interfaces.
-# See ../Documentation/ide.txt for more information.
+# See Documentation/ide.txt for more information.
 #
 makedev () {
 	rm -f /dev/$1
diff -Nru a/scripts/MAKEDEV.snd b/scripts/MAKEDEV.snd
--- a/scripts/MAKEDEV.snd	Thu Jan  8 18:48:58 2004
+++ b/scripts/MAKEDEV.snd	Thu Jan  8 18:48:58 2004
@@ -1,7 +1,7 @@
 #!/bin/bash
 #
 # This script creates the proper /dev/ entries for ALSA devices.
-# See ../Documentation/sound/alsa/ALSA-Configuration.txt for more
+# See Documentation/sound/alsa/ALSA-Configuration.txt for more
 # information.
 
 MAJOR=116
diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
--- a/sound/oss/via82cxxx_audio.c	Thu Jan  8 18:48:58 2004
+++ b/sound/oss/via82cxxx_audio.c	Thu Jan  8 18:48:58 2004
@@ -10,7 +10,7 @@
  * NO WARRANTY
  *
  * For a list of known bugs (errata) and documentation,
- * see via-audio.pdf in linux/Documentation/DocBook.
+ * see via-audio.pdf in Documentation/DocBook.
  * If this documentation does not exist, run "make pdfdocs".
  */
 
diff -Nru a/sound/oss/vwsnd.c b/sound/oss/vwsnd.c
--- a/sound/oss/vwsnd.c	Thu Jan  8 18:48:58 2004
+++ b/sound/oss/vwsnd.c	Thu Jan  8 18:48:58 2004
@@ -1,6 +1,6 @@
 /*
  * Sound driver for Silicon Graphics 320 and 540 Visual Workstations'
- * onboard audio.  See notes in ../../Documentation/sound/oss/vwsnd .
+ * onboard audio.  See notes in Documentation/sound/oss/vwsnd .
  *
  * Copyright 1999 Silicon Graphics, Inc.  All rights reserved.
  *
