Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQLCDPI>; Sat, 2 Dec 2000 22:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQLCDO6>; Sat, 2 Dec 2000 22:14:58 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:16390 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129523AbQLCDOs>;
	Sat, 2 Dec 2000 22:14:48 -0500
Message-Id: <200012030136.eB31aBM01753@sleipnir.valparaiso.cl>
To: linux-kernel@vger.kernel.org
cc: Alan.Cox@linux.org
Subject: 2.2.18pre2[34] freezes
X-Mailer: MH [Version 6.8.4]
Date: Sat, 02 Dec 2000 22:36:11 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P3/600 (Katmai, stepping 3), intel SR440BX mobo + latest BIOS, 128Mb; RH7 +
local updates (notably binutils-2.10.0.33-1).

2.2.18pre23: Machine was mostly idle (around 15:40, no users, running Gnome
+ screensaver). No response at all to mouse/keyboard (C-A-BS nor
C-A-DEL). No traces in the logs.

2.2.18pre24: Rebooted into 24, downloaded latest CVS update for gcc started
building, was reading email via emacs + mh-e in Gnome. Full freeze again.

First time this happens to me with this machine. Back to 2.2.18pre22 for
now.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
