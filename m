Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSHFQFi>; Tue, 6 Aug 2002 12:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSHFQFi>; Tue, 6 Aug 2002 12:05:38 -0400
Received: from p50886F8E.dip.t-dialin.net ([80.136.111.142]:58838 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S312619AbSHFQFh>; Tue, 6 Aug 2002 12:05:37 -0400
Date: Tue, 6 Aug 2002 10:09:10 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH][2.5] Rename James Simmons... ;-)
Message-ID: <Pine.LNX.4.44.0208061006250.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes all cases where I met James Simmons to his new mail 
address...

diff -Nur -x SCCS -x *~ linus-2.5/drivers/input/power.c simmy-2.5/drivers/input/power.c
--- linus-2.5/drivers/input/power.c	Wed Jul 31 16:38:36 2002
+++ simmy-2.5/drivers/input/power.c	Tue Aug  6 10:02:37 2002
@@ -24,7 +24,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <jsimmons@transvirtual.com>.
+ * e-mail - mail your message to <jsimmons@users.sf.net>.
  */
 
 #include <linux/module.h>
@@ -176,5 +176,5 @@
 module_init(power_init);
 module_exit(power_exit);
 
-MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
+MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
 MODULE_DESCRIPTION("Input Power Management driver");
diff -Nur -x SCCS -x *~ linus-2.5/drivers/input/touchscreen/h3600_ts_input.c simmy-2.5/drivers/input/touchscreen/h3600_ts_input.c
--- linus-2.5/drivers/input/touchscreen/h3600_ts_input.c	Wed Jul 31 16:38:37 2002
+++ simmy-2.5/drivers/input/touchscreen/h3600_ts_input.c	Tue Aug  6 10:00:46 2002
@@ -1,7 +1,7 @@
 /*
  * $Id: h3600_ts_input.c,v 1.4 2002/01/23 06:39:37 jsimmons Exp $
  *
- *  Copyright (c) 2001 "Crazy" James Simmons jsimmons@transvirtual.com 
+ *  Copyright (c) 2001 "Crazy" James Simmons <jsimmons@users.sf.net>
  *
  *  Sponsored by Transvirtual Technology. 
  * 
@@ -28,7 +28,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  * Should you need to contact me, the author, you can do so by
- * e-mail - mail your message to <jsimmons@transvirtual.com>.
+ * e-mail - mail your message to <jsimmons@users.sf.net>.
  */
 
 #include <linux/errno.h>
diff -Nur -x SCCS -x *~ linus-2.5/drivers/input/tsdev.c simmy-2.5/drivers/input/tsdev.c
--- linus-2.5/drivers/input/tsdev.c	Wed Jul 31 16:38:36 2002
+++ simmy-2.5/drivers/input/tsdev.c	Tue Aug  6 10:01:56 2002
@@ -24,7 +24,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  * 
  * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <jsimmons@transvirtual.com>.
+ * e-mail - mail your message to <jsimmons@users.sf.net>.
  */
 
 #define TSDEV_MINOR_BASE 	128
@@ -435,7 +435,7 @@
 module_init(tsdev_init);
 module_exit(tsdev_exit);
 
-MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
+MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
 MODULE_DESCRIPTION("Input driver to touchscreen converter");
 MODULE_PARM(xres, "i");
 MODULE_PARM_DESC(xres, "Horizontal screen resolution");
diff -Nur -x SCCS -x *~ linus-2.5/drivers/video/skeletonfb.c simmy-2.5/drivers/video/skeletonfb.c
--- linus-2.5/drivers/video/skeletonfb.c	Wed Jul 31 16:39:07 2002
+++ simmy-2.5/drivers/video/skeletonfb.c	Tue Aug  6 10:03:01 2002
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/video/skeletonfb.c -- Skeleton for a frame buffer device
  *
- *  Modified to new api Jan 2001 by James Simmons (jsimmons@transvirtual.com)
+ *  Modified to new api Jan 2001 by James Simmons (jsimmons@users.sf.net)
  *
  *  Created 28 Dec 1997 by Geert Uytterhoeven
  *

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

