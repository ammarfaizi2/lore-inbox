Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbUL3Pce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUL3Pce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUL3Pce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:32:34 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:12555 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261656AbUL3PcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:32:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] cpqarray: Correct mailing list address in source code
Date: Thu, 30 Dec 2004 09:32:12 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC015D@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray: Correct mailing list address in source code
Thread-Index: AcTrThEONB1xTdwLRkqDcmBEN4tXUgDNnllg
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "James Nelson" <james4765@verizon.net>, <linux-kernel@vger.kernel.org>,
       "ISS StorageDev" <iss_storagedev@hp.com>
Cc: <akpm@osdl.org>
X-OriginalArrivalTime: 30 Dec 2004 15:32:13.0181 (UTC) FILETIME=[BC151AD0:01C4EE84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Miller <mike.miller@hp.com>


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
