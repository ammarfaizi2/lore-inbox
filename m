Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUFTNbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUFTNbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUFTNbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 09:31:25 -0400
Received: from witte.sonytel.be ([80.88.33.193]:11771 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265373AbUFTNbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 09:31:23 -0400
Date: Sun, 20 Jun 2004 15:31:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] idr.h path
Message-ID: <Pine.GSO.4.58.0406201530160.23356@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix path in <linux/idr.h> header file.

--- linux-2.6.7/include/linux/idr.h.orig	2004-06-09 14:51:15.000000000 +0200
+++ linux-2.6.7/include/linux/idr.h	2004-06-20 15:07:21.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * include/linux/id.h
+ * include/linux/idr.h
  *
  * 2002-10-18  written by Jim Houston jim.houston@ccur.com
  *	Copyright (C) 2002 by Concurrent Computer Corporation

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
