Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVAYOqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVAYOqM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVAYOqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:46:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22547 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261962AbVAYOkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:40:53 -0500
Date: Tue, 25 Jan 2005 15:40:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       dag@brattli.net
Subject: [2.6 patch] update Dag Brattli's email address
Message-ID: <20050125144046.GJ30909@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the email address of Dag Brattli in kernel 2.6 to his 
current address.

It was already ACK'ed by Dag Brattli.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 31 Aug 2004

 drivers/net/irda/actisys-sir.c        |    4 ++--
 drivers/net/irda/actisys.c            |    6 +++---
 drivers/net/irda/esi-sir.c            |    6 +++---
 drivers/net/irda/esi.c                |    8 ++++----
 drivers/net/irda/girbil-sir.c         |    6 +++---
 drivers/net/irda/girbil.c             |    6 +++---
 drivers/net/irda/irport.c             |    6 +++---
 drivers/net/irda/irport.h             |    6 +++---
 drivers/net/irda/irtty-sir.c          |    4 ++--
 drivers/net/irda/litelink-sir.c       |    6 +++---
 drivers/net/irda/litelink.c           |    6 +++---
 drivers/net/irda/mcp2120-sir.c        |    2 +-
 drivers/net/irda/mcp2120.c            |    2 +-
 drivers/net/irda/nsc-ircc.c           |    8 ++++----
 drivers/net/irda/nsc-ircc.h           |    6 +++---
 drivers/net/irda/old_belkin-sir.c     |    2 +-
 drivers/net/irda/old_belkin.c         |    2 +-
 drivers/net/irda/smsc-ircc2.h         |    2 +-
 drivers/net/irda/tekram-sir.c         |    4 ++--
 drivers/net/irda/tekram.c             |    6 +++---
 drivers/net/irda/w83977af_ir.c        |    6 +++---
 drivers/net/irda/w83977af_ir.h        |    2 +-
 drivers/net/wireless/netwave_cs.c     |    6 +++---
 drivers/usb/serial/ir-usb.c           |    2 +-
 include/linux/irda.h                  |    4 ++--
 include/net/irda/af_irda.h            |    4 ++--
 include/net/irda/crc.h                |    4 ++--
 include/net/irda/discovery.h          |    4 ++--
 include/net/irda/ircomm_core.h        |    4 ++--
 include/net/irda/ircomm_event.h       |    4 ++--
 include/net/irda/ircomm_lmp.h         |    4 ++--
 include/net/irda/ircomm_param.h       |    4 ++--
 include/net/irda/ircomm_ttp.h         |    4 ++--
 include/net/irda/ircomm_tty.h         |    4 ++--
 include/net/irda/ircomm_tty_attach.h  |    4 ++--
 include/net/irda/irda.h               |    4 ++--
 include/net/irda/irda_device.h        |    4 ++--
 include/net/irda/iriap.h              |    6 +++---
 include/net/irda/iriap_event.h        |    6 +++---
 include/net/irda/irias_object.h       |    4 ++--
 include/net/irda/irlan_client.h       |    6 +++---
 include/net/irda/irlan_common.h       |    6 +++---
 include/net/irda/irlan_eth.h          |    4 ++--
 include/net/irda/irlan_event.h        |    6 +++---
 include/net/irda/irlan_filter.h       |    4 ++--
 include/net/irda/irlan_provider.h     |    6 +++---
 include/net/irda/irlap.h              |    6 +++---
 include/net/irda/irlap_event.h        |    6 +++---
 include/net/irda/irlap_frame.h        |    6 +++---
 include/net/irda/irlmp.h              |    6 +++---
 include/net/irda/irlmp_event.h        |    6 +++---
 include/net/irda/irlmp_frame.h        |    6 +++---
 include/net/irda/irmod.h              |    4 ++--
 include/net/irda/irqueue.h            |    4 ++--
 include/net/irda/irttp.h              |    6 +++---
 include/net/irda/parameters.h         |    4 ++--
 include/net/irda/qos.h                |    4 ++--
 include/net/irda/timer.h              |    6 +++---
 include/net/irda/wrapper.h            |    6 +++---
 net/irda/af_irda.c                    |    4 ++--
 net/irda/discovery.c                  |    4 ++--
 net/irda/ircomm/ircomm_core.c         |    4 ++--
 net/irda/ircomm/ircomm_event.c        |    4 ++--
 net/irda/ircomm/ircomm_lmp.c          |    4 ++--
 net/irda/ircomm/ircomm_param.c        |    4 ++--
 net/irda/ircomm/ircomm_ttp.c          |    4 ++--
 net/irda/ircomm/ircomm_tty.c          |    6 +++---
 net/irda/ircomm/ircomm_tty_attach.c   |    4 ++--
 net/irda/ircomm/ircomm_tty_ioctl.c    |    4 ++--
 net/irda/irda_device.c                |    4 ++--
 net/irda/iriap.c                      |    6 +++---
 net/irda/iriap_event.c                |    6 +++---
 net/irda/irias_object.c               |    4 ++--
 net/irda/irlan/irlan_client.c         |    6 +++---
 net/irda/irlan/irlan_client_event.c   |    6 +++---
 net/irda/irlan/irlan_common.c         |    8 ++++----
 net/irda/irlan/irlan_eth.c            |    4 ++--
 net/irda/irlan/irlan_event.c          |    4 ++--
 net/irda/irlan/irlan_filter.c         |    4 ++--
 net/irda/irlan/irlan_provider.c       |    6 +++---
 net/irda/irlan/irlan_provider_event.c |    6 +++---
 net/irda/irlap.c                      |    4 ++--
 net/irda/irlap_frame.c                |    6 +++---
 net/irda/irlmp.c                      |    6 +++---
 net/irda/irlmp_event.c                |    6 +++---
 net/irda/irlmp_frame.c                |    6 +++---
 net/irda/irmod.c                      |    6 +++---
 net/irda/irproc.c                     |    4 ++--
 net/irda/irqueue.c                    |    4 ++--
 net/irda/irsysctl.c                   |    4 ++--
 net/irda/irttp.c                      |    6 +++---
 net/irda/parameters.c                 |    4 ++--
 net/irda/qos.c                        |    6 +++---
 net/irda/timer.c                      |    6 +++---
 net/irda/wrapper.c                    |    6 +++---
 CREDITS                               |    6 +-----
 96 files changed, 233 insertions(+), 237 deletions(-)

