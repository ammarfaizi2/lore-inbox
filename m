Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUGUPiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUGUPiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUGUPiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:38:23 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:3171 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S266513AbUGUPh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:37:57 -0400
Date: Wed, 21 Jul 2004 17:37:50 +0200
Message-Id: <200407211537.i6LFbo4a020453@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 486] M68k Maintainership
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k maintainership update:
  - Transfer maintainership to Roman and me (ack'ed by Jes and Roman)
  - Update main website URL
  - Add Linux/m68k CVS repository website

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/MAINTAINERS	2004-07-18 15:55:05.000000000 +0200
+++ linux-m68k-2.6.8-rc2/MAINTAINERS	2004-07-18 16:16:53.000000000 +0200
@@ -1324,11 +1324,14 @@
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
-M68K
-P:	Jes Sorensen
-M:	jes@trained-monkey.org
-W:	http://www.clark.net/pub/lawrencc/linux/index.html
+M68K ARCHITECTURE
+P:	Geert Uytterhoeven
+M:	geert@linux-m68k.org
+P:	Roman Zippel
+M:	zippel@linux-m68k.org
 L:	linux-m68k@lists.linux-m68k.org
+W:	http://www.linux-m68k.org/
+W:	http://linux-m68k-cvs.ubb.ca/
 S:	Maintained
 
 M68K ON APPLE MACINTOSH

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
