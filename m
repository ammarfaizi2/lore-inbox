Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbSLKOsQ>; Wed, 11 Dec 2002 09:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSLKOqp>; Wed, 11 Dec 2002 09:46:45 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:20374 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S267176AbSLKOqX>; Wed, 11 Dec 2002 09:46:23 -0500
Date: Wed, 11 Dec 2002 15:53:58 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.21-pre1 RESEND] CREDITS update
Message-ID: <20021211155358.G22483@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates my current CREDITS and MAINTAINERS entry.

Marcelo, please apply.

Stelian.

===== CREDITS 1.59 vs edited =====
--- 1.59/CREDITS	Mon Dec  9 09:13:59 2002
+++ edited/CREDITS	Tue Dec 10 11:54:20 2002
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
===== MAINTAINERS 1.88 vs edited =====
--- 1.88/MAINTAINERS	Fri Dec  6 20:12:01 2002
+++ edited/MAINTAINERS	Wed Dec 11 10:18:09 2002
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
