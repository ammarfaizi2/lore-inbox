Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267688AbTBRTnl>; Tue, 18 Feb 2003 14:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbTBRTnl>; Tue, 18 Feb 2003 14:43:41 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:60690 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267688AbTBRTnk>; Tue, 18 Feb 2003 14:43:40 -0500
Date: Tue, 18 Feb 2003 20:53:40 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [TRIVIAL][PATCH][RESEND] 2 spelling typos
In-Reply-To: <Pine.LNX.4.51.0302181806080.19871@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.51.0302182044300.2132@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0302181806080.19871@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry, for lack of subject and bad diffs, this is better.
(with/wiht) (the/hte) mistakes.

Regards,
Maciej Soltysiak

--- linux-2.5.60/drivers/atm/firestream.c~	2003-02-10 19:37:59.000000000 +0100
+++ linux-2.5.60/drivers/atm/firestream.c	2003-02-18 20:36:33.000000000 +0100
@@ -1792,7 +1792,7 @@
 		write_fs (dev, RAC, 0);

 		/* Manual (AN9, page 6) says ASF1=0 means compare Utopia address
-		 * too.  I can't find ASF1 anywhere. Anyway, we AND with just hte
+		 * too.  I can't find ASF1 anywhere. Anyway, we AND with just the
 		 * other bits, then compare with 0, which is exactly what we
 		 * want. */
 		write_fs (dev, RAM, (1 << (28 - FS155_VPI_BITS - FS155_VCI_BITS)) - 1);


--- linux-2.5.60/drivers/s390/block/dasd_3990_erp.c~	2003-02-10 19:38:51.000000000 +0100
+++ linux-2.5.60/drivers/s390/block/dasd_3990_erp.c	2003-02-18 20:39:02.000000000 +0100
@@ -2427,7 +2427,7 @@
  *     - exit with permanent error
  *
  * PARAMETER
- *   erp		ERP which is in progress wiht no retry left
+ *   erp		ERP which is in progress with no retry left
  *
  * RETURN VALUES
  *   erp		modified/additional ERP
