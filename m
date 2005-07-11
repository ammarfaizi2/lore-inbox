Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVGKMU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVGKMU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 08:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVGKMU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 08:20:26 -0400
Received: from [85.8.12.41] ([85.8.12.41]:31360 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261656AbVGKMTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 08:19:37 -0400
Message-ID: <42D263D7.8040006@drzeus.cx>
Date: Mon, 11 Jul 2005 14:19:35 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-7089-1121084376-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] wbsd version bump
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-7089-1121084376-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Version increase of the wbsd driver.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

Even though the changes are minor for the next release an increasing
version number simplifies my support issues.


--=_hermes.drzeus.cx-7089-1121084376-0001-2
Content-Type: text/x-patch; name="wbsd-version.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-version.patch"

Index: linux/drivers/mmc/wbsd.c
===================================================================
--- linux/drivers/mmc/wbsd.c	(revision 151)
+++ linux/drivers/mmc/wbsd.c	(working copy)
@@ -42,7 +42,7 @@
 #include "wbsd.h"
 
 #define DRIVER_NAME "wbsd"
-#define DRIVER_VERSION "1.2"
+#define DRIVER_VERSION "1.3"
 
 #ifdef CONFIG_MMC_DEBUG
 #define DBG(x...) \

--=_hermes.drzeus.cx-7089-1121084376-0001-2--
