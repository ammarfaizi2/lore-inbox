Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWAGPMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWAGPMM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWAGPMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:12:12 -0500
Received: from jubileegroup.co.uk ([217.147.177.250]:64488 "EHLO
	mail3.jubileegroup.co.uk") by vger.kernel.org with ESMTP
	id S1030473AbWAGPMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:12:10 -0500
Date: Sat, 7 Jan 2006 15:11:40 +0000 (GMT)
From: "G.W. Haywood" <ged@jubileegroup.co.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] ne2k PCI/ISA documentation: improved cross-reference.
In-Reply-To: <200512292149.55237.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.58.0601071459440.8957@mail3.jubileegroup.co.uk>
References: <Pine.LNX.4.58.0512291301420.2118@mail3.jubileegroup.co.uk>
 <9a8748490512290553g448d1e28w65dad834cd08e1a7@mail.gmail.com>
 <Pine.LNX.4.58.0512291520250.6219@mail3.jubileegroup.co.uk>
 <200512292149.55237.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (mail3.jubileegroup.co.uk [0.0.0.0]); Sat, 07 Jan 2006 15:11:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ged Haywood <ged@jubileegroup.co.uk>

Improved reference to PCI ne2k support in ISA ne2k documentation.

Signed-off-by: Ged Haywood <ged@jubileegroup.co.uk>
---
 Configure.help |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
--- linux-2.4.32/Documentation/Configure.help.original  2006-01-07 14:48:23.000000000 +0000
+++ linux-2.4.32/Documentation/Configure.help   2006-01-07 14:56:32.000000000 +0000
@@ -12778,7 +12778,8 @@
   without a specific driver are compatible with NE2000.

   If you have a PCI NE2000 card however, say N here and Y to "PCI
-  NE2000 support", above. If you have a NE2000 card and are running on
+  NE2000 and clones support" under "EISA, VLB, PCI and on board
+  controllers" below.  If you have a NE2000 card and are running on
   an MCA system (a bus system used on some IBM PS/2 computers and
   laptops), say N here and Y to "NE/2 (ne2000 MCA version) support",
   below.
