Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUBTTML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbUBTTLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:11:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:1766 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261287AbUBTTG2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:06:28 -0500
Subject: Re: [PATCH] PCI update for 2.6.3
In-Reply-To: <10773039771460@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Feb 2004 11:06:18 -0800
Message-Id: <10773039773934@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.58.2, 2004/02/18 11:16:10-08:00, tlnguyen@snoqualmie.dp.intel.com

[PATCH] PCI: add copyright for files msi.c and msi.h

First I would like to say sorry for not responding immediately after receiving
your email mentioning Copyright. I have contacted Intel Legal for proper text
upon receiving this email; but have not received any response. As a result of
team discussion, the attached patch, based on Linux kernel 2.6.3-rc2, includes
the Intel Copyright for files: msi.h and msi.c.


 drivers/pci/msi.c |    6 +++++-
 drivers/pci/msi.h |    4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/msi.c b/drivers/pci/msi.c
--- a/drivers/pci/msi.c	Fri Feb 20 10:45:21 2004
+++ b/drivers/pci/msi.c	Fri Feb 20 10:45:21 2004
@@ -1,5 +1,9 @@
 /*
- * linux/drivers/pci/msi.c
+ * File:	msi.c
+ * Purpose:	PCI Message Signaled Interrupt (MSI)
+ *
+ * Copyright (C) 2003-2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  */
 
 #include <linux/mm.h>
diff -Nru a/drivers/pci/msi.h b/drivers/pci/msi.h
--- a/drivers/pci/msi.h	Fri Feb 20 10:45:21 2004
+++ b/drivers/pci/msi.h	Fri Feb 20 10:45:21 2004
@@ -1,6 +1,8 @@
 /*
- *	msi.h
+ * File:	msi.h
  *
+ * Copyright (C) 2003-2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  */
 
 #ifndef MSI_H

