Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbQLCEFG>; Sat, 2 Dec 2000 23:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129590AbQLCEEr>; Sat, 2 Dec 2000 23:04:47 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:26374 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129596AbQLCEEf>;
	Sat, 2 Dec 2000 23:04:35 -0500
Message-Id: <200012030334.eB33Y6Z10434@sleipnir.valparaiso.cl>
To: linux-kernel@vger.kernel.org, Alan.Cox@linux.org
Subject: Re: 2.2.18pre2[34] freezes 
In-Reply-To: Message from Horst von Brand <vonbrand@sleipnir.valparaiso.cl> 
   of "Sat, 02 Dec 2000 22:36:11 -0300." <200012030136.eB31aBM01753@sleipnir.valparaiso.cl> 
Date: Sun, 03 Dec 2000 00:34:06 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@sleipnir.valparaiso.cl> said:
> P3/600 (Katmai, stepping 3), intel SR440BX mobo + latest BIOS, 128Mb; RH7 +
> local updates (notably binutils-2.10.0.33-1).
> 
> 2.2.18pre23: Machine was mostly idle (around 15:40, no users, running Gnome
> + screensaver). No response at all to mouse/keyboard (C-A-BS nor
> C-A-DEL). No traces in the logs.
> 
> 2.2.18pre24: Rebooted into 24, downloaded latest CVS update for gcc started
> building, was reading email via emacs + mh-e in Gnome. Full freeze again.

Happened twice again when compiling today's CVS of gcc + running dip (CSLIP
connection).
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
