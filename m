Return-Path: <linux-kernel-owner+w=401wt.eu-S965172AbWL2VYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWL2VYp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 16:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWL2VYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 16:24:45 -0500
Received: from mail0.lsil.com ([147.145.40.20]:62056 "EHLO mail0.lsil.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965169AbWL2VYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 16:24:44 -0500
X-Greylist: delayed 690 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 16:24:44 EST
Subject: [Patch] scsi:megaraid_sas:Update module author
From: Sumant Patro <sumantp@lsil.com>
To: James.Bottomley@SteelEye.com, akpm@osdl.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       neela.kolli@lsi.com, bo.yang@lsi.com
Content-Type: multipart/mixed; boundary="=-UNm+chCmWXlix3C2zDVN"
Date: Fri, 29 Dec 2006 08:13:54 -0800
Message-Id: <1167408834.4154.13.camel@dumbo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UNm+chCmWXlix3C2zDVN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Update domain name change from lsil.com to lsi.com.
Change module author to megaraidlinux@lsi.com

Signed-Off By: Sumant Patro <sumant.patro@lsi.com>

diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_sas.c linux-2.6.new/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6.orig/drivers/scsi/megaraid/megaraid_sas.c 2006-12-28 09:56:05.000000000 -0800
+++ linux-2.6.new/drivers/scsi/megaraid/megaraid_sas.c 2006-12-29 07:17:21.000000000 -0800
@@ -13,8 +13,8 @@
  * Version : v00.00.03.05
  *
  * Authors:
- *  Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
- *  Sumant Patro  <Sumant.Patro@lsil.com>
+ *  Sreenivas Bagalkote <Sreenivas.Bagalkote@lsi.com>
+ *  Sumant Patro  <Sumant.Patro@lsi.com>
  *
  * List of supported controllers
  *
@@ -45,7 +45,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGASAS_VERSION);
-MODULE_AUTHOR("sreenivas.bagalkote@lsil.com");
+MODULE_AUTHOR("megaraidlinux@lsi.com");
 MODULE_DESCRIPTION("LSI Logic MegaRAID SAS Driver");
 
 /*


--=-UNm+chCmWXlix3C2zDVN
Content-Disposition: attachment; filename=megaraid_sas_update_author.patch
Content-Type: text/x-patch; name=megaraid_sas_update_author.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_sas.c linux-2.6.new/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6.orig/drivers/scsi/megaraid/megaraid_sas.c	2006-12-28 09:56:05.000000000 -0800
+++ linux-2.6.new/drivers/scsi/megaraid/megaraid_sas.c	2006-12-29 07:17:21.000000000 -0800
@@ -13,8 +13,8 @@
  * Version	: v00.00.03.05
  *
  * Authors:
- * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
- * 	Sumant Patro		<Sumant.Patro@lsil.com>
+ * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsi.com>
+ * 	Sumant Patro		<Sumant.Patro@lsi.com>
  *
  * List of supported controllers
  *
@@ -45,7 +45,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGASAS_VERSION);
-MODULE_AUTHOR("sreenivas.bagalkote@lsil.com");
+MODULE_AUTHOR("megaraidlinux@lsi.com");
 MODULE_DESCRIPTION("LSI Logic MegaRAID SAS Driver");
 
 /*

--=-UNm+chCmWXlix3C2zDVN--

