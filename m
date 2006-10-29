Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWJ2XhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWJ2XhI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 18:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWJ2XhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 18:37:08 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:52438 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030453AbWJ2XhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 18:37:06 -0500
Subject: [Patch] APM: URL of APM 1.2 specs has changed
From: Kristian Mueller <Kristian-M@Kristian-M.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 30 Oct 2006 00:37:43 +0800
Message-Id: <1162139863.10790.25.camel@pismo>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

APM BIOS Interface Secification can now be found at
http://www.microsoft.com/whdc/archive/amp_12.mspx

Signed-off-by: Kristian Mueller <Kristian-M@Kristian-M.de>

--- a/arch/i386/kernel/apm.c      2006-10-14 05:34:03 +0200
+++ b/arch/i386/kernel/apm.c      2006-10-28 22:41:24 +0200
@@ -198,7 +198,7 @@
  *   (APM) BIOS Interface Specification, Revision 1.2, February 1996.
  *
  * [This document is available from Microsoft at:
- *    http://www.microsoft.com/hwdev/busbios/amp_12.htm]
+ *    http://www.microsoft.com/whdc/archive/amp_12.mspx]
  */

 #include <linux/module.h>


