Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWGEA0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWGEA0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGEA0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:26:16 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:53004 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S932363AbWGEA0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:26:15 -0400
Date: Tue, 4 Jul 2006 20:25:21 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: arch/alpha/Kconfig typo
Message-Id: <20060704202521.4a3d757e.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Tue, 04 Jul 2006 20:25:25 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Tue, 04 Jul 2006 20:25:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in arch/alpha/Kconfig

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
kernel1@cyberdogtech.com

--

--- a/arch/alpha/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/arch/alpha/Kconfig	2006-06-29 14:13:02.000000000 -0400
@@ -534,7 +534,7 @@
 	bool "Discontiguous Memory Support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
-	  Say Y to upport efficient handling of discontiguous physical memory,
+	  Say Y to support efficient handling of discontiguous physical memory,
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.

