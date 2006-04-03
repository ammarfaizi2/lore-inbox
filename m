Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWDCMVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWDCMVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWDCMVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:21:06 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:3967 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750933AbWDCMVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:21:05 -0400
Date: Mon, 3 Apr 2006 14:21:00 +0200
From: Erik Mouw <erik@bitwizard.nl>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: davej@codemonkey.org.uk
Subject: [PATCH CpuFreq] Update LART site URL
Message-ID: <20060403122100.GA16823@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Bitwizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update LART site URL.

The LART website moved to http://www.lartmaker.nl/. This patch
updates the URL in CpuFreq specific files.

Signed-off-by: Erik Mouw <erik@bitwizard.nl>

diff --git a/Documentation/cpu-freq/index.txt b/Documentation/cpu-freq/index.txt
index 5009805..ffdb532 100644
--- a/Documentation/cpu-freq/index.txt
+++ b/Documentation/cpu-freq/index.txt
@@ -53,4 +53,4 @@ the CPUFreq Mailing list:
 * http://lists.linux.org.uk/mailman/listinfo/cpufreq
 
 Clock and voltage scaling for the SA-1100:
-* http://www.lart.tudelft.nl/projects/scaling
+* http://www.lartmaker.nl/projects/scaling
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 60c9be9..2cc71b6 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -99,7 +99,7 @@ config CPU_FREQ_GOV_USERSPACE
 	  Enable this cpufreq governor when you either want to set the
 	  CPU frequency manually or when an userspace program shall
 	  be able to set the CPU dynamically, like on LART 
-	  <http://www.lart.tudelft.nl/>
+	  <http://www.lartmaker.nl/>.
 
 	  For details, take a look at <file:Documentation/cpu-freq/>.
 

-- 
----  Erik Mouw  ----  www.bitwizard.nl  ----  +31 15 2600 998  ----
