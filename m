Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbUKYAvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbUKYAvU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbUKYAti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 19:49:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30212 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262906AbUKYArC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 19:47:02 -0500
Date: Wed, 24 Nov 2004 19:46:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch] remove bouncing email address of Deanna Bonds
Message-ID: <20041124184657.GH19873@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below (applies against both 2.4 and 2.6) removes the bouncing 
email address of Deanna Bonds (I didn't find a nmore recent address).


diffstat output:
 drivers/scsi/aacraid/README   |    2 +-
 drivers/scsi/dpt/dpti_ioctl.h |    1 -
 drivers/scsi/dpt_i2o.c        |    1 -
 drivers/scsi/dpti.h           |    1 -
 4 files changed, 1 insertion(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/scsi/dpti.h.old	2004-11-24 19:23:47.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/dpti.h	2004-11-24 19:23:56.000000000 +0100
@@ -3,7 +3,6 @@
                              -------------------
     begin                : Thu Sep 7 2000
     copyright            : (C) 2001 by Adaptec
-    email                : deanna_bonds@adaptec.com
 
     See Documentation/scsi/dpti.txt for history, notes, license info
     and credits
--- linux-2.6.10-rc2-mm3-full/drivers/scsi/aacraid/README.old	2004-11-24 19:24:05.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/aacraid/README	2004-11-24 19:24:16.000000000 +0100
@@ -42,7 +42,7 @@
 Christoph Hellwig <hch@infradead.org>	(updates for new-style PCI probing and SCSI host registration,
 					 small cleanups/fixes)
 Matt Domsch <matt_domsch@dell.com>	(revision ioctl, adapter messages)
-Deanna Bonds <deanna_bonds@adaptec.com> (non-DASD support, PAE fibs and 64 bit, added new adaptec controllers
+Deanna Bonds                            (non-DASD support, PAE fibs and 64 bit, added new adaptec controllers
 					 added new ioctls, changed scsi interface to use new error handler,
 					 increased the number of fibs and outstanding commands to a container)
 
--- linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt/dpti_ioctl.h.old	2004-11-24 19:24:24.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt/dpti_ioctl.h	2004-11-24 19:24:27.000000000 +0100
@@ -3,7 +3,6 @@
                              -------------------
     begin                : Thu Sep 7 2000
     copyright            : (C) 2001 by Adaptec
-    email                : deanna_bonds@adaptec.com
 
     See Documentation/scsi/dpti.txt for history, notes, license info
     and credits
--- linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt_i2o.c.old	2004-11-24 19:24:34.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt_i2o.c	2004-11-24 19:24:37.000000000 +0100
@@ -3,7 +3,6 @@
                              -------------------
     begin                : Thu Sep 7 2000
     copyright            : (C) 2000 by Adaptec
-    email                : deanna_bonds@adaptec.com
 
 			   July 30, 2001 First version being submitted
 			   for inclusion in the kernel.  V2.4

