Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131086AbRBQVto>; Sat, 17 Feb 2001 16:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131708AbRBQVtf>; Sat, 17 Feb 2001 16:49:35 -0500
Received: from CPE-61-9-148-228.vic.bigpond.net.au ([61.9.148.228]:5761 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S131086AbRBQVta>; Sat, 17 Feb 2001 16:49:30 -0500
Date: Sun, 18 Feb 2001 02:14:01 +1100
From: john slee <indigoid@higherplane.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] clean up inconsistent formatting in MAINTAINERS
Message-ID: <20010218021400.C1001@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

against 2.4.1:

this may seem rather frivolous, but...

patch below makes all data lines start with the appropriate letter, a
colon, then a tab.  previously some entries used (varying amounts of)
space characters instead of tabs.

--- MAINTAINERS.orig	Sun Feb 18 01:48:03 2001
+++ MAINTAINERS	Sun Feb 18 02:04:44 2001
@@ -230,11 +230,11 @@
 S:	Maintained
 
 COMPAQ FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
-P:      Amy Vanzant-Hodge 
-M:      Amy Vanzant-Hodge (fibrechannel@compaq.com)
+P:	Amy Vanzant-Hodge 
+M:	Amy Vanzant-Hodge (fibrechannel@compaq.com)
 L:	compaqandlinux@cpqlin.van-dijk.net
 W:	ftp.compaq.com/pub/products/drivers/linux
-S:      Supported
+S:	Supported
 
 COMPAQ SMART2 RAID DRIVER
 P:	Charles White	
@@ -251,14 +251,14 @@
 S:	Supported 
 
 COMPUTONE INTELLIPORT MULTIPORT CARD
-P:     Doug McNash
-P:     Michael H. Warfield
-M:     Doug McNash <dougm@computone.com>
-M:     Michael H. Warfield <mhw@wittsend.com>
-W:     http://www.computone.com/
-W:     http://www.wittsend.com/computone.html
-L:     linux-computone@lazuli.wittsend.com
-S:     Supported
+P:	Doug McNash
+P:	Michael H. Warfield
+M:	Doug McNash <dougm@computone.com>
+M:	Michael H. Warfield <mhw@wittsend.com>
+W:	http://www.computone.com/
+W:	http://www.wittsend.com/computone.html
+L:	linux-computone@lazuli.wittsend.com
+S:	Supported
 
 COMX/MULTIGATE SYNC SERIAL DRIVERS
 P:	Gergely Madarasz
@@ -347,10 +347,10 @@
 
 DIGI INTL. EPCA DRIVER
 P:	Chad Schwartz
-M:      support@dgii.com
-M:      chads@dgii.com
-L:      digilnux@dgii.com
-S:      Maintained
+M:	support@dgii.com
+M:	chads@dgii.com
+L:	digilnux@dgii.com
+S:	Maintained
 
 DIGI RIGHTSWITCH NETWORK DRIVER
 P:	Rick Richardson
@@ -373,12 +373,12 @@
 S:	Supported
 
 DISK GEOMETRY AND PARTITION HANDLING
-P:     Andries Brouwer
-M:     aeb@veritas.com
-W:     http://www.win.tue.nl/~aeb/linux/Large-Disk.html
-W:     http://www.win.tue.nl/~aeb/linux/zip/zip-1.html
-W:     http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
-S:     Maintained
+P:	Andries Brouwer
+M:	aeb@veritas.com
+W:	http://www.win.tue.nl/~aeb/linux/Large-Disk.html
+W:	http://www.win.tue.nl/~aeb/linux/zip/zip-1.html
+W:	http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
+S:	Maintained
 
 DISKQUOTA:
 P:	Marco van Wieringen
@@ -442,9 +442,9 @@
 S:	Maintained
 
 ETHERTEAM 16I DRIVER
-P:      Mika Kuoppala
-M:      miku@iki.fi
-S:      Maintained
+P:	Mika Kuoppala
+M:	miku@iki.fi
+S:	Maintained
 
 EXT2 FILE SYSTEM
 P:	Remy Card
@@ -498,10 +498,10 @@
 S:	Maintained
 
 HFS FILESYSTEM
-P:      Adrian Sun
-M:      asun@cobaltnet.com
-L:      linux-kernel@vger.kernel.org
-S:      Maintained
+P:	Adrian Sun
+M:	asun@cobaltnet.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
 
 HGA FRAMEBUFFER DRIVER
 P:	Ferenc Bakonyi
@@ -527,11 +527,11 @@
 S:	Maintained 
 
 LOGICAL VOLUME MANAGER
