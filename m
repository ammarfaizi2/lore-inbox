Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUDOSSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbUDORnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:43:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:31158 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263219AbUDORmV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:21 -0400
X-Donotread: and you are reading this why?
Subject: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <20040415173521.GA4117@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:51 -0700
Message-Id: <1082050911678@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.1, 2004/03/19 13:05:08-08:00, greg@kroah.com

Driver Core: fix spaces instead of tabs problem in the Kconfig file.


 drivers/base/Kconfig |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/base/Kconfig b/drivers/base/Kconfig
--- a/drivers/base/Kconfig	Thu Apr 15 10:21:27 2004
+++ b/drivers/base/Kconfig	Thu Apr 15 10:21:27 2004
@@ -9,14 +9,14 @@
 	  the kernel tree does.
 
 config DEBUG_DRIVER
-        bool "Driver Core verbose debug messages"
-        depends on DEBUG_KERNEL
-        help
-          Say Y here if you want the Driver core to produce a bunch of
-          debug messages to the system log. Select this if you are having a
-          problem with the driver core and want to see more of what is
-          going on.
+	 bool "Driver Core verbose debug messages"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here if you want the Driver core to produce a bunch of
+	  debug messages to the system log. Select this if you are having a
+	  problem with the driver core and want to see more of what is
+	  going on.
 
-          If you are unsure about this, say N here.
+	  If you are unsure about this, say N here.
 
 endmenu