--- linux-2.6.9-rc1-mm2-full/CREDITS.old	2004-08-31 22:55:53.000000000 +0200
+++ linux-2.6.9-rc1-mm2-full/CREDITS	2004-08-31 22:56:57.000000000 +0200
@@ -449,12 +449,8 @@
 S: USA
 
 N: Dag Brattli
-E: dagb@cs.uit.no
-W: http://www.cs.uit.no/~dagb
+E: dag@brattli.net
 D: IrDA Subsystem
-S: 19. Wellington Road
-S: Lancaster, LA1 4DN
-S: UK, England
 
 N: Lars Brinkhoff
 E: lars@nocrew.org
--- linux-2.6.9-rc1-mm1-full/drivers/usb/serial/ir-usb.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/usb/serial/ir-usb.c	2004-08-30 23:11:26.000000000 +0200
@@ -40,7 +40,7 @@
  *	Added support for more IrDA USB devices.
  *	Added support for zero packet.  Added buffer override paramater, so
  *	users can transfer larger packets at once if they wish.  Both patches
- *	came from Dag Brattli <dag@obexcode.com>.
+ *	came from Dag Brattli <dag@brattli.net>.
  *
  * 2001_Oct_07	greg kh
  *	initial version released.
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/irtty-sir.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/irtty-sir.c	2004-08-30 23:13:06.000000000 +0200
@@ -4,7 +4,7 @@
  * Version:       2.0
  * Description:   IrDA line discipline implementation
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Dec  9 21:18:38 1997
  * Modified at:   Sun Oct 27 22:13:30 2002
  * Modified by:   Martin Diehl <mad@mdiehl.de>
@@ -642,7 +642,7 @@
 module_init(irtty_sir_init);
 module_exit(irtty_sir_cleanup);
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("IrDA TTY device driver");
 MODULE_ALIAS_LDISC(N_IRDA);
 MODULE_LICENSE("GPL");
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/nsc-ircc.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/nsc-ircc.c	2004-08-31 00:15:32.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       1.0
  * Description:   Driver for the NSC PC'108 and PC'338 IrDA chipsets
  * Status:        Stable.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Nov  7 21:43:15 1998
  * Modified at:   Wed Mar  1 11:29:34 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>
  *     Copyright (c) 1998 Lichen Wang, <lwang@actisys.com>
  *     Copyright (c) 1998 Actisys Corp., www.actisys.com
  *     All Rights Reserved
@@ -2200,7 +2200,7 @@
 	return 0;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("NSC IrDA Device Driver");
 MODULE_LICENSE("GPL");
 
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/girbil.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/girbil.c	2004-08-30 23:13:54.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.2
  * Description:   Implementation for the Greenwich GIrBIL dongle
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Feb  6 21:02:33 1999
  * Modified at:   Fri Dec 17 09:13:20 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *      
@@ -224,7 +224,7 @@
 	return ret;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Greenwich GIrBIL dongle driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-4"); /* IRDA_GIRBIL_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/w83977af_ir.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/w83977af_ir.h	2004-08-30 23:14:03.000000000 +0200
@@ -7,7 +7,7 @@
  * Author:        Paul VanderSpek
  * Created at:    Thu Nov 19 13:55:34 1998
  * Modified at:   Tue Jan 11 13:08:19 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-2000 Dag Brattli, All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/litelink-sir.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/litelink-sir.c	2004-08-30 23:14:19.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.1
  * Description:   Driver for the Parallax LiteLink dongle
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Fri May  7 12:50:33 1999
  * Modified at:   Fri Dec 17 09:14:23 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
@@ -187,7 +187,7 @@
 	return 0;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Parallax Litelink dongle driver");	
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-5"); /* IRDA_LITELINK_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/tekram-sir.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/tekram-sir.c	2004-08-30 23:14:32.000000000 +0200
@@ -4,7 +4,7 @@
  * Version:       1.3
  * Description:   Implementation of the Tekram IrMate IR-210B dongle
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Wed Oct 21 20:02:35 1998
  * Modified at:   Sun Oct 27 22:02:38 2002
  * Modified by:   Martin Diehl <mad@mdiehl.de>
