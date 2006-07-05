Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWGEBWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWGEBWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 21:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWGEBWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 21:22:36 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:12301 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S932416AbWGEBWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 21:22:35 -0400
Date: Tue, 4 Jul 2006 21:21:34 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH] drivers/atm/Kconfig typo
Message-Id: <20060704212134.0a5c62bf.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Tue, 04 Jul 2006 21:21:35 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Tue, 04 Jul 2006 21:21:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in drivers/atm/Kconfig...

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
kernel1@cyberdogtech.com

--

--- a/drivers/atm/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/atm/Kconfig	2006-07-04 21:00:28.000000000 -0400
@@ -398,7 +398,7 @@
 	default n
 	help
 	  This defers work to be done by the interrupt handler to a
-	  tasklet instead of hanlding everything at interrupt time.  This
+	  tasklet instead of handling everything at interrupt time.  This
 	  may improve the responsive of the host.
 
 config ATM_FORE200E_TX_RETRY

