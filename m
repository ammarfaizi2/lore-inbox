Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSLBLEa>; Mon, 2 Dec 2002 06:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSLBLEa>; Mon, 2 Dec 2002 06:04:30 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:62151 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S262480AbSLBLE3>; Mon, 2 Dec 2002 06:04:29 -0500
Date: Mon, 2 Dec 2002 12:11:51 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.5.50+BK] CREDITS update
Message-ID: <20021202121151.D17187@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates my contact information in CREDITS and MAINTAINERS.

Linus, please apply.

Stelian.

===== CREDITS 1.75 vs edited =====
--- 1.75/CREDITS	Sun Dec  1 21:32:59 2002
+++ edited/CREDITS	Mon Dec  2 11:55:36 2002
@@ -2489,13 +2489,10 @@
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
===== MAINTAINERS 1.128 vs edited =====
--- 1.128/MAINTAINERS	Mon Dec  2 03:28:16 2002
+++ edited/MAINTAINERS	Mon Dec  2 12:00:06 2002
@@ -1112,6 +1112,12 @@
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
@@ -1563,6 +1569,12 @@
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
