Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbULZNSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbULZNSL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 08:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbULZNSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 08:18:11 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:60646 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261647AbULZNSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 08:18:00 -0500
From: James Nelson <james4765@verizon.net>
To: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
Cc: akpm@osdl.org, James Nelson <james4765@verizon.net>
Message-Id: <20041226131820.11671.45311.43111@localhost.localdomain>
In-Reply-To: <20041226131814.11671.51063.44543@localhost.localdomain>
References: <20041226131814.11671.51063.44543@localhost.localdomain>
Subject: [PATCH] cciss: Correct mailing list address in source code
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Sun, 26 Dec 2004 07:17:59 -0600
Date: Sun, 26 Dec 2004 07:18:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch still applies to 2.6.10.

Correct mailing list address in cciss source code.

diffstat output:

 cciss.c      |    2 +-
 cciss_scsi.c |    2 +-
 cciss_scsi.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-original/drivers/block/cciss.c linux-2.6.10/drivers/block/cciss.c
--- linux-2.6.10-original/drivers/block/cciss.c	2004-12-24 16:35:39.000000000 -0500
+++ linux-2.6.10/drivers/block/cciss.c	2004-12-26 08:06:24.639783315 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to Cciss-discuss@lists.sourceforge.net
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 
diff -urN --exclude='*~' linux-2.6.10-original/drivers/block/cciss_scsi.c linux-2.6.10/drivers/block/cciss_scsi.c
--- linux-2.6.10-original/drivers/block/cciss_scsi.c	2004-12-24 16:34:26.000000000 -0500
+++ linux-2.6.10/drivers/block/cciss_scsi.c	2004-12-26 08:06:24.640783180 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *    
  *    Author: Stephen M. Cameron
  */
diff -urN --exclude='*~' linux-2.6.10-original/drivers/block/cciss_scsi.h linux-2.6.10/drivers/block/cciss_scsi.h
--- linux-2.6.10-original/drivers/block/cciss_scsi.h	2004-12-24 16:34:48.000000000 -0500
+++ linux-2.6.10/drivers/block/cciss_scsi.h	2004-12-26 08:06:24.650781831 -0500
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to iss_storagedev@hp.com
  *
  */
 #ifdef CONFIG_CISS_SCSI_TAPE
