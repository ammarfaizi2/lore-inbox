Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLaPoT>; Sun, 31 Dec 2000 10:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQLaPoJ>; Sun, 31 Dec 2000 10:44:09 -0500
Received: from hermes.cs.kuleuven.ac.be ([134.58.40.3]:28883 "EHLO
	hermes.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S129401AbQLaPnv>; Sun, 31 Dec 2000 10:43:51 -0500
Date: Sat, 30 Dec 2000 15:01:12 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Configure.help typo
Message-ID: <Pine.LNX.4.10.10012301500010.581-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.4.0-test13-pre6/Documentation/Configure.help.orig	Sat Dec 30 14:13:28 2000
+++ linux-2.4.0-test13-pre6/Documentation/Configure.help	Sat Dec 30 14:59:32 2000
@@ -971,7 +971,7 @@
 
 VIA82CXXX chipset support
 CONFIG_BLK_DEV_VIA82CXXX
-  This allows you to to configure your chipset for a better use while
+  This allows you to configure your chipset for a better use while
   running (U)DMA: it will allow you to enable efficiently the second
   channel dma usage, as it may not be set by BIOS. It allows you to
   pass a kernel command line at boot time in order to set fifo

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