@@ -224,7 +224,7 @@
 	return 0;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Tekram IrMate IR-210B dongle driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-0"); /* IRDA_TEKRAM_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/w83977af_ir.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/w83977af_ir.c	2004-08-30 23:14:50.000000000 +0200
@@ -7,9 +7,9 @@
  * Author:        Paul VanderSpek
  * Created at:    Wed Nov  4 11:46:16 1998
  * Modified at:   Fri Jan 28 12:10:59 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>
  *     Copyright (c) 1998-1999 Rebel.com
  *      
  *     This program is free software; you can redistribute it and/or 
@@ -1350,7 +1350,7 @@
 	return &self->stats;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Winbond W83977AF IrDA Device Driver");
 MODULE_LICENSE("GPL");
 
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/girbil-sir.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/girbil-sir.c	2004-08-30 23:15:04.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.2
  * Description:   Implementation for the Greenwich GIrBIL dongle
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Feb  6 21:02:33 1999
  * Modified at:   Fri Dec 17 09:13:20 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
@@ -249,7 +249,7 @@
 	return (delay > 0) ? delay : ret;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Greenwich GIrBIL dongle driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-4"); /* IRDA_GIRBIL_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/esi.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/esi.c	2004-08-30 23:15:25.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       1.5
  * Description:   Driver for the Extended Systems JetEye PC dongle
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Feb 21 18:54:38 1998
  * Modified at:   Fri Dec 17 09:14:04 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1999 Dag Brattli, <dagb@cs.uit.no>,
+ *     Copyright (c) 1999 Dag Brattli, <dag@brattli.net>,
  *     Copyright (c) 1998 Thomas Davis, <ratbert@radiks.net>,
  *     All Rights Reserved.
  *     
@@ -126,7 +126,7 @@
 	return 0;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Extended Systems JetEye PC dongle driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-1"); /* IRDA_ESI_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/smsc-ircc2.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/smsc-ircc2.h	2004-08-30 23:15:33.000000000 +0200
@@ -10,7 +10,7 @@
  *
  * Based on smc-ircc.h:
  * 
