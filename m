Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVBFUWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVBFUWX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 15:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVBFUWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 15:22:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63238 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261307AbVBFUWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 15:22:13 -0500
Date: Sun, 6 Feb 2005 21:22:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DVB: remove bouncing address of Alex Woods
Message-ID: <20050206202208.GC3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the bouncing email address linux-dvb@giblets.org of
Alex Woods.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/ttusb-dec/ttusb_dec.c  |    4 ++--
 drivers/media/dvb/ttusb-dec/ttusbdecfe.c |    2 +-
 drivers/media/dvb/ttusb-dec/ttusbdecfe.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.h.old	2005-02-06 21:18:09.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.h	2005-02-06 21:18:31.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * TTUSB DEC Driver
  *
- * Copyright (C) 2003-2004 Alex Woods <linux-dvb@giblets.org>
+ * Copyright (C) 2003-2004 Alex Woods
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
--- linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusb_dec.c.old	2005-02-06 21:18:43.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-02-06 21:18:53.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * TTUSB DEC Driver
  *
- * Copyright (C) 2003-2004 Alex Woods <linux-dvb@giblets.org>
+ * Copyright (C) 2003-2004 Alex Woods
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1583,7 +1583,7 @@
 module_init(ttusb_dec_init);
 module_exit(ttusb_dec_exit);
 
-MODULE_AUTHOR("Alex Woods <linux-dvb@giblets.org>");
+MODULE_AUTHOR("Alex Woods");
 MODULE_DESCRIPTION(DRIVER_NAME);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(usb, ttusb_dec_table);
--- linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.c.old	2005-02-06 21:19:01.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/media/dvb/ttusb-dec/ttusbdecfe.c	2005-02-06 21:19:06.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * TTUSB DEC Frontend Driver
  *
- * Copyright (C) 2003-2004 Alex Woods <linux-dvb@giblets.org>
+ * Copyright (C) 2003-2004 Alex Woods
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by







































