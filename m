Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbUL3PfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUL3PfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUL3PfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:35:12 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:37132 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261657AbUL3PfB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:35:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] cciss: Correct mailing list address in source code
Date: Thu, 30 Dec 2004 09:35:00 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC015F@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cciss: Correct mailing list address in source code
Thread-Index: AcTrTWVj/TN8Pd1XRD6WDfV0IQaXvADN5BpQ
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "James Nelson" <james4765@verizon.net>, <linux-kernel@vger.kernel.org>,
       "ISS StorageDev" <iss_storagedev@hp.com>
Cc: <akpm@osdl.org>
X-OriginalArrivalTime: 30 Dec 2004 15:35:01.0376 (UTC) FILETIME=[2055A000:01C4EE85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Miller <mike.miller@hp.com>

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
