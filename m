Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUDENAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUDENAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:00:42 -0400
Received: from witte.sonytel.be ([80.88.33.193]:62605 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262329AbUDENAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:00:41 -0400
Date: Mon, 5 Apr 2004 15:00:34 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-ID: <Pine.GSO.4.58.0404051459260.15477@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This has been in my tree since a while...

--- linux-2.6.5/drivers/base/platform.c.orig	2004-02-17 13:54:49.000000000 +0100
+++ linux-2.6.x/drivers/base/platform.c	2004-01-15 13:58:12.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * platform.c - platform 'psuedo' bus for legacy devices
+ * platform.c - platform 'pseudo' bus for legacy devices
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
