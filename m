Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbUKPX1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbUKPX1C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbUKPX0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:26:10 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:13952 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261897AbUKPXJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:09:07 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
Cc: james4765@verizon.net
Message-Id: <20041116230906.20486.13119.93895@localhost.localdomain>
In-Reply-To: <20041116230851.20486.59528.47474@localhost.localdomain>
References: <20041116230851.20486.59528.47474@localhost.localdomain>
Subject: [PATCH] cpqarray: Correct mailing list address in source code
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [209.158.220.243] at Tue, 16 Nov 2004 17:09:07 -0600
Date: Tue, 16 Nov 2004 17:09:07 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct mailing list address in cpqarray source code.

diffstat output:

 cpqarray.c  |    2 +-
 cpqarray.h  |    2 +-
 ida_cmd.h   |    2 +-
 ida_ioctl.h |    2 +-
 smart1,2.h  |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/cpqarray.c linux-2.6.10-rc2/drivers/block/cpqarray.c
--- linux-2.6.10-rc2-original/drivers/block/cpqarray.c	2004-11-15 21:38:15.707432667 -0500
+++ linux-2.6.10-rc2/drivers/block/cpqarray.c	2004-11-16 17:26:45.127423447 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to Cpqarray-discuss@lists.sourceforge.net
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 #include <linux/config.h>	/* CONFIG_PROC_FS */
diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/cpqarray.h linux-2.6.10-rc2/drivers/block/cpqarray.h
--- linux-2.6.10-rc2-original/drivers/block/cpqarray.h	2004-10-18 17:54:37.000000000 -0400
+++ linux-2.6.10-rc2/drivers/block/cpqarray.h	2004-11-16 17:26:24.440216288 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  *    If you want to make changes, improve or add functionality to this
  *    driver, you'll probably need the Compaq Array Controller Interface
diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/ida_cmd.h linux-2.6.10-rc2/drivers/block/ida_cmd.h
--- linux-2.6.10-rc2-original/drivers/block/ida_cmd.h	2004-10-18 17:53:45.000000000 -0400
+++ linux-2.6.10-rc2/drivers/block/ida_cmd.h	2004-11-16 17:26:12.178871611 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 #ifndef ARRAYCMD_H
diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/ida_ioctl.h linux-2.6.10-rc2/drivers/block/ida_ioctl.h
--- linux-2.6.10-rc2-original/drivers/block/ida_ioctl.h	2004-10-18 17:54:08.000000000 -0400
+++ linux-2.6.10-rc2/drivers/block/ida_ioctl.h	2004-11-16 17:25:57.796813237 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 #ifndef IDA_IOCTL_H
diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/smart1,2.h linux-2.6.10-rc2/drivers/block/smart1,2.h
--- linux-2.6.10-rc2-original/drivers/block/smart1,2.h	2004-10-18 17:54:37.000000000 -0400
+++ linux-2.6.10-rc2/drivers/block/smart1,2.h	2004-11-16 17:25:48.198109094 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  *    If you want to make changes, improve or add functionality to this
  *    driver, you'll probably need the Compaq Array Controller Interface
