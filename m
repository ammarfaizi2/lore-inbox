Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbREEJPN>; Sat, 5 May 2001 05:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbREEJPD>; Sat, 5 May 2001 05:15:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41233 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131157AbREEJOy>; Sat, 5 May 2001 05:14:54 -0400
Subject: Linux 2.2.20pre1
To: linux-kernel@vger.kernel.org
Date: Sat, 5 May 2001 10:18:52 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vyDG-0000PM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.2 is now firmly into maintainance state. Patches for neat new ideas
belong in 2.4. Generally new drivers belong in 2.4 (possibly in 2.2 as well
after 2.4 shows them stable). Expect me to be very picky on changes to the
core code now. 

2.2.20pre1
o	Fix SMP deadlock in NFS				(Trond Myklebust)
o	Fix missing printk in bluesmoke handler		(me)
o	Fix sparc64 nfs					(Dave Miller)
o	Update io_apic code to avoid breaking dual	(Johannes Erdfelt)
	Athlon 760MP
o	Fix includes bugs in toshiba driver		(Justin Keene,
							 Greg Kroah-Hartmann)
o	Fix wanpipe cross compile			(Phil Blundell)
o	AGPGART copy_from_user fix			(Dawson Engler)
o	Fix alpha resource setup error			(Allan Frank)
o	Eicon driver updates				(Armind Schindler)
o	PC300 driver update				(Daniela Squassoni)
o	Show lock owner on flocks			(Jim Mintha)
o	Update cciss driver to 1.0.3			(Charles White)
o	Backport cciss/cpqarray security fixes		(me)
o	Update i810 random number generator		(Jeff Garzik)
o	Update sk98 driver				(Mirko Lindner)
o	Update sis900 ethernet driver			(Hui-Fen Hsu)
o	Fix checklist glitch in make menuconfig		(Moritz Schulte)
o	Update synclink driver				(Paul Fulghum)
o	Update advansys scsi driver			(Bob Frey)
o	Ver_linux fixes for 2.2				(Steven Cole)
o	Bring 2.2 back into line with the master ISDN	(Kai Germaschewski)
o	Whiteheat usb driver update			(Greg Kroah-Hartmann)
o	Fix via_rhine byte counters			(Adam Lackorzynski)
o	Fix modem control on rio serial			(Rogier Wolff)
o	Add more Iomega Zip to the usb storage list	(Wim Coekaerts)
o	Add ZF Micro watchdog 				(Fernando Fuganti)