- *     Copyright (c) 1999-2000, Dag Brattli <dagb@cs.uit.no>
+ *     Copyright (c) 1999-2000, Dag Brattli <dag@brattli.net>
  *     Copyright (c) 1998-1999, Thomas Davis (tadavis@jps.net>
  *     All Rights Reserved
  *
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/tekram.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/tekram.c	2004-08-30 23:15:50.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.2
  * Description:   Implementation of the Tekram IrMate IR-210B dongle
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Wed Oct 21 20:02:35 1998
  * Modified at:   Fri Dec 17 09:13:09 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
  *      
@@ -257,7 +257,7 @@
 	return ret;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Tekram IrMate IR-210B dongle driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-0"); /* IRDA_TEKRAM_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/litelink.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/litelink.c	2004-08-30 23:16:06.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.1
  * Description:   Driver for the Parallax LiteLink dongle
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Fri May  7 12:50:33 1999
  * Modified at:   Fri Dec 17 09:14:23 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
@@ -157,7 +157,7 @@
 	return 0;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Parallax Litelink dongle driver");	
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-5"); /* IRDA_LITELINK_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/nsc-ircc.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/nsc-ircc.h	2004-08-30 23:16:27.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Fri Nov 13 14:37:40 1998
  * Modified at:   Sun Jan 23 17:47:00 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>
  *     Copyright (c) 1998 Lichen Wang, <lwang@actisys.com>
  *     Copyright (c) 1998 Actisys Corp., www.actisys.com
  *     All Rights Reserved
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/actisys-sir.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/actisys-sir.c	2004-08-30 23:16:44.000000000 +0200
@@ -5,7 +5,7 @@
  * Description:   Implementation for the ACTiSYS IR-220L and IR-220L+ 
  *                dongles
  * Status:        Beta.
- * Authors:       Dag Brattli <dagb@cs.uit.no> (initially)
+ * Authors:       Dag Brattli <dag@brattli.net> (initially)
  *		  Jean Tourrilhes <jt@hpl.hp.com> (new version)
  *		  Martin Diehl <mad@mdiehl.de> (new version for sir_dev)
  * Created at:    Wed Oct 21 20:02:35 1998
@@ -236,7 +236,7 @@
 	return 0;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> - Jean Tourrilhes <jt@hpl.hp.com>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net> - Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("ACTiSYS IR-220L and IR-220L+ dongle driver");	
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-2"); /* IRDA_ACTISYS_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/irport.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/irport.h	2004-08-30 23:17:14.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.1
  * Description:   Serial driver for IrDA
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug  3 13:49:59 1997
  * Modified at:   Fri Jan 14 10:21:10 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1997, 1998-2000 Dag Brattli <dagb@cs.uit.no>
+ *     Copyright (c) 1997, 1998-2000 Dag Brattli <dag@brattli.net>
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/irport.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/irport.c	2004-08-30 23:17:29.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:	  1.0
  * Description:   Half duplex serial port SIR driver for IrDA. 
  * Status:	  Experimental.
- * Author:	  Dag Brattli <dagb@cs.uit.no>
+ * Author:	  Dag Brattli <dag@brattli.net>
  * Created at:	  Sun Aug  3 13:49:59 1997
  * Modified at:   Fri Jan 28 20:22:38 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Sources:	  serial.c by Linus Torvalds 
  * 
  *     Copyright (c) 1997, 1998, 1999-2000 Dag Brattli, All Rights Reserved.
@@ -1139,7 +1139,7 @@
 MODULE_PARM(irq, "1-4i");
 MODULE_PARM_DESC(irq, "IRQ lines");
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Half duplex serial driver for IrDA SIR mode");
 MODULE_LICENSE("GPL");
 
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/mcp2120-sir.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/mcp2120-sir.c	2004-08-30 23:17:37.000000000 +0200
@@ -7,7 +7,7 @@
  * Status:        Experimental.
  * Author:        Felix Tang (tangf@eyetap.org)
  * Created at:    Sun Mar 31 19:32:12 EST 2002
- * Based on code by:   Dag Brattli <dagb@cs.uit.no>
+ * Based on code by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 2002 Felix Tang, All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/old_belkin-sir.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/old_belkin-sir.c	2004-08-30 23:17:44.000000000 +0200
@@ -7,7 +7,7 @@
  * Author:        Jean Tourrilhes <jt@hpl.hp.com>
  * Created at:    22/11/99
  * Modified at:   Fri Dec 17 09:13:32 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Jean Tourrilhes, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/old_belkin.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/old_belkin.c	2004-08-30 23:17:51.000000000 +0200
@@ -7,7 +7,7 @@
  * Author:        Jean Tourrilhes <jt@hpl.hp.com>
  * Created at:    22/11/99
  * Modified at:   Fri Dec 17 09:13:32 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Jean Tourrilhes, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/mcp2120.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/mcp2120.c	2004-08-30 23:17:57.000000000 +0200
@@ -7,7 +7,7 @@
  * Status:        Experimental.
  * Author:        Felix Tang (tangf@eyetap.org)
  * Created at:    Sun Mar 31 19:32:12 EST 2002
- * Based on code by:   Dag Brattli <dagb@cs.uit.no>
+ * Based on code by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 2002 Felix Tang, All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/actisys.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/actisys.c	2004-08-30 23:18:13.000000000 +0200
@@ -5,11 +5,11 @@
  * Description:   Implementation for the ACTiSYS IR-220L and IR-220L+ 
  *                dongles
  * Status:        Beta.
- * Authors:       Dag Brattli <dagb@cs.uit.no> (initially)
+ * Authors:       Dag Brattli <dag@brattli.net> (initially)
  *		  Jean Tourrilhes <jt@hpl.hp.com> (new version)
  * Created at:    Wed Oct 21 20:02:35 1998
  * Modified at:   Fri Dec 17 09:10:43 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 1999 Jean Tourrilhes
@@ -263,7 +263,7 @@
 	return ret;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> - Jean Tourrilhes <jt@hpl.hp.com>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net> - Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("ACTiSYS IR-220L and IR-220L+ dongle driver");	
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-2"); /* IRDA_ACTISYS_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/irda/esi-sir.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/irda/esi-sir.c	2004-08-30 23:18:30.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       1.6
  * Description:   Driver for the Extended Systems JetEye PC dongle
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Feb 21 18:54:38 1998
  * Modified at:   Sun Oct 27 22:01:04 2002
  * Modified by:   Martin Diehl <mad@mdiehl.de>
  * 
- *     Copyright (c) 1999 Dag Brattli, <dagb@cs.uit.no>,
+ *     Copyright (c) 1999 Dag Brattli, <dag@brattli.net>,
  *     Copyright (c) 1998 Thomas Davis, <ratbert@radiks.net>,
  *     Copyright (c) 2002 Martin Diehl, <mad@mdiehl.de>,
  *     All Rights Reserved.
@@ -149,7 +149,7 @@
 	return 0;
 }
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("Extended Systems JetEye PC dongle driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("irda-dongle-1"); /* IRDA_ESI_DONGLE */
--- linux-2.6.9-rc1-mm1-full/drivers/net/wireless/netwave_cs.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/wireless/netwave_cs.c	2004-08-30 23:18:47.000000000 +0200
@@ -5,11 +5,11 @@
  * Description:   Netwave AirSurfer Wireless LAN PC Card driver
  * Status:        Experimental.
  * Authors:       John Markus Bjørndalen <johnm@cs.uit.no>
- *                Dag Brattli <dagb@cs.uit.no>
+ *                Dag Brattli <dag@brattli.net>
  *                David Hinds <dahinds@users.sourceforge.net>
  * Created at:    A long time ago!
  * Modified at:   Mon Nov 10 11:54:37 1997
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1997 University of Tromsø, Norway
  *
@@ -21,7 +21,7 @@
  *      multiple packets per interrupt). 
  *    - Cleaned up parts of newave_hw_xmit. 
  *    - A few general cleanups. 
- *   24-Oct-97 13:17:36   Dag Brattli <dagb@cs.uit.no>
+ *   24-Oct-97 13:17:36   Dag Brattli <dag@brattli.net>
  *    - Fixed netwave_rx receive function (got updated docs)
  *   Others:
  *    - Changed name from xircnw to netwave, take a look at 
