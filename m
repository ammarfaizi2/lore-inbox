Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUKWVOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUKWVOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUKWTId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:08:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52915 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261356AbUKWR75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:59:57 -0500
Date: Tue, 23 Nov 2004 09:59:44 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: ub: flag day - major 180
Message-ID: <20041123095944.3e39683c@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The major 180 has been allocated by LANANA. This is needed for people who
insist on running 2.6 without udev (imagine that).

--- linux-2.6.10-rc2-bk8-ub/drivers/block/ub.c	2004-11-16 17:03:02.000000000 -0800
+++ linux-2.6.10-rc1-ub/drivers/block/ub.c	2004-11-07 19:01:03.000000000 -0800
@@ -36,7 +36,7 @@
 #define DRV_NAME "ub"
 #define DEVFS_NAME DRV_NAME
 
-#define UB_MAJOR 125	/* Stolen from Experimental range for a week - XXX */
+#define UB_MAJOR 180
 
 /*
  * Definitions which have to be scattered once we understand the layout better.
