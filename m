Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWJQWhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWJQWhA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWJQWg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:36:59 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:46923 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750842AbWJQWg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:36:59 -0400
Date: Tue, 17 Oct 2006 15:38:13 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] Kconfig serial typos
Message-Id: <20061017153813.e378dd5c.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix typo (repeated) in serial Kconfig.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/serial/Kconfig |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2619-rc2-ppc.orig/drivers/serial/Kconfig
+++ linux-2619-rc2-ppc/drivers/serial/Kconfig
@@ -767,37 +767,37 @@ config SERIAL_CPM_SCC1
 	bool "Support for SCC1 serial port"
 	depends on SERIAL_CPM=y
 	help
-	  Select the is option to use SCC1 as a serial port
+	  Select this option to use SCC1 as a serial port
 
 config SERIAL_CPM_SCC2
 	bool "Support for SCC2 serial port"
 	depends on SERIAL_CPM=y
 	help
-	  Select the is option to use SCC2 as a serial port
+	  Select this option to use SCC2 as a serial port
 
 config SERIAL_CPM_SCC3
 	bool "Support for SCC3 serial port"
 	depends on SERIAL_CPM=y
 	help
-	  Select the is option to use SCC3 as a serial port
+	  Select this option to use SCC3 as a serial port
 
 config SERIAL_CPM_SCC4
 	bool "Support for SCC4 serial port"
 	depends on SERIAL_CPM=y
 	help
-	  Select the is option to use SCC4 as a serial port
+	  Select this option to use SCC4 as a serial port
 
 config SERIAL_CPM_SMC1
 	bool "Support for SMC1 serial port"
 	depends on SERIAL_CPM=y
 	help
-	  Select the is option to use SMC1 as a serial port
+	  Select this option to use SMC1 as a serial port
 
 config SERIAL_CPM_SMC2
 	bool "Support for SMC2 serial port"
 	depends on SERIAL_CPM=y
 	help
-	  Select the is option to use SMC2 as a serial port
+	  Select this option to use SMC2 as a serial port
 
 config SERIAL_SGI_L1_CONSOLE
 	bool "SGI Altix L1 serial console support"


---
