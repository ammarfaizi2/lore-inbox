Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSJTOYA>; Sun, 20 Oct 2002 10:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbSJTOX6>; Sun, 20 Oct 2002 10:23:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37364 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262670AbSJTOX5>; Sun, 20 Oct 2002 10:23:57 -0400
Date: Sun, 20 Oct 2002 16:29:56 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dag Brattli <dag@brattli.net>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: [2.5 patch] remove obsolete IrDA list from MAINTAINERS
Message-ID: <Pine.NEB.4.44.0210201625200.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mail to the list that is in MAINTAINERS bounces and the new mailinglist
doesn't accept mail from non-subscribers. Since you can find this new
mailinglist at the IrDA web page it's IMHO the best to simply remove the
mailing list entry from MAINTAINERS:


--- linux-2.5.44-full/MAINTAINERS.old	2002-10-20 16:23:23.000000000 +0200
+++ linux-2.5.44-full/MAINTAINERS	2002-10-20 16:23:34.000000000 +0200
@@ -854,7 +854,6 @@
 IRDA SUBSYSTEM
 P:	Dag Brattli
 M:	Dag Brattli <dag@brattli.net>
-L:	linux-irda@pasta.cs.uit.no
 W:	http://irda.sourceforge.net/
 S:	Maintained


cu
Adrian

-- 

               "Is there not promise of rain?" Ling Tan asked suddenly out
                of the darkness. There had been need of rain for many days.
               "Only a promise," Lao Er said.
                                               Pearl S. Buck - Dragon Seed



