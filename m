Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269101AbUHaWSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269101AbUHaWSq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUHaWRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:17:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53234 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268443AbUHaWOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:14:05 -0400
Date: Wed, 1 Sep 2004 00:13:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pedro_m@yahoo.com
Subject: [patch] update email address of Pedro Roque Marques (fwd)
Message-ID: <20040831221353.GX3466@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch forwarded below still applies against 2.6.9-rc1-mm2.

Please apply.

TIA
Adrian

BTW: This patch is already included in Marcelo's 2.4 tree.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Fri, 6 Aug 2004 22:08:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pedro_m@yahoo.com
Subject: [patch] update email address of Pedro Roque Marques (fwd)


The trivial patch forwarded below still applies against 2.6.8-rc3-mm1.

Please apply.

TIA
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Thu, 15 Jul 2004 23:08:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, pedro_m@yahoo.com
Subject: [patch] update email address of Pedro Roque Marques

I tried to send a Cc of a patch in a file in the Linux kernel that is
credited to Pedro Roque Marques, but the email bounced.

The patch below (already ACK'ed by Pedro Roque Marques) updates his 
email address. It applies against both 2.4 and 2.6 .

diffstat output:
 Documentation/isdn/CREDITS      |    2 +-
 Documentation/isdn/README.pcbit |    2 +-
 drivers/isdn/pcbit/callbacks.c  |    2 +-
 drivers/isdn/pcbit/callbacks.h  |    2 +-
 drivers/isdn/pcbit/capi.c       |    2 +-
 drivers/isdn/pcbit/capi.h       |    2 +-
 drivers/isdn/pcbit/drv.c        |    2 +-
 drivers/isdn/pcbit/edss1.c      |    2 +-
 drivers/isdn/pcbit/edss1.h      |    2 +-
 drivers/isdn/pcbit/layer2.c     |    2 +-
 drivers/isdn/pcbit/layer2.h     |    2 +-
 drivers/isdn/pcbit/module.c     |    2 +-
 drivers/isdn/pcbit/pcbit.h      |    2 +-
 include/linux/in6.h             |    2 +-
 include/linux/ipv6_route.h      |    2 +-
 include/net/if_inet6.h          |    2 +-
 include/net/ip6_fib.h           |    2 +-
 include/net/ipv6.h              |    2 +-
 include/net/neighbour.h         |    2 +-
 net/core/neighbour.c            |    2 +-
 net/ipv6/addrconf.c             |    2 +-
 net/ipv6/af_inet6.c             |    2 +-
 net/ipv6/datagram.c             |    2 +-
 net/ipv6/exthdrs.c              |    2 +-
 net/ipv6/icmp.c                 |    2 +-
 net/ipv6/ip6_fib.c              |    2 +-
 net/ipv6/ip6_input.c            |    2 +-
 net/ipv6/ip6_output.c           |    2 +-
 net/ipv6/ipv6_sockglue.c        |    2 +-
 net/ipv6/mcast.c                |    2 +-
 net/ipv6/ndisc.c                |    2 +-
 net/ipv6/protocol.c             |    2 +-
 net/ipv6/raw.c                  |    2 +-
 net/ipv6/reassembly.c           |    2 +-
 net/ipv6/route.c                |    2 +-
 net/ipv6/sit.c                  |    2 +-
 net/ipv6/tcp_ipv6.c             |    2 +-
 net/ipv6/udp.c                  |    2 +-
 38 files changed, 38 insertions(+), 38 deletions(-)



Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-full/Documentation/isdn/CREDITS.old	2004-06-16 07:18:58.000000000 +0200
+++ linux-2.6.8-rc1-full/Documentation/isdn/CREDITS	2004-07-15 22:33:03.000000000 +0200
@@ -37,7 +37,7 @@
 Andreas Kool (akool@Kool.f.EUnet.de)
   For contribution of the isdnlog/isdnrep-tool
 
-Pedro Roque Marques (roque@di.fc.ul.pt)
+Pedro Roque Marques (pedro_m@yahoo.com)
   For lot of new ideas and the pcbit driver.
 
 Eberhard Moenkeberg (emoenke@gwdg.de)
--- linux-2.6.8-rc1-full/Documentation/isdn/README.pcbit.old	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.8-rc1-full/Documentation/isdn/README.pcbit	2004-07-15 22:33:03.000000000 +0200
@@ -37,4 +37,4 @@
 regards,
   Pedro.
 		
-<roque@di.fc.ul.pt>
+<pedro_m@yahoo.com>
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/edss1.c.old	2004-06-16 07:18:57.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/edss1.c	2004-07-15 22:33:03.000000000 +0200
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/pcbit.h.old	2004-06-16 07:18:58.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/pcbit.h	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/layer2.h.old	2004-06-16 07:18:58.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/layer2.h	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/module.c.old	2004-06-16 07:19:37.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/module.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/drv.c.old	2004-06-16 07:19:43.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/drv.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/capi.c.old	2004-06-16 07:19:43.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/capi.c	2004-07-15 22:33:03.000000000 +0200
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/layer2.c.old	2004-06-16 07:19:43.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/layer2.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  *
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/capi.h.old	2004-06-16 07:20:03.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/capi.h	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/callbacks.c.old	2004-06-16 07:20:26.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/callbacks.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/callbacks.h.old	2004-06-16 07:20:26.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/callbacks.h	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/drivers/isdn/pcbit/edss1.h.old	2004-06-16 07:20:27.000000000 +0200
+++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/edss1.h	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1996 Universidade de Lisboa
  * 
- * Written by Pedro Roque Marques (roque@di.fc.ul.pt)
+ * Written by Pedro Roque Marques (pedro_m@yahoo.com)
  *
  * This software may be used and distributed according to the terms of 
  * the GNU General Public License, incorporated herein by reference.
--- linux-2.6.8-rc1-full/include/linux/ipv6_route.h.old	2004-06-16 07:19:01.000000000 +0200
+++ linux-2.6.8-rc1-full/include/linux/ipv6_route.h	2004-07-15 22:33:03.000000000 +0200
@@ -2,7 +2,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
--- linux-2.6.8-rc1-full/include/linux/in6.h.old	2004-06-16 07:19:37.000000000 +0200
+++ linux-2.6.8-rc1-full/include/linux/in6.h	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	Sources:
  *	IPv6 Program Interfaces for BSD Systems
--- linux-2.6.8-rc1-full/include/net/ip6_fib.h.old	2004-06-16 07:19:43.000000000 +0200
+++ linux-2.6.8-rc1-full/include/net/ip6_fib.h	2004-07-15 22:33:03.000000000 +0200
@@ -2,7 +2,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
--- linux-2.6.8-rc1-full/include/net/ipv6.h.old	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.8-rc1-full/include/net/ipv6.h	2004-07-15 22:33:03.000000000 +0200
@@ -2,7 +2,7 @@
  *	Linux INET6 implementation
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>
+ *	Pedro Roque		<pedro_m@yahoo.com>
  *
  *	$Id: ipv6.h,v 1.1 2002/05/20 15:13:07 jgrimm Exp $
  *
--- linux-2.6.8-rc1-full/include/net/if_inet6.h.old	2004-06-16 07:20:04.000000000 +0200
+++ linux-2.6.8-rc1-full/include/net/if_inet6.h	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *
  *	This program is free software; you can redistribute it and/or
--- linux-2.6.8-rc1-full/include/net/neighbour.h.old	2004-06-16 07:20:04.000000000 +0200
+++ linux-2.6.8-rc1-full/include/net/neighbour.h	2004-07-15 22:33:03.000000000 +0200
@@ -5,7 +5,7 @@
  *	Generic neighbour manipulation
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>
+ *	Pedro Roque		<pedro_m@yahoo.com>
  *	Alexey Kuznetsov	<kuznet@ms2.inr.ac.ru>
  */
 
--- linux-2.6.8-rc1-full/net/core/neighbour.c.old	2004-06-16 07:18:56.000000000 +0200
+++ linux-2.6.8-rc1-full/net/core/neighbour.c	2004-07-15 22:33:03.000000000 +0200
@@ -2,7 +2,7 @@
  *	Generic address resolution entity
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>
+ *	Pedro Roque		<pedro_m@yahoo.com>
  *	Alexey Kuznetsov	<kuznet@ms2.inr.ac.ru>
  *
  *	This program is free software; you can redistribute it and/or
--- linux-2.6.8-rc1-full/net/ipv6/exthdrs.c.old	2004-06-16 07:18:56.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/exthdrs.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>
+ *	Pedro Roque		<pedro_m@yahoo.com>
  *	Andi Kleen		<ak@muc.de>
  *	Alexey Kuznetsov	<kuznet@ms2.inr.ac.ru>
  *
--- linux-2.6.8-rc1-full/net/ipv6/ip6_output.c.old	2004-07-11 22:38:43.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/ip6_output.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	$Id: ip6_output.c,v 1.34 2002/02/01 22:01:04 davem Exp $
  *
--- linux-2.6.8-rc1-full/net/ipv6/ipv6_sockglue.c.old	2004-06-16 07:18:57.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/ipv6_sockglue.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	Based on linux/net/ipv4/ip_sockglue.c
  *
--- linux-2.6.8-rc1-full/net/ipv6/datagram.c.old	2004-06-16 07:18:57.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/datagram.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	$Id: datagram.c,v 1.24 2002/02/01 22:01:04 davem Exp $
  *
--- linux-2.6.8-rc1-full/net/ipv6/protocol.c.old	2004-06-16 07:18:59.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/protocol.c	2004-07-15 22:33:03.000000000 +0200
@@ -7,7 +7,7 @@
  *
  * Version:	$Id: protocol.c,v 1.10 2001/05/18 02:25:49 davem Exp $
  *
- * Authors:	Pedro Roque	<roque@di.fc.ul.pt>
+ * Authors:	Pedro Roque	<pedro_m@yahoo.com>
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
--- linux-2.6.8-rc1-full/net/ipv6/icmp.c.old	2004-07-11 22:38:43.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/icmp.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>
+ *	Pedro Roque		<pedro_m@yahoo.com>
  *
  *	$Id: icmp.c,v 1.38 2002/02/08 03:57:19 davem Exp $
  *
--- linux-2.6.8-rc1-full/net/ipv6/reassembly.c.old	2004-06-16 07:19:09.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/reassembly.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	$Id: reassembly.c,v 1.26 2001/03/07 22:00:57 davem Exp $
  *
--- linux-2.6.8-rc1-full/net/ipv6/raw.c.old	2004-07-11 22:38:44.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/raw.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	Adapted from linux/net/ipv4/raw.c
  *
--- linux-2.6.8-rc1-full/net/ipv6/tcp_ipv6.c.old	2004-07-11 22:38:44.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/tcp_ipv6.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	$Id: tcp_ipv6.c,v 1.144 2002/02/01 22:01:04 davem Exp $
  *
--- linux-2.6.8-rc1-full/net/ipv6/af_inet6.c.old	2004-07-11 22:38:43.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/af_inet6.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	Adapted from linux/net/ipv4/af_inet.c
  *
--- linux-2.6.8-rc1-full/net/ipv6/ndisc.c.old	2004-07-11 22:38:43.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/ndisc.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *	Mike Shaver		<shaver@ingenia.com>
  *
  *	This program is free software; you can redistribute it and/or
--- linux-2.6.8-rc1-full/net/ipv6/ip6_input.c.old	2004-06-16 07:19:43.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/ip6_input.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>
+ *	Pedro Roque		<pedro_m@yahoo.com>
  *	Ian P. Morris		<I.P.Morris@soton.ac.uk>
  *
  *	$Id: ip6_input.c,v 1.19 2000/12/13 18:31:50 davem Exp $
--- linux-2.6.8-rc1-full/net/ipv6/route.c.old	2004-07-11 22:38:44.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/route.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	FIB front-end.
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	$Id: route.c,v 1.56 2001/10/31 21:55:55 davem Exp $
  *
--- linux-2.6.8-rc1-full/net/ipv6/ip6_fib.c.old	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/ip6_fib.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Forwarding Information Database
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	$Id: ip6_fib.c,v 1.25 2001/10/31 21:55:55 davem Exp $
  *
--- linux-2.6.8-rc1-full/net/ipv6/udp.c.old	2004-07-11 22:38:44.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/udp.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	Based on linux/ipv4/udp.c
  *
--- linux-2.6.8-rc1-full/net/ipv6/mcast.c.old	2004-07-11 22:38:43.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/mcast.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation 
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *
  *	$Id: mcast.c,v 1.40 2002/02/08 03:57:19 davem Exp $
  *
--- linux-2.6.8-rc1-full/net/ipv6/sit.c.old	2004-07-11 22:38:44.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/sit.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *	Alexey Kuznetsov	<kuznet@ms2.inr.ac.ru>
  *
  *	$Id: sit.c,v 1.53 2001/09/25 05:09:53 davem Exp $
--- linux-2.6.8-rc1-full/net/ipv6/addrconf.c.old	2004-06-16 07:20:03.000000000 +0200
+++ linux-2.6.8-rc1-full/net/ipv6/addrconf.c	2004-07-15 22:33:03.000000000 +0200
@@ -3,7 +3,7 @@
  *	Linux INET6 implementation
  *
  *	Authors:
- *	Pedro Roque		<roque@di.fc.ul.pt>	
+ *	Pedro Roque		<pedro_m@yahoo.com>	
  *	Alexey Kuznetsov	<kuznet@ms2.inr.ac.ru>
  *
  *	$Id: addrconf.c,v 1.69 2001/10/31 21:55:54 davem Exp $
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

