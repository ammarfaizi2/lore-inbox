Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUCVKA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 05:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUCVKA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 05:00:26 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:61522 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261852AbUCVKAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 05:00:18 -0500
Date: Mon, 22 Mar 2004 11:00:16 +0100
Message-Id: <200403221000.i2MA0GBg004121@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 148] Amiga Oktagon URL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Oktagon: Fix broken URL (from Petri Koistinen in 2.6)

--- linux-2.4.26-pre5/Documentation/Configure.help	2004-01-17 17:51:39.000000000 +0100
+++ linux-m68k-2.4.26-pre5/Documentation/Configure.help	2004-01-20 22:25:39.000000000 +0100
@@ -23572,7 +23572,7 @@
   If you have the BSC Oktagon SCSI disk controller for the Amiga, say
   Y to this question.  If you're in doubt about whether you have one,
   see the picture at
-  <http://amiga.multigraph.com/photos/oktagon.html>.
+  <http://amiga.resource.cx/exp/search.pl?product=oktagon>.
 
 Atari native SCSI support
 CONFIG_ATARI_SCSI

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
