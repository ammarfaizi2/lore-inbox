Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUGRMNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUGRMNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 08:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUGRMNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 08:13:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50431 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263824AbUGRMNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 08:13:17 -0400
Date: Sun, 18 Jul 2004 14:13:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: dwmw2@redhat.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch] MAINTAINERS: update MTD list
Message-ID: <20040718121311.GX14733@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to send an email to mtd@infradead.org gives you the answer that 
you should use linux-mtd@lists.infradead.org instead.

So let's update the entry in MAINTAINERS.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc2-full/MAINTAINERS.old	2004-07-18 14:03:04.000000000 +0200
+++ linux-2.6.8-rc2-full/MAINTAINERS	2004-07-18 14:05:59.000000000 +0200
@@ -1373,9 +1373,9 @@
 MEMORY TECHNOLOGY DEVICES
 P:	David Woodhouse
 M:	dwmw2@redhat.com
 W:	http://www.linux-mtd.infradead.org/
-L:	mtd@infradead.org
+L:	linux-mtd@lists.infradead.org
 S:	Maintained
 
 MICROTEK X6 SCANNER
 P:	Oliver Neukum

