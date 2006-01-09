Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWAIE4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWAIE4E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 23:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWAIE4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 23:56:04 -0500
Received: from xenotime.net ([66.160.160.81]:34727 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751233AbWAIE4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 23:56:02 -0500
Date: Sun, 8 Jan 2006 20:56:00 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: vandrove@vc.cvut.cz, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documenation typo (hpet)
Message-Id: <20060108205600.1c6ff51e.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix a typo.  Requested by Petr Vandrovec.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/hpet.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2615-g3.orig/Documentation/hpet.txt
+++ linux-2615-g3/Documentation/hpet.txt
@@ -2,7 +2,7 @@
 
 The High Precision Event Timer (HPET) hardware is the future replacement
 for the 8254 and Real Time Clock (RTC) periodic timer functionality.
-Each HPET can have up two 32 timers.  It is possible to configure the
+Each HPET can have up to 32 timers.  It is possible to configure the
 first two timers as legacy replacements for 8254 and RTC periodic timers.
 A specification done by Intel and Microsoft can be found at
 <http://www.intel.com/hardwaredesign/hpetspec.htm>.


---
