Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVDLOg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVDLOg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVDLLEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:04:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:31434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262259AbVDLKdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:16 -0400
Message-Id: <200504121033.j3CAX3qk005765@shell0.pdx.osdl.net>
Subject: [patch 152/198] Maintainers list update: linux-net -> netdev
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, horms@verge.net.au
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Horms <horms@verge.net.au>

Use netdev as the mailing list contact instead of the mostly dead linux-net
list.

Signed-off-by: Horms <horms@verge.net.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/MAINTAINERS |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff -puN MAINTAINERS~maintainers-list-update-linux-net-netdev MAINTAINERS
--- 25/MAINTAINERS~maintainers-list-update-linux-net-netdev	2005-04-12 03:21:40.020052928 -0700
+++ 25-akpm/MAINTAINERS	2005-04-12 03:21:40.025052168 -0700
@@ -73,7 +73,7 @@ S: Status, one of the following:
 3C359 NETWORK DRIVER
 P:	Mike Phillips
 M:	mikep@linuxtr.net
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
@@ -81,13 +81,13 @@ S:	Maintained
 3C505 NETWORK DRIVER
 P:	Philip Blundell
 M:	philb@gnu.org
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 3CR990 NETWORK DRIVER
 P:	David Dillow
 M:	dave@thedillows.org
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 3W-XXXX ATA-RAID CONTROLLER DRIVER
@@ -143,7 +143,7 @@ S:	Maintained
 8390 NETWORK DRIVERS [WD80x3/SMC-ELITE, SMC-ULTRA, NE2000, 3C503, etc.]
 P:	Paul Gortmaker
 M:	p_gortmaker@yahoo.com
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 A2232 SERIAL BOARD DRIVER
@@ -326,7 +326,7 @@ S:	Maintained
 
 ARPD SUPPORT
 P:	Jonathan Layes
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 ASUS ACPI EXTRAS DRIVER
@@ -700,7 +700,7 @@ S:	Orphaned
 
 DIGI RIGHTSWITCH NETWORK DRIVER
 P:	Rick Richardson
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 W:	http://www.digi.com
 S:	Orphaned
 
@@ -806,7 +806,7 @@ S:	Maintained
 ETHEREXPRESS-16 NETWORK DRIVER
 P:	Philip Blundell
 M:	philb@gnu.org
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 ETHERNET BRIDGE
@@ -869,7 +869,7 @@ S:	Maintained
 FRAME RELAY DLCI/FRAD (Sangoma drivers too)
 P:	Mike McLagan
 M:	mike.mclagan@linux.org
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 FREEVXFS FILESYSTEM
@@ -1209,7 +1209,7 @@ S:	Maintained
 IPX NETWORK LAYER
 P:	Arnaldo Carvalho de Melo
 M:	acme@conectiva.com.br
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 IRDA SUBSYSTEM
@@ -1586,13 +1586,13 @@ P:	Andrew Morton
 M:	akpm@osdl.org
 P:	Jeff Garzik
 M:	jgarzik@pobox.com
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 NETWORKING [GENERAL]
 P:	Networking Team
 M:	netdev@oss.sgi.com
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 NETWORKING [IPv4/IPv6]
@@ -1628,7 +1628,7 @@ NI5010 NETWORK DRIVER
 P:	Jan-Pascal van Best and Andreas Mohr
 M:	Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>
 M:	Andreas Mohr <100.30936@germany.net>
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 NINJA SCSI-3 / NINJA SCSI-32Bi (16bit/CardBus) PCMCIA SCSI HOST ADAPTER DRIVER
@@ -1670,7 +1670,7 @@ P:	Peter De Shrijver
 M:	p2@ace.ulyssis.student.kuleuven.ac.be
 P:	Mike Phillips
 M:	mikep@linuxtr.net 
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
@@ -1775,7 +1775,7 @@ S:	Unmaintained
 PCNET32 NETWORK DRIVER
 P:	Thomas Bogendörfer
 M:	tsbogend@alpha.franken.de
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 PHRAM MTD DRIVER
@@ -1787,7 +1787,7 @@ S:	Maintained
 POSIX CLOCKS and TIMERS
 P:	George Anzinger
 M:	george@mvista.com
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Supported
 
 PNP SUPPORT
@@ -2039,7 +2039,7 @@ SIS 900/7016 FAST ETHERNET DRIVER
 P:	Daniele Venzano
 M:	venza@brownhat.org
 W:	http://www.brownhat.org/sis900.html
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 SIS FRAMEBUFFER DRIVER
@@ -2098,7 +2098,7 @@ S:	Maintained
 SONIC NETWORK DRIVER
 P:	Thomas Bogendoerfer
 M:	tsbogend@alpha.franken.de
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 SONY VAIO CONTROL DEVICE DRIVER
@@ -2148,7 +2148,7 @@ S:	Supported
 SPX NETWORK LAYER
 P:	Jay Schulist
 M:	jschlst@samba.org
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Supported
 
 SRM (Alpha) environment access
@@ -2227,7 +2227,7 @@ S:	Maintained
 TOKEN-RING NETWORK DRIVER
 P:	Mike Phillips
 M:	mikep@linuxtr.net
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
_
