Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759467AbWLFBgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759467AbWLFBgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 20:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759481AbWLFBgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 20:36:54 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:14074 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759467AbWLFBgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 20:36:53 -0500
Date: Tue, 5 Dec 2006 17:37:18 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: adaplas@pol.net, jsimmons@infradead.org, akpm <akpm@osdl.org>
Subject: [PATCH] linux-fbdev-devel is subscribers-only
Message-Id: <20061205173718.a676aed6.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Update linux-fbdev mailing list to subscribers-only.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 MAINTAINERS |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6.19-git6.orig/MAINTAINERS
+++ linux-2.6.19-git6/MAINTAINERS
@@ -677,7 +677,7 @@ S:	Supported
 CIRRUS LOGIC GENERIC FBDEV DRIVER
 P:	Jeff Garzik
 M:	jgarzik@pobox.com
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Odd Fixes
 
 CIRRUS LOGIC CS4280/CS461x SOUNDDRIVER
@@ -784,7 +784,7 @@ S:	Maintained
 CYBLAFB FRAMEBUFFER DRIVER
 P:	Knut Petersen
 M:	Knut_Petersen@t-online.de
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 
 CYCLADES 2X SYNC CARD DRIVER
@@ -1115,7 +1115,7 @@ S:	Supported
 FRAMEBUFFER LAYER
 P:	Antonino Daplas
 M:	adaplas@pol.net
-L:	linux-fbdev-devel@lists.sourceforge.net	
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 W:	http://linux-fbdev.sourceforge.net/
 S:	Maintained
 
@@ -1466,7 +1466,7 @@ S:	Maintained
 IMS TWINTURBO FRAMEBUFFER DRIVER
 P:	Paul Mundt
 M:	lethal@chaoticdreams.org
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 
 INFINIBAND SUBSYSTEM
@@ -1499,13 +1499,13 @@ S:	Maintained
 INTEL FRAMEBUFFER DRIVER (excluding 810 and 815)
 P:	Sylvain Meyer
 M:	sylvain.meyer@worldonline.fr
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 
 INTEL 810/815 FRAMEBUFFER DRIVER
 P:	Antonino Daplas
 M:	adaplas@pol.net
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 
 INTEL APIC/IOAPIC, LOWLEVEL X86 SMP SUPPORT
@@ -1951,7 +1951,7 @@ S:	Odd Fixes for 2.4; Maintained for 2.6
 MATROX FRAMEBUFFER DRIVER
 P:	Petr Vandrovec
 M:	vandrove@vc.cvut.cz
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 
 MEGARAID SCSI DRIVERS
@@ -2197,7 +2197,7 @@ S:	Maintained
 NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
 P:	Antonino Daplas
 M:	adaplas@pol.net
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 
 OPENCORES I2C BUS DRIVER
@@ -2474,13 +2474,13 @@ S:	Maintained
 RADEON FRAMEBUFFER DISPLAY DRIVER
 P:	Benjamin Herrenschmidt
 M:	benh@kernel.crashing.org
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 
 RAGE128 FRAMEBUFFER DISPLAY DRIVER
 P:	Paul Mackerras
 M:	paulus@samba.org
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 
 RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER
@@ -2550,7 +2550,7 @@ S:	Orphan
 S3 SAVAGE FRAMEBUFFER DRIVER
 P:	Antonino Daplas
 M:	adaplas@pol.net
-L:	linux-fbdev-devel@lists.sourceforge.net
+L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 
 S390


---