--- linux-2.6.9-rc1-mm1-full/include/linux/irda.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/linux/irda.h	2004-08-30 23:18:58.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Mar  8 14:06:12 1999
  * Modified at:   Sat Dec 25 16:06:42 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlap_event.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlap_event.h	2004-08-30 23:19:13.000000000 +0200
@@ -5,12 +5,12 @@
  * Version:       0.1
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Aug 16 00:59:29 1997
  * Modified at:   Tue Dec 21 11:20:30 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/timer.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/timer.h	2004-08-30 23:19:29.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Aug 16 00:59:29 1997
  * Modified at:   Thu Oct  7 12:25:24 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1997, 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1997, 1998-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlmp.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlmp.h	2004-08-30 23:19:43.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.9
  * Description:   IrDA Link Management Protocol (LMP) layer
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 17 20:54:32 1997
  * Modified at:   Fri Dec 10 13:23:01 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/parameters.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/parameters.h	2004-08-30 23:19:53.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   A more general way to handle (pi,pl,pv) parameters
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Jun  7 08:47:28 1999
  * Modified at:   Sun Jan 30 14:05:14 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/qos.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/qos.h	2004-08-30 23:20:03.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   Quality of Service definitions
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Fri Sep 19 23:21:09 1997
  * Modified at:   Thu Dec  2 13:51:54 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_filter.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_filter.h	2004-08-30 23:20:22.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Fri Jan 29 15:24:08 1999
  * Modified at:   Sun Feb  7 23:35:31 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998 Dag Brattli, All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irttp.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irttp.h	2004-08-30 23:20:39.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       1.0
  * Description:   Tiny Transport Protocol (TTP) definitions
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:31 1997
  * Modified at:   Sun Dec 12 13:09:07 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/iriap.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/iriap.h	2004-08-30 23:20:55.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.5
  * Description:   Information Access Protocol (IAP)
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Thu Aug 21 00:02:07 1997
  * Modified at:   Sat Dec 25 16:42:09 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1997-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1997-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlmp_frame.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlmp_frame.h	2004-08-30 23:21:10.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.9
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Aug 19 02:09:59 1997
  * Modified at:   Fri Dec 10 13:21:53 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1997, 1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1997, 1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
--- linux-2.6.9-rc1-mm1-full/include/net/irda/crc.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/crc.h	2004-08-30 23:21:40.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   CRC routines
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Sun May  2 20:25:23 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  ********************************************************************/
 
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irda.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irda.h	2004-08-30 23:21:50.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   IrDA common include file for kernel internal use
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Dec  9 21:13:12 1997
  * Modified at:   Fri Jan 28 13:16:32 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-2000 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/include/net/irda/iriap_event.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/iriap_event.h	2004-08-30 23:22:09.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Sun Oct 31 22:02:54 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, All Rights Reserved.
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
--- linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_lmp.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_lmp.h	2004-08-30 23:22:20.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Wed Jun  9 10:06:07 1999
  * Modified at:   Fri Aug 13 07:32:32 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_tty.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_tty.h	2004-08-30 23:22:29.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Jun  6 23:24:22 1999
  * Modified at:   Fri Jan 28 13:16:57 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_event.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_event.h	2004-08-30 23:22:39.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Jun  6 23:51:13 1999
  * Modified at:   Thu Jun 10 08:36:25 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_event.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_event.h	2004-08-30 23:22:54.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       
  * Description:   LAN access
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:37 1997
  * Modified at:   Tue Feb  2 09:45:17 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1997 Dag Brattli <dagb@cs.uit.no>, All Rights Reserved.
+ *     Copyright (c) 1997 Dag Brattli <dag@brattli.net>, All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlap_frame.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlap_frame.h	2004-08-30 23:23:15.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.9
  * Description:   IrLAP frame declarations
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Aug 19 10:27:26 1997
  * Modified at:   Sat Dec 25 21:07:26 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1997-1999 Dag Brattli <dagb@cs.uit.no>,
+ *     Copyright (c) 1997-1999 Dag Brattli <dag@brattli.net>,
  *     All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/wrapper.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/wrapper.h	2004-08-30 23:23:29.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       1.2
  * Description:   IrDA SIR async wrapper layer
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Tue Jan 11 12:37:29 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_eth.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_eth.h	2004-08-30 23:23:38.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Thu Oct 15 08:36:58 1998
  * Modified at:   Fri May 14 23:29:00 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/include/net/irda/discovery.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/discovery.h	2004-08-30 23:23:47.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Apr  6 16:53:53 1999
  * Modified at:   Tue Oct  5 10:05:10 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_ttp.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_ttp.h	2004-08-30 23:23:58.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Wed Jun  9 10:06:07 1999
  * Modified at:   Fri Aug 13 07:32:22 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_common.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_common.h	2004-08-30 23:24:13.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.8
  * Description:   IrDA LAN access layer
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:37 1997
  * Modified at:   Sun Oct 31 19:41:24 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
--- linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_core.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_core.h	2004-08-30 23:24:23.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Wed Jun  9 08:58:43 1999
  * Modified at:   Mon Dec 13 11:52:29 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_client.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_client.h	2004-08-30 23:24:47.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.3
  * Description:   IrDA LAN access layer
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:37 1997
  * Modified at:   Thu Apr 22 14:13:34 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998 Dag Brattli <dagb@cs.uit.no>, All Rights Reserved.
