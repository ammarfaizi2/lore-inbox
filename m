Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286962AbSABL4g>; Wed, 2 Jan 2002 06:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286841AbSABL40>; Wed, 2 Jan 2002 06:56:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46857 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286930AbSABL4T>; Wed, 2 Jan 2002 06:56:19 -0500
Subject: Linux 2.2.21pre2
To: linux-kernel@vger.kernel.org
Date: Wed, 2 Jan 2002 12:07:14 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LkAs-0003tY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.2.21pre2
o	Fix non blocking midi close on es1370, es1371	(me)
	sonicvibes
o	Update osst driver				(Willem Riede)
o	Update machine check support in 2.2 to match 2.4(Dave Jones)
o	Additional P4, Rise, Winchip handling for setup	(Dave Jones)
o	Fix extended MMX initialisation on Cyrix MII	(me)
o	Backport a lot of x86 setup (cache size etc)	(Dave Jones)
o	ISDN cleanups					(Kai Germaschewski)
o	Backport eicon driver fixes			(Kai Germaschewski)
o	ISDN ppp fixes					(Andre Beck)
o	Fix timeout handling in eicon driver		(Kai Germaschewski)
o	Fix null pointer bug in isdnloop		(Kai Germaschewski)
o	Menuconfig refresh fixup			(Willy Tarreau)
o	Modular ati frame buffer build fix		(Krzysztof Taraszka)
o	Backport VIA chipset fixes to 2.2		(me)
o	Make DCD high->low work on SX16 with CLOCAL set	(Ado Arnolds)

2.2.21pre1
o	Fix potential corruption with vmalloc on	(Ralf Baechle)
	virtually cached boxes
o	Small PPC build fixups				(Tom Rini)
o	zImage booting fix				(Kalev Soikonen)
o	EIO on NFS read fixup				(Trond Myklebust)
o	Update 3ware raid driver			(Adam Radford)
o	page_alloc race fix				(Andrea Arcangeli)
o	Update USB maintainers				(Greg Kroah-Hartmann)
o	bttv clipcount=0 fix				(Solar Designer)
o	Fix multiple eepro driver bugs			(Aris)
o	Sym53c8xx queue handling fix			(Gerard Roudier)
o	Update SubmittingDrivers document		(Michal Svec)
o	8139too performance tune			(Jens David)
o	procfs follow link return fix			(Solar Designer)
o	Backport SEM_UNDO overflow fix from 2.4		(Leonid Igolnik)
o	VM86 fixes					(Manfred Spraul)
o	Fix alpha build					(Kim Heino)
