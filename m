Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUAAUyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbUAAUyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:54:08 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:34592 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264930AbUAAUDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:42 -0500
Date: Thu, 1 Jan 2004 21:03:38 +0100
Message-Id: <200401012003.i01K3cYL031956@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 387] M68k Documentation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k Documentation: framebuffer.txt no longer exists in the m68k directory
(from Nikita Melnikov)

--- linux-2.6.0/Documentation/m68k/00-INDEX	1997-11-29 19:33:18.000000000 +0100
+++ linux-m68k-2.6.0/Documentation/m68k/00-INDEX	2003-11-27 12:07:24.000000000 +0100
@@ -1,7 +1,5 @@
 00-INDEX
 	- this file
-framebuffer.txt
-	- info about the Linux/m68k frame buffer device
 kernel-options.txt
 	- command line options for Linux/m68k
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
