Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129997AbRABN4N>; Tue, 2 Jan 2001 08:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRABN4C>; Tue, 2 Jan 2001 08:56:02 -0500
Received: from ool-18bfe8a9.dyn.optonline.net ([24.191.232.169]:1408 "EHLO
	optonline.net") by vger.kernel.org with ESMTP id <S129997AbRABNzy>;
	Tue, 2 Jan 2001 08:55:54 -0500
From: Les Schaffer <schaffer@optonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14929.54867.768350.41506@optonline.net>
Date: Tue, 2 Jan 2001 08:23:31 -0500 (EST)
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ne2000 (ISA) & test11+
In-Reply-To: <3A519B63.56BE023@yahoo.com>
In-Reply-To: <14929.13173.272621.321333@optonline.net>
	<3A519B63.56BE023@yahoo.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: Les Schaffer <schaffer@optonline.net>
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: [V?bWTh\+_V")"gXxY9KGQozO(|>ggwp;\Ds6@YGoS$wreQaSLmhWUp%V;okpj4C^i$FQWK
 Q:/luO.Zh=VP"U5M.%m1cK:v9DgiQp^JK47nxE^=e3~HPoLmY,igNBZo)LUT3a2CFm*chsyaq7~=dU
 _IX>v[h$BZsa*yn5;?{|3Z@ZI@FL(e`-@wq`f?~{1){A%o:/t"39M@}ER]6.62NbfxrD%!{9!So^\9
 c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul:

> So try deleting your options line (for 2.4.x kernels).

that did it. nice work.....

les schaffer



isapnp: Scanning for Pnp cards...
isapnp: Card 'NDC Plug & Play Ethernet Card'
isapnp: 1 Plug & Play card detected total
ne.c: ISAPnP reports Generic PNP at i/o 0x220, irq 5.
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x220: 00 80 c6 f5 19 08
eth1: NE2000 found at 0x220, using IRQ 5.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
