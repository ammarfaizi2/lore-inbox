Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284118AbRL2QHR>; Sat, 29 Dec 2001 11:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284144AbRL2QHH>; Sat, 29 Dec 2001 11:07:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21521 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284118AbRL2QGy>; Sat, 29 Dec 2001 11:06:54 -0500
Subject: Linux 2.2.21pre1
To: linux-kernel@vger.kernel.org
Date: Sat, 29 Dec 2001 16:17:40 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KMB2-0004qV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