-P:     Heinz Mauelshagen
-M:     linux-LVM@EZ-Darmstadt.Telekom.de
-L:     linux-LVM@msede.com
-W:     http://linux.msede.com/lvm
-S:     Maintained 
+P:	Heinz Mauelshagen
+M:	linux-LVM@EZ-Darmstadt.Telekom.de
+L:	linux-LVM@msede.com
+W:	http://linux.msede.com/lvm
+S:	Maintained 
 
 HIPPI
 P:	Jes Sorensen
@@ -578,10 +578,10 @@
 S:	Maintained
 
 IBM ServeRAID RAID DRIVER
-P:      Keith Mitchell
-M:      ipslinux@us.ibm.com
-W:      http://www.developer.ibm.com/welcome/netfinity/serveraid.html
-S:      Supported 
+P:	Keith Mitchell
+M:	ipslinux@us.ibm.com
+W:	http://www.developer.ibm.com/welcome/netfinity/serveraid.html
+S:	Supported 
 
 IDE DRIVER [GENERAL]
 P:	Andre Hedrick
@@ -663,11 +663,11 @@
 S:	Maintained
 
 IRDA SUBSYSTEM
-P:      Dag Brattli
-M:      Dag Brattli <dag@brattli.net>
-L:      linux-irda@pasta.cs.uit.no
-W:      http://irda.sourceforge.net/
-S:      Maintained
+P:	Dag Brattli
+M:	Dag Brattli <dag@brattli.net>
+L:	linux-irda@pasta.cs.uit.no
+W:	http://irda.sourceforge.net/
+S:	Maintained
 
 ISAPNP
 P:	Jaroslav Kysela
@@ -731,10 +731,10 @@
 S:	Maintained
 
 LANMEDIA WAN CARD DRIVER
-P:      Andrew Stanley-Jones
-M:      asj@lanmedia.com
-W:      http://www.lanmedia.com/
-S:      Supported
+P:	Andrew Stanley-Jones
+M:	asj@lanmedia.com
+W:	http://www.lanmedia.com/
+S:	Supported
  
 LAPB module
 P:	Henner Eisen
@@ -875,17 +875,17 @@
 S:	Maintained
 
 NFS CLIENT
-P:      Trond Myklebust
-M:      trond.myklebust@fys.uio.no
-L:      linux-kernel@vger.kernel.org
-S:      Maintained
+P:	Trond Myklebust
+M:	trond.myklebust@fys.uio.no
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
 
 NI5010 NETWORK DRIVER
-P:     Jan-Pascal van Best and Andreas Mohr
-M:     Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>
-M:     Andreas Mohr <100.30936@germany.net>
-L:     linux-net@vger.kernel.org
-S:     Maintained
+P:	Jan-Pascal van Best and Andreas Mohr
+M:	Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>
+M:	Andreas Mohr <100.30936@germany.net>
+L:	linux-net@vger.kernel.org
+S:	Maintained
 
 NON-IDE/NON-SCSI CDROM DRIVERS [GENERAL] (come on, crew - mark your responsibility)
 P:	Eberhard Moenkeberg
@@ -1215,10 +1215,10 @@
 S:	Maintained
 
 TRIDENT 4DWAVE/SIS 7018 PCI AUDIO CORE
-P:      Ollie Lho  
-M:      ollie@sis.com.tw
+P:	Ollie Lho  
+M:	ollie@sis.com.tw
 L:	linux-kernel@vger.kernel.org
-S:      Supported
+S:	Supported
 
 TMS380 TOKEN-RING NETWORK DRIVER
 P:	Adam Fritzler
@@ -1318,12 +1318,12 @@
 S:	Maintained
 
 USB OV511 DRIVER
-P:     Mark McClelland
-M:     mwm@i.am
-L:     linux-usb-users@lists.sourceforge.net
-L:     linux-usb-devel@lists.sourceforge.net
-W:     http://alpha.dyndns.org/ov511/
-S:     Maintained
+P:	Mark McClelland
+M:	mwm@i.am
+L:	linux-usb-users@lists.sourceforge.net
+L:	linux-usb-devel@lists.sourceforge.net
+W:	http://alpha.dyndns.org/ov511/
+S:	Maintained
 
 USB PEGASUS DRIVER
 P:	Petko Manolov
@@ -1422,11 +1422,11 @@
 S:	Maintained for 2.2 only
 
 WAN ROUTER & SANGOMA WANPIPE DRIVERS & API (X.25, FRAME RELAY, PPP, CISCO HDLC)
-P:     Jaspreet Singh
-M:     jaspreet@sangoma.com
-M:     dm@sangoma.com
-W:     http://www.sangoma.com
-S:     Supported
+P:	Jaspreet Singh
+M:	jaspreet@sangoma.com
+M:	dm@sangoma.com
+W:	http://www.sangoma.com
+S:	Supported
 
 WAVELAN NETWORK DRIVER & WIRELESS EXTENSIONS
 P:	Jean Tourrilhes
