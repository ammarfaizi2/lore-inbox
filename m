Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUFQTIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUFQTIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUFQTIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:08:50 -0400
Received: from witte.sonytel.be ([80.88.33.193]:57056 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261830AbUFQTH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:07:59 -0400
Date: Thu, 17 Jun 2004 21:07:57 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: hfs warning in 2.4.27-pre6
Message-ID: <Pine.GSO.4.58.0406172106390.1495@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not a new one:

| super.c: In function `parse_options':
| super.c:164: warning: `names' might be used uninitialized in this function
| super.c:164: warning: `fork' might be used uninitialized in this function

and it's not a compiler glitch.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