+ *     Copyright (c) 1998 Dag Brattli <dag@brattli.net>, All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_provider.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlan_provider.h	2004-08-30 23:25:04.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.1
  * Description:   IrDA LAN access layer
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:37 1997
  * Modified at:   Sun May  9 12:26:11 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, All Rights Reserved.
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
--- linux-2.6.9-rc1-mm1-full/include/net/irda/af_irda.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/af_irda.h	2004-08-30 23:25:16.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   IrDA sockets declarations
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Dec  9 21:13:12 1997
  * Modified at:   Fri Jan 28 13:16:32 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-2000 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irqueue.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irqueue.h	2004-08-30 23:25:31.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       0.3
  * Description:   General queue implementation
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Jun  9 13:26:50 1998
  * Modified at:   Thu Oct  7 13:25:16 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (C) 1998-1999, Aage Kvalnes <aage@cs.uit.no>
  *     Copyright (c) 1998, Dag Brattli
--- linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_tty_attach.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_tty_attach.h	2004-08-30 23:25:42.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Wed Jun  9 15:55:18 1999
  * Modified at:   Fri Dec 10 21:04:55 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_param.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/ircomm_param.h	2004-08-30 23:25:52.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   Parameter handling for the IrCOMM protocol
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Jun  7 08:47:28 1999
  * Modified at:   Wed Aug 25 13:46:33 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irias_object.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irias_object.h	2004-08-30 23:26:02.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Thu Oct  1 22:49:50 1998
  * Modified at:   Wed Dec 15 11:20:57 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irmod.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irmod.h	2004-08-30 23:26:12.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       0.3
  * Description:   IrDA module and utilities functions
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Dec 15 13:58:52 1997
  * Modified at:   Fri Jan 28 13:15:24 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
  *     Copyright (c) 1998-2000 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlmp_event.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlmp_event.h	2004-08-30 23:26:28.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.1
  * Description:   IrDA-LMP event handling
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Thu Jul  8 12:18:54 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1997, 1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1997, 1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irda_device.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irda_device.h	2004-08-30 23:26:38.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       0.9
  * Description:   Contains various declarations used by the drivers
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Apr 14 12:41:42 1998
  * Modified at:   Mon Mar 20 09:08:57 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 1998 Thomas Davis, <ratbert@radiks.net>,
--- linux-2.6.9-rc1-mm1-full/include/net/irda/irlap.h.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/include/net/irda/irlap.h	2004-08-30 23:26:51.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.8
  * Description:   An IrDA LAP driver for Linux
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Fri Dec 10 13:21:17 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_tty_ioctl.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_tty_ioctl.c	2004-08-30 23:27:02.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Thu Jun 10 14:39:09 1999
  * Modified at:   Wed Jan  5 14:45:43 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_lmp.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_lmp.c	2004-08-30 23:27:12.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   Interface between IrCOMM and IrLMP
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Jun  6 20:48:27 1999
  * Modified at:   Sun Dec 12 13:44:17 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Sources:       Previous IrLPT work by Thomas Davis
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
--- linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_tty.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_tty.c	2004-08-30 23:27:28.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   IrCOMM serial TTY driver
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Jun  6 21:00:56 1999
  * Modified at:   Wed Feb 23 00:09:02 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Sources:       serial.c and previous IrCOMM work by Takahide Higuchi
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
@@ -1415,7 +1415,7 @@
 }
 #endif /* CONFIG_PROC_FS */
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("IrCOMM serial TTY driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV_MAJOR(IRCOMM_TTY_MAJOR);
--- linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_event.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_event.c	2004-08-30 23:27:38.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   IrCOMM layer state machine
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Jun  6 20:33:11 1999
  * Modified at:   Sun Dec 12 13:44:32 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_param.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_param.c	2004-08-30 23:27:48.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   Parameter handling for the IrCOMM protocol
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Jun  7 10:25:11 1999
  * Modified at:   Sun Jan 30 14:32:03 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
  *     
--- linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_tty_attach.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_tty_attach.c	2004-08-30 23:27:59.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   Code for attaching the serial driver to IrCOMM
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Jun  5 17:42:00 1999
  * Modified at:   Tue Jan  4 14:20:49 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_ttp.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_ttp.c	2004-08-30 23:28:10.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   Interface between IrCOMM and IrTTP
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Jun  6 20:48:27 1999
  * Modified at:   Mon Dec 13 11:35:13 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_core.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/ircomm/ircomm_core.c	2004-08-30 23:28:25.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   IrCOMM service interface
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Jun  6 20:37:34 1999
  * Modified at:   Tue Dec 21 13:26:41 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/net/irda/irqueue.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irqueue.c	2004-08-30 23:28:37.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       0.3
  * Description:   General queue implementation
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Jun  9 13:29:31 1998
  * Modified at:   Sun Dec 12 13:48:22 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Modified at:   Thu Jan  4 14:29:10 CET 2001
  * Modified by:   Marc Zyngier <mzyngier@freesurf.fr>
  * 
--- linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_eth.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_eth.c	2004-08-30 23:28:47.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Thu Oct 15 08:37:58 1998
  * Modified at:   Tue Mar 21 09:06:41 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Sources:       skeleton.c by Donald Becker <becker@CESDIS.gsfc.nasa.gov>
  *                slip.c by Laurence Culhane,   <loz@holmes.demon.co.uk>
  *                          Fred N. van Kempen, <waltje@uwalt.nl.mugnet.org>
--- linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_client_event.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_client_event.c	2004-08-30 23:29:00.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.9
  * Description:   IrLAN client state machine
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:37 1997
  * Modified at:   Sun Dec 26 21:52:24 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
--- linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_provider.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_provider.c	2004-08-30 23:29:15.000000000 +0200
@@ -4,15 +4,15 @@
  * Version:       0.9
  * Description:   IrDA LAN Access Protocol Implementation
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:37 1997
  * Modified at:   Sat Oct 30 12:52:10 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Sources:       skeleton.c by Donald Becker <becker@CESDIS.gsfc.nasa.gov>
  *                slip.c by Laurence Culhane,   <loz@holmes.demon.co.uk>
  *                          Fred N. van Kempen, <waltje@uwalt.nl.mugnet.org>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
--- linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_common.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_common.c	2004-08-30 23:29:54.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.9
  * Description:   IrDA LAN Access Protocol Implementation
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:37 1997
  * Modified at:   Sun Dec 26 21:53:10 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1997, 1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1997, 1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
@@ -1178,7 +1178,7 @@
 }
 #endif
 
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net>");
 MODULE_DESCRIPTION("The Linux IrDA LAN protocol"); 
 MODULE_LICENSE("GPL");
 
--- linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_client.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_client.c	2004-08-30 23:30:09.000000000 +0200
@@ -4,15 +4,15 @@
  * Version:       0.9
  * Description:   IrDA LAN Access Protocol (IrLAN) Client
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:37 1997
  * Modified at:   Tue Dec 14 15:47:02 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Sources:       skeleton.c by Donald Becker <becker@CESDIS.gsfc.nasa.gov>
  *                slip.c by Laurence Culhane, <loz@holmes.demon.co.uk>
  *                          Fred N. van Kempen, <waltje@uwalt.nl.mugnet.org>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
--- linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_provider_event.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_provider_event.c	2004-08-30 23:30:26.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.9
  * Description:   IrLAN provider state machine)
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:37 1997
  * Modified at:   Sat Oct 30 12:52:41 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>, All Rights Reserved.
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>, All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
--- linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_event.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_event.c	2004-08-30 23:30:55.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Oct 20 09:10:16 1998
  * Modified at:   Sat Oct 30 12:59:01 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_filter.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlan/irlan_filter.c	2004-08-30 23:31:04.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Fri Jan 29 11:16:38 1999
  * Modified at:   Sat Oct 30 12:58:45 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/net/irda/irlmp_event.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlmp_event.c	2004-08-30 23:31:18.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.8
  * Description:   An IrDA LMP event driver for Linux
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Tue Dec 14 23:04:16 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>,
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>,
  *     All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
--- linux-2.6.9-rc1-mm1-full/net/irda/discovery.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/discovery.c	2004-08-30 23:31:28.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       0.1
  * Description:   Routines for handling discoveries at the IrLMP layer
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Apr  6 15:33:50 1999
  * Modified at:   Sat Oct  9 17:11:31 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Modified at:   Fri May 28  3:11 CST 1999
  * Modified by:   Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
  * 
--- linux-2.6.9-rc1-mm1-full/net/irda/irlap_frame.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlap_frame.c	2004-08-30 23:31:42.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       1.0
  * Description:   Build and transmit IrLAP frames
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Aug 19 10:27:26 1997
  * Modified at:   Wed Jan  5 08:59:04 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>,
  *     All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
--- linux-2.6.9-rc1-mm1-full/net/irda/iriap.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/iriap.c	2004-08-30 23:32:11.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.8
  * Description:   Information Access Protocol (IAP)
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Thu Aug 21 00:02:07 1997
  * Modified at:   Sat Dec 25 16:42:42 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>,
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>,
  *     All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
--- linux-2.6.9-rc1-mm1-full/net/irda/af_irda.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/af_irda.c	2004-08-30 23:32:23.000000000 +0200
@@ -4,13 +4,13 @@
  * Version:       0.9
  * Description:   IrDA sockets implementation
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun May 31 10:12:43 1998
  * Modified at:   Sat Dec 25 21:10:23 1999
  * Modified by:   Dag Brattli <dag@brattli.net>
  * Sources:       af_netroom.c, af_ax25.c, af_rose.c, af_x25.c etc.
  *
- *     Copyright (c) 1999 Dag Brattli <dagb@cs.uit.no>
+ *     Copyright (c) 1999 Dag Brattli <dag@brattli.net>
  *     Copyright (c) 1999-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     All Rights Reserved.
  *
