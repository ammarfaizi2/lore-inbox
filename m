Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266516AbUGUPiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266516AbUGUPiC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUGUPiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:38:00 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:20021 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S266516AbUGUPhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:37:43 -0400
Date: Wed, 21 Jul 2004 17:37:36 +0200
Message-Id: <200407211537.i6LFba3A020442@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 159] M68k Maintainership
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k maintainership update:
  - Transfer maintainership to Roman and me (ack'ed by Jes and Roman)
  - Update main website URL
  - Add Linux/m68k CVS repository website

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.27-rc3/MAINTAINERS	2004-06-27 09:59:00.000000000 +0200
+++ linux-m68k-2.4.27-rc3/MAINTAINERS	2004-07-21 17:26:40.000000000 +0200
@@ -1153,11 +1153,14 @@
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
