Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbUKPX1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUKPX1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUKPXY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:24:56 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:21389 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261895AbUKPXJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:09:02 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
Cc: james4765@verizon.net
Message-Id: <20041116230859.20486.75566.50510@localhost.localdomain>
In-Reply-To: <20041116230851.20486.59528.47474@localhost.localdomain>
References: <20041116230851.20486.59528.47474@localhost.localdomain>
Subject: [PATCH] cciss: Correct mailing list address in source code
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.220.243] at Tue, 16 Nov 2004 17:08:59 -0600
Date: Tue, 16 Nov 2004 17:09:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct mailing list address in cciss source code.

diffstat output:

 cciss.c      |    2 +-
 cciss_scsi.c |    2 +-
 cciss_scsi.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/cciss.c linux-2.6.10-rc2/drivers/block/cciss.c
--- linux-2.6.10-rc2-original/drivers/block/cciss.c	2004-11-15 21:38:15.683435907 -0500
+++ linux-2.6.10-rc2/drivers/block/cciss.c	2004-11-16 17:27:02.056138014 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to Cciss-discuss@lists.sourceforge.net
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 
diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/cciss_scsi.c linux-2.6.10-rc2/drivers/block/cciss_scsi.c
--- linux-2.6.10-rc2-original/drivers/block/cciss_scsi.c	2004-11-15 21:38:15.685435637 -0500
+++ linux-2.6.10-rc2/drivers/block/cciss_scsi.c	2004-11-16 17:47:28.924506697 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *    
  *    Author: Stephen M. Cameron
  */
diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/cciss_scsi.h linux-2.6.10-rc2/drivers/block/cciss_scsi.h
--- linux-2.6.10-rc2-original/drivers/block/cciss_scsi.h	2004-10-18 17:54:22.000000000 -0400
+++ linux-2.6.10-rc2/drivers/block/cciss_scsi.h	2004-11-16 17:47:21.868459287 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 #ifdef CONFIG_CISS_SCSI_TAPE
