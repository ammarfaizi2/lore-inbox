Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVDLGeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVDLGeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVDLGeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:34:46 -0400
Received: from koto.vergenet.net ([210.128.90.7]:35024 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S262008AbVDLGeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:34:13 -0400
Date: Tue, 12 Apr 2005 15:20:27 +0900
From: Horms <horms@verge.net.au>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, netdev@oss.sgi.com,
       Mike Phillips <mikep@linuxtr.net>, Philip Blundell <philb@gnu.org>,
       David Dillow <dave@thedillows.org>,
       Paul Gortmaker <p_gortmaker@yahoo.com>,
       Mike McLagan <mike.mclagan@linux.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>,
       Andreas Mohr <100.30936@germany.net>,
       p2@ace.ulyssis.student.kuleuven.ac.be,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
       George Anzinger <george@mvista.com>,
       Daniele Venzano <venza@brownhat.org>, Jay Schulist <jschlst@samba.org>
Subject: [PATCH] Maintainers list update: linux-net -> netdev
Message-ID: <20050412062027.GA1614@verge.net.au>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	schwidefsky@de.ibm.com, netdev@oss.sgi.com,
	Mike Phillips <mikep@linuxtr.net>, Philip Blundell <philb@gnu.org>,
	David Dillow <dave@thedillows.org>,
	Paul Gortmaker <p_gortmaker@yahoo.com>,
	Mike McLagan <mike.mclagan@linux.org>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>,
	Andreas Mohr <100.30936@germany.net>,
	p2@ace.ulyssis.student.kuleuven.ac.be,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	George Anzinger <george@mvista.com>,
	Daniele Venzano <venza@brownhat.org>,
	Jay Schulist <jschlst@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050409135205.GA13305@wohnheim.fh-wedel.de>
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 03:52:05PM +0200, Jörn Engel wrote:
> On Fri, 8 April 2005 22:16:07 +0200, Pavel Machek wrote:
> > 
> > More importantly, it is still listed as "the list" for network
> > drivers...
> > 
> > NETWORK DEVICE DRIVERS
> > P:      Andrew Morton
> > M:      akpm@osdl.org
> > P:      Jeff Garzik
> > M:      jgarzik@pobox.com
> > L:      linux-net@vger.kernel.org
> > S:      Maintained
> 
> Maybe one of the two maintainers might want to change that? ;)

Use netdev as the mailing list contact instead of the mostly dead
linux-net list.

Signed-off-by: Horms <horms@verge.net.au>

===== MAINTAINERS 1.295 vs edited =====
--- 1.295/MAINTAINERS	2005-04-04 06:20:11 +09:00
+++ edited/MAINTAINERS	2005-04-12 15:11:38 +09:00
@@ -73,7 +73,7 @@
 3C359 NETWORK DRIVER
 P:	Mike Phillips
 M:	mikep@linuxtr.net
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
@@ -81,13 +81,13 @@
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
@@ -143,7 +143,7 @@
 8390 NETWORK DRIVERS [WD80x3/SMC-ELITE, SMC-ULTRA, NE2000, 3C503, etc.]
 P:	Paul Gortmaker
 M:	p_gortmaker@yahoo.com
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 A2232 SERIAL BOARD DRIVER
@@ -334,7 +334,7 @@
 
 ARPD SUPPORT
 P:	Jonathan Layes
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 ASUS ACPI EXTRAS DRIVER
@@ -708,7 +708,7 @@
 
 DIGI RIGHTSWITCH NETWORK DRIVER
 P:	Rick Richardson
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 W:	http://www.digi.com
 S:	Orphaned
 
@@ -814,7 +814,7 @@
 ETHEREXPRESS-16 NETWORK DRIVER
 P:	Philip Blundell
 M:	philb@gnu.org
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 ETHERNET BRIDGE
@@ -877,7 +877,7 @@
 FRAME RELAY DLCI/FRAD (Sangoma drivers too)
 P:	Mike McLagan
 M:	mike.mclagan@linux.org
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 FREEVXFS FILESYSTEM
@@ -1217,7 +1217,7 @@
 IPX NETWORK LAYER
 P:	Arnaldo Carvalho de Melo
 M:	acme@conectiva.com.br
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 IRDA SUBSYSTEM
@@ -1594,13 +1594,13 @@
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
@@ -1636,7 +1636,7 @@
 P:	Jan-Pascal van Best and Andreas Mohr
 M:	Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>
 M:	Andreas Mohr <100.30936@germany.net>
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 NINJA SCSI-3 / NINJA SCSI-32Bi (16bit/CardBus) PCMCIA SCSI HOST ADAPTER DRIVER
@@ -1678,7 +1678,7 @@
 M:	p2@ace.ulyssis.student.kuleuven.ac.be
 P:	Mike Phillips
 M:	mikep@linuxtr.net 
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
@@ -1783,7 +1783,7 @@
 PCNET32 NETWORK DRIVER
 P:	Thomas Bogendörfer
 M:	tsbogend@alpha.franken.de
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 PHRAM MTD DRIVER
@@ -1795,7 +1795,7 @@
 POSIX CLOCKS and TIMERS
 P:	George Anzinger
 M:	george@mvista.com
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Supported
 
 PNP SUPPORT
@@ -2042,7 +2042,7 @@
 P:	Daniele Venzano
 M:	venza@brownhat.org
 W:	http://www.brownhat.org/sis900.html
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 SIS FRAMEBUFFER DRIVER
@@ -2101,7 +2101,7 @@
 SONIC NETWORK DRIVER
 P:	Thomas Bogendoerfer
 M:	tsbogend@alpha.franken.de
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Maintained
 
 SONY VAIO CONTROL DEVICE DRIVER
@@ -2151,7 +2151,7 @@
 SPX NETWORK LAYER
 P:	Jay Schulist
 M:	jschlst@samba.org
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 S:	Supported
 
 SRM (Alpha) environment access
@@ -2230,7 +2230,7 @@
 TOKEN-RING NETWORK DRIVER
 P:	Mike Phillips
 M:	mikep@linuxtr.net
-L:	linux-net@vger.kernel.org
+L:	netdev@oss.sgi.com
 L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
