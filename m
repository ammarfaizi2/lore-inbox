Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSLBLF5>; Mon, 2 Dec 2002 06:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSLBLF5>; Mon, 2 Dec 2002 06:05:57 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:4552 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S262486AbSLBLFz>; Mon, 2 Dec 2002 06:05:55 -0500
Date: Mon, 2 Dec 2002 12:13:18 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.20] CREDITS update
Message-ID: <20021202121318.E17187@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates my contact information in CREDITS and MAINTAINERS.

Marcelo, please apply.

===== CREDITS 1.57 vs edited =====
--- 1.57/CREDITS	Mon Oct 21 11:27:34 2002
+++ edited/CREDITS	Mon Dec  2 11:55:43 2002
@@ -2397,13 +2397,10 @@
 D: CDROM driver "sonycd535" (Sony CDU-535/531)
 
 N: Stelian Pop
-E: stelian.pop@fr.alcove.com
+E: stelian@popies.net
 P: 1024D/EDBB6147 7B36 0E07 04BC 11DC A7A0  D3F7 7185 9E7A EDBB 6147
 D: sonypi, meye drivers, mct_u232 usb serial hacks
-S: Alcôve
-S: 153, bd. Anatole France 
-S: 93200 Saint Denis
-S: France
+S: Paris, France
 
 N: Frederic Potter 
 E: fpotter@cirpack.com
===== MAINTAINERS 1.86 vs edited =====
--- 1.86/MAINTAINERS	Sun Nov 24 18:06:45 2002
+++ edited/MAINTAINERS	Mon Dec  2 12:00:08 2002
@@ -1041,6 +1041,12 @@
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+MOTION EYE VAIO PICTUREBOOK CAMERA DRIVER
+P:	Stelian Pop
+M:	stelian@popies.net
+W:	http://popies.net/meye/
+S:	Maintained
+
 MOUSE AND MISC DEVICES [GENERAL]
 P:	Alessandro Rubini
 M:	rubini@ipvvis.unipv.it
@@ -1485,6 +1491,12 @@
 P:	Thomas Bogendoerfer
 M:	tsbogend@alpha.franken.de
 L:	linux-net@vger.kernel.org
+S:	Maintained
+
+SONY VAIO CONTROL DEVICE DRIVER
+P:	Stelian Pop
+M:	stelian@popies.net
+W:	http://popies.net/sonypi/
 S:	Maintained
 
 SOUND
-- 
Stelian Pop <stelian@popies.net>