--- linux-2.6.9-rc1-mm1-full/net/irda/irsysctl.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irsysctl.c	2004-08-30 23:32:31.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   Sysctl interface for IrDA
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun May 24 22:12:06 1998
  * Modified at:   Fri Jun  4 02:50:15 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1997, 1999 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/net/irda/irda_device.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irda_device.c	2004-08-30 23:32:41.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       0.9
  * Description:   Utility functions used by the device drivers
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Oct  9 09:22:27 1999
  * Modified at:   Sun Jan 23 17:41:24 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/net/irda/timer.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/timer.c	2004-08-30 23:32:55.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       
  * Description:   
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sat Aug 16 00:59:29 1997
  * Modified at:   Wed Dec  8 12:50:34 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1997, 1999 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1997, 1999 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/net/irda/irttp.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irttp.c	2004-08-30 23:33:10.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       1.2
  * Description:   Tiny Transport Protocol (TTP) implementation
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 31 20:14:31 1997
  * Modified at:   Wed Jan  5 11:31:27 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/net/irda/irias_object.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irias_object.c	2004-08-30 23:33:19.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       0.3
  * Description:   IAS object database and functions
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Thu Oct  1 22:50:04 1998
  * Modified at:   Wed Dec 15 11:23:16 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
  *
--- linux-2.6.9-rc1-mm1-full/net/irda/irlmp_frame.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlmp_frame.c	2004-08-30 23:33:31.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.9
  * Description:   IrLMP frame implementation
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Aug 19 02:09:59 1997
  * Modified at:   Mon Dec 13 13:41:12 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>
+ *     Copyright (c) 1998-1999 Dag Brattli <dag@brattli.net>
  *     All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/net/irda/parameters.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/parameters.c	2004-08-30 23:33:39.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   A more general way to handle (pi,pl,pv) parameters
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Jun  7 10:25:11 1999
  * Modified at:   Sun Jan 30 14:08:39 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
  *
--- linux-2.6.9-rc1-mm1-full/net/irda/iriap_event.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/iriap_event.c	2004-08-30 23:34:00.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       0.1
  * Description:   IAP Finite State Machine
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Thu Aug 21 00:02:07 1997
  * Modified at:   Wed Mar  1 11:28:34 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
- *     Copyright (c) 1997, 1999-2000 Dag Brattli <dagb@cs.uit.no>,
+ *     Copyright (c) 1997, 1999-2000 Dag Brattli <dag@brattli.net>,
  *     All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
--- linux-2.6.9-rc1-mm1-full/net/irda/irmod.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irmod.c	2004-08-30 23:34:14.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       0.9
  * Description:   IrDA stack main entry points
  * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Dec 15 13:55:39 1997
  * Modified at:   Wed Jan  5 15:12:41 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
  *     Copyright (c) 1997, 1999-2000 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2004 Jean Tourrilhes <jt@hpl.hp.com>
@@ -179,7 +179,7 @@
 subsys_initcall(irda_init);
 module_exit(irda_cleanup);
  
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> & Jean Tourrilhes <jt@hpl.hp.com>");
+MODULE_AUTHOR("Dag Brattli <dag@brattli.net> & Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("The Linux IrDA Protocol Stack"); 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_IRDA);
--- linux-2.6.9-rc1-mm1-full/net/irda/qos.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/qos.c	2004-08-30 23:34:27.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       1.0
  * Description:   IrLAP QoS parameter negotiation
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Tue Sep  9 00:00:26 1997
  * Modified at:   Sun Jan 30 14:29:16 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * 
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>, 
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>, 
  *     All Rights Reserved.
  *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
  *     
--- linux-2.6.9-rc1-mm1-full/net/irda/irlmp.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlmp.c	2004-08-30 23:34:40.000000000 +0200
@@ -4,12 +4,12 @@
  * Version:       1.0
  * Description:   IrDA Link Management Protocol (LMP) layer
  * Status:        Stable.
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Sun Aug 17 20:54:32 1997
  * Modified at:   Wed Jan  5 11:26:03 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>,
  *     All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
  *
--- linux-2.6.9-rc1-mm1-full/net/irda/irlap.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irlap.c	2004-08-30 23:34:48.000000000 +0200
@@ -4,10 +4,10 @@
  * Version:       1.0
  * Description:   IrLAP implementation for Linux
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Tue Dec 14 09:26:44 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2003 Jean Tourrilhes <jt@hpl.hp.com>
--- linux-2.6.9-rc1-mm1-full/net/irda/irproc.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/irproc.c	2004-08-30 23:35:00.000000000 +0200
@@ -7,9 +7,9 @@
  * Author:        Thomas Davis, <ratbert@radiks.net>
  * Created at:    Sat Feb 21 21:33:24 1998
  * Modified at:   Sun Nov 14 08:54:54 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  *
- *     Copyright (c) 1998-1999, Dag Brattli <dagb@cs.uit.no>
+ *     Copyright (c) 1998-1999, Dag Brattli <dag@brattli.net>
  *     Copyright (c) 1998, Thomas Davis, <ratbert@radiks.net>, 
  *     All Rights Reserved.
  *      
--- linux-2.6.9-rc1-mm1-full/net/irda/wrapper.c.old	2004-08-30 23:10:32.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/net/irda/wrapper.c	2004-08-30 23:35:16.000000000 +0200
@@ -4,14 +4,14 @@
  * Version:       1.2
  * Description:   IrDA SIR async wrapper layer
  * Status:        Stable
- * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Author:        Dag Brattli <dag@brattli.net>
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Fri Jan 28 13:21:09 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Modified at:   Fri May 28  3:11 CST 1999
  * Modified by:   Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
  *
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>,
  *     All Rights Reserved.
  *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *
