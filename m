Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbULZNTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbULZNTj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 08:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbULZNS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 08:18:26 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:34236 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261648AbULZNSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 08:18:07 -0500
From: James Nelson <james4765@verizon.net>
To: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
Cc: akpm@osdl.org, James Nelson <james4765@verizon.net>
Message-Id: <20041226131827.11671.26274.46211@localhost.localdomain>
In-Reply-To: <20041226131814.11671.51063.44543@localhost.localdomain>
References: <20041226131814.11671.51063.44543@localhost.localdomain>
Subject: [PATCH] cpqarray: Correct mailing list address in source code
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Sun, 26 Dec 2004 07:18:06 -0600
Date: Sun, 26 Dec 2004 07:18:07 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch still applies to 2.6.10.

Correct mailing list address in cpqarray source code.

diffstat output:

 cpqarray.c  |    2 +-
 cpqarray.h  |    2 +-
 ida_cmd.h   |    2 +-
 ida_ioctl.h |    2 +-
 smart1,2.h  |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-original/drivers/block/cpqarray.c linux-2.6.10/drivers/block/cpqarray.c
--- linux-2.6.10-original/drivers/block/cpqarray.c	2004-12-24 16:34:01.000000000 -0500
+++ linux-2.6.10/drivers/block/cpqarray.c	2004-12-26 08:09:53.595573537 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to Cpqarray-discuss@lists.sourceforge.net
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 #include <linux/config.h>	/* CONFIG_PROC_FS */
diff -urN --exclude='*~' linux-2.6.10-original/drivers/block/cpqarray.h linux-2.6.10/drivers/block/cpqarray.h
--- linux-2.6.10-original/drivers/block/cpqarray.h	2004-12-24 16:35:01.000000000 -0500
+++ linux-2.6.10/drivers/block/cpqarray.h	2004-12-26 08:09:53.596573402 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  *    If you want to make changes, improve or add functionality to this
  *    driver, you'll probably need the Compaq Array Controller Interface
diff -urN --exclude='*~' linux-2.6.10-original/drivers/block/ida_cmd.h linux-2.6.10/drivers/block/ida_cmd.h
--- linux-2.6.10-original/drivers/block/ida_cmd.h	2004-12-24 16:34:30.000000000 -0500
+++ linux-2.6.10/drivers/block/ida_cmd.h	2004-12-26 08:09:53.596573402 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 #ifndef ARRAYCMD_H
diff -urN --exclude='*~' linux-2.6.10-original/drivers/block/ida_ioctl.h linux-2.6.10/drivers/block/ida_ioctl.h
--- linux-2.6.10-original/drivers/block/ida_ioctl.h	2004-12-24 16:34:45.000000000 -0500
+++ linux-2.6.10/drivers/block/ida_ioctl.h	2004-12-26 08:09:53.597573267 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 #ifndef IDA_IOCTL_H
diff -urN --exclude='*~' linux-2.6.10-original/drivers/block/smart1,2.h linux-2.6.10/drivers/block/smart1,2.h
--- linux-2.6.10-original/drivers/block/smart1,2.h	2004-12-24 16:35:00.000000000 -0500
+++ linux-2.6.10/drivers/block/smart1,2.h	2004-12-26 08:09:53.690560713 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  *    If you want to make changes, improve or add functionality to this
  *    driver, you'll probably need the Compaq Array Controller Interface
