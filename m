Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSJTO1w>; Sun, 20 Oct 2002 10:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSJTO1v>; Sun, 20 Oct 2002 10:27:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31732 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262708AbSJTO1u>; Sun, 20 Oct 2002 10:27:50 -0400
Date: Sun, 20 Oct 2002 16:33:50 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Dag Brattli <dag@brattli.net>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: [2.4 patch] remove obsolete IrDA list from MAINTAINERS
Message-ID: <Pine.NEB.4.44.0210201631300.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mail to the list that is in MAINTAINERS bounces and the new mailinglist
doesn't accept mail from non-subscribers. Since you can find this new
mailinglist at the IrDA web page it's IMHO the best to simply remove the
mailing list entry from MAINTAINERS:


--- linux-2.4.19/MAINTAINERS.old	2002-10-20 16:30:07.000000000 +0200
+++ linux-2.4.19/MAINTAINERS	2002-10-20 16:30:16.000000000 +0200
@@ -828,7 +828,6 @@
 IRDA SUBSYSTEM
 P:      Dag Brattli
 M:      Dag Brattli <dag@brattli.net>
-L:      linux-irda@pasta.cs.uit.no
 W:      http://irda.sourceforge.net/
 S:      Maintained


cu
Adrian

-- 

               "Is there not promise of rain?" Ling Tan asked suddenly out
                of the darkness. There had been need of rain for many days.
               "Only a promise," Lao Er said.
                                               Pearl S. Buck - Dragon Seed



