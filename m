Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVFPWoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVFPWoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVFPWnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:43:35 -0400
Received: from mail.dif.dk ([193.138.115.101]:23490 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261843AbVFPWgH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:36:07 -0400
Date: Fri, 17 Jun 2005 00:41:28 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: evil@g-house.de, lroland@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
In-Reply-To: <20050616.145941.41632714.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0506170039470.2477@dragon.hyggekrogen.localhost>
References: <4ad99e0505061605452e663a1e@mail.gmail.com> <42B1F5CB.9020308@g-house.de>
 <20050616.145941.41632714.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, David S. Miller wrote:

> From: Christian Kujau <evil@g-house.de>
> Date: Thu, 16 Jun 2005 23:57:31 +0200
> 
> > if it really turns out to be a tg3 problem, maybe netdev@oss.sgi.com
> > should be Cc'ed.
> 
> Make that netdev@vger.kernel.org

Is that a permanent change of address? And is the old address dead?
If so, then the patch beneath should probably be applied.


Update the netdev mailing list address in MAINTAINERS.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 MAINTAINERS |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

--- linux-2.6.12-rc6-mm1-orig/MAINTAINERS	2005-06-12 15:58:58.000000000 +0200
+++ linux-2.6.12-rc6-mm1/MAINTAINERS	2005-06-17 00:38:40.000000000 +0200
@@ -73,7 +73,7 @@
 3C359 NETWORK DRIVER
 P:	Mike Phillips
 M:	mikep@linuxtr.net
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
@@ -81,13 +81,13 @@
 3C505 NETWORK DRIVER
 P:	Philip Blundell
 M:	philb@gnu.org
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 3CR990 NETWORK DRIVER
 P:	David Dillow
 M:	dave@thedillows.org
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 3W-XXXX ATA-RAID CONTROLLER DRIVER
@@ -130,7 +130,7 @@
 8169 10/100/1000 GIGABIT ETHERNET DRIVER
 P:	Francois Romieu
 M:	romieu@fr.zoreil.com
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
@@ -143,7 +143,7 @@
 8390 NETWORK DRIVERS [WD80x3/SMC-ELITE, SMC-ULTRA, NE2000, 3C503, etc.]
 P:	Paul Gortmaker
 M:	p_gortmaker@yahoo.com
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 A2232 SERIAL BOARD DRIVER
@@ -337,7 +337,7 @@
 
 ARPD SUPPORT
 P:	Jonathan Layes
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 ASUS ACPI EXTRAS DRIVER
@@ -710,7 +710,7 @@
 
 DIGI RIGHTSWITCH NETWORK DRIVER
 P:	Rick Richardson
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 W:	http://www.digi.com
 S:	Orphaned
 
@@ -821,7 +821,7 @@
 ETHEREXPRESS-16 NETWORK DRIVER
 P:	Philip Blundell
 M:	philb@gnu.org
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 ETHERNET BRIDGE
@@ -884,7 +884,7 @@
 FRAME RELAY DLCI/FRAD (Sangoma drivers too)
 P:	Mike McLagan
 M:	mike.mclagan@linux.org
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 FREEVXFS FILESYSTEM
@@ -1238,7 +1238,7 @@
 IPX NETWORK LAYER
 P:	Arnaldo Carvalho de Melo
 M:	acme@conectiva.com.br
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 IRDA SUBSYSTEM
@@ -1521,7 +1521,7 @@
 P:	Manish Lachwani
 M:	Manish_Lachwani@pmc-sierra.com
 L:	linux-mips@linux-mips.org
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Supported
 
 MATROX FRAMEBUFFER DRIVER
@@ -1631,13 +1631,13 @@
 M:	akpm@osdl.org
 P:	Jeff Garzik
 M:	jgarzik@pobox.com
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 NETWORKING [GENERAL]
 P:	Networking Team
-M:	netdev@oss.sgi.com
-L:	netdev@oss.sgi.com
+M:	netdev@vger.kernel.org
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 NETWORKING [IPv4/IPv6]
@@ -1653,7 +1653,7 @@
 M:	yoshfuji@linux-ipv6.org
 P:	Patrick McHardy
 M:	kaber@coreworks.de
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 IPVS
@@ -1673,7 +1673,7 @@
 P:	Jan-Pascal van Best and Andreas Mohr
 M:	Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>
 M:	Andreas Mohr <100.30936@germany.net>
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 NINJA SCSI-3 / NINJA SCSI-32Bi (16bit/CardBus) PCMCIA SCSI HOST ADAPTER DRIVER
@@ -1715,7 +1715,7 @@
 M:	p2@ace.ulyssis.student.kuleuven.ac.be
 P:	Mike Phillips
 M:	mikep@linuxtr.net 
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
@@ -1822,7 +1822,7 @@
 PCNET32 NETWORK DRIVER
 P:	Thomas Bogendörfer
 M:	tsbogend@alpha.franken.de
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 PHRAM MTD DRIVER
@@ -1834,7 +1834,7 @@
 POSIX CLOCKS and TIMERS
 P:	George Anzinger
 M:	george@mvista.com
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Supported
 
 PERFORMANCE-MONITORING COUNTERS DRIVER
@@ -1875,7 +1875,7 @@
 PRISM54 WIRELESS DRIVER
 P:	Prism54 Development Team
 M:	prism54-private@prism54.org
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 W:	http://prism54.org
 S:	Maintained
 
@@ -2092,7 +2092,7 @@
 P:	Daniele Venzano
 M:	venza@brownhat.org
 W:	http://www.brownhat.org/sis900.html
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 SIS FRAMEBUFFER DRIVER
@@ -2149,7 +2149,7 @@
 SONIC NETWORK DRIVER
 P:	Thomas Bogendoerfer
 M:	tsbogend@alpha.franken.de
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Maintained
 
 SONY VAIO CONTROL DEVICE DRIVER
@@ -2211,7 +2211,7 @@
 SPX NETWORK LAYER
 P:	Jay Schulist
 M:	jschlst@samba.org
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 S:	Supported
 
 SRM (Alpha) environment access
@@ -2290,7 +2290,7 @@
 TOKEN-RING NETWORK DRIVER
 P:	Mike Phillips
 M:	mikep@linuxtr.net
-L:	netdev@oss.sgi.com
+L:	netdev@vger.kernel.org
 L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained


