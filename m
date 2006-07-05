Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWGEAxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWGEAxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWGEAxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:53:21 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:64524 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S932379AbWGEAxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:53:20 -0400
Date: Tue, 4 Jul 2006 20:52:59 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH] drivers/acpi/Kconfig typos
Message-Id: <20060704205259.09e046d4.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Tue, 04 Jul 2006 20:53:00 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Tue, 04 Jul 2006 20:53:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three typos in drivers/acpi/Kconfig...

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
kernel1@cyberdogtech.com

--

--- a/drivers/acpi/Kconfig	2006-07-04 20:18:01.000000000 -0400
+++ b/drivers/acpi/Kconfig	2006-07-04 20:52:34.000000000 -0400
@@ -254,7 +254,7 @@
 	depends on !STANDALONE
 	default n 
 	help
-	  Thist option is to load a custom ACPI DSDT
+	  This option is to load a custom ACPI DSDT
 	  If you don't know what that is, say N.
 
 config ACPI_CUSTOM_DSDT_FILE
@@ -311,7 +311,7 @@
 	  The Power Management Timer is available on all ACPI-capable,
 	  in most cases even if ACPI is unusable or blacklisted.
 
-	  This timing source is not affected by powermanagement features
+	  This timing source is not affected by power management features
 	  like aggressive processor idling, throttling, frequency and/or
 	  voltage scaling, unlike the commonly used Time Stamp Counter
 	  (TSC) timing source.
@@ -346,7 +346,7 @@
 	  Enabling this driver assumes that your platform hardware
 	  and firmware have support for hot-plugging physical memory. If
 	  your system does not support physically adding or ripping out 
-	  memory DIMMs at some platfrom defined granularity (individually 
+	  memory DIMMs at some platform defined granularity (individually 
 	  or as a bank) at runtime, then you need not enable this driver.
 
 	  If one selects "m," this driver can be loaded using the following

