Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbUK2N1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUK2N1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 08:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUK2N1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 08:27:51 -0500
Received: from magic.adaptec.com ([216.52.22.17]:34755 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261293AbUK2N1m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 08:27:42 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] remove bouncing email address of Deanna Bonds
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Mon, 29 Nov 2004 08:27:39 -0500
Message-ID: <60807403EABEB443939A5A7AA8A7458B7661DC@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] remove bouncing email address of Deanna Bonds
Thread-Index: AcTSqlVndHXr4M7ORCuBPWqkh9N8bgDbL20g
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Adrian Bunk" <bunk@stusta.de>, <James.Bottomley@SteelEye.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That address should instead become aacraid@adaptec.com to capture
engineers at Adaptec.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Adrian Bunk
Sent: Wednesday, November 24, 2004 1:47 PM
To: James.Bottomley@SteelEye.com; Marcelo Tosatti
Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [patch] remove bouncing email address of Deanna Bonds

The patch below (applies against both 2.4 and 2.6) removes the bouncing 
email address of Deanna Bonds (I didn't find a nmore recent address).


diffstat output:
 drivers/scsi/aacraid/README   |    2 +-
 drivers/scsi/dpt/dpti_ioctl.h |    1 -
 drivers/scsi/dpt_i2o.c        |    1 -
 drivers/scsi/dpti.h           |    1 -
 4 files changed, 1 insertion(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/scsi/dpti.h.old	2004-11-24
19:23:47.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/dpti.h	2004-11-24
19:23:56.000000000 +0100
@@ -3,7 +3,6 @@
                              -------------------
     begin                : Thu Sep 7 2000
     copyright            : (C) 2001 by Adaptec
-    email                : deanna_bonds@adaptec.com
 
     See Documentation/scsi/dpti.txt for history, notes, license info
     and credits
--- linux-2.6.10-rc2-mm3-full/drivers/scsi/aacraid/README.old
2004-11-24 19:24:05.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/aacraid/README
2004-11-24 19:24:16.000000000 +0100
@@ -42,7 +42,7 @@
 Christoph Hellwig <hch@infradead.org>	(updates for new-style PCI
probing and SCSI host registration,
 					 small cleanups/fixes)
 Matt Domsch <matt_domsch@dell.com>	(revision ioctl, adapter
messages)
-Deanna Bonds <deanna_bonds@adaptec.com> (non-DASD support, PAE fibs and
64 bit, added new adaptec controllers
+Deanna Bonds                            (non-DASD support, PAE fibs and
64 bit, added new adaptec controllers
 					 added new ioctls, changed scsi
interface to use new error handler,
 					 increased the number of fibs
and outstanding commands to a container)
 
--- linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt/dpti_ioctl.h.old
2004-11-24 19:24:24.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt/dpti_ioctl.h
2004-11-24 19:24:27.000000000 +0100
@@ -3,7 +3,6 @@
                              -------------------
     begin                : Thu Sep 7 2000
     copyright            : (C) 2001 by Adaptec
-    email                : deanna_bonds@adaptec.com
 
     See Documentation/scsi/dpti.txt for history, notes, license info
     and credits
--- linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt_i2o.c.old
2004-11-24 19:24:34.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt_i2o.c	2004-11-24
19:24:37.000000000 +0100
@@ -3,7 +3,6 @@
                              -------------------
     begin                : Thu Sep 7 2000
     copyright            : (C) 2000 by Adaptec
-    email                : deanna_bonds@adaptec.com
 
 			   July 30, 2001 First version being submitted
 			   for inclusion in the kernel.  V2.4

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
