Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265953AbRFZIoC>; Tue, 26 Jun 2001 04:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265954AbRFZInw>; Tue, 26 Jun 2001 04:43:52 -0400
Received: from hood.tvd.be ([195.162.196.21]:36587 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S265953AbRFZInq>;
	Tue, 26 Jun 2001 04:43:46 -0400
Date: Tue, 26 Jun 2001 10:40:31 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Configure.help CONFIG_PPC
Message-ID: <Pine.LNX.4.05.10106261038130.30997-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Eric,

This patch fixes a typo in the help for CONFIG_PPC.

Of course we can discuss whether the PPC is the successor to the 68000 series
or to the 88000 series...

Perhaps it's best to not mention the 88000, else people will think they found
another CPU that doesn't run Linux yet :-)

--- linux-2.4.5-ac18/Documentation/Configure.help	Tue Jun 26 10:29:31 2001
+++ /tmp/Configure.help	Tue Jun 26 10:36:21 2001
@@ -171,7 +171,7 @@
 Power PC processor
 CONFIG_PPC
   The PowerPC is a very capable 32-bit RISC processor from Motorola,
-  the successor the their venerable 68000 series.  It powers recent
+  the successor to their venerable 68000 series.  It powers recent
   Macintoshes and also a widely-used series of single-board computers
   from Motorola.  The Linux PowerPC port has a home page at
   <http://penguinppc.org/>.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

