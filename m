Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSGTBL3>; Fri, 19 Jul 2002 21:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSGTBL3>; Fri, 19 Jul 2002 21:11:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12806 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317304AbSGTBL2>; Fri, 19 Jul 2002 21:11:28 -0400
Date: Fri, 19 Jul 2002 21:20:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.19-rc3
Message-ID: <Pine.LNX.4.44.0207192119380.28216-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes rc3. Another -rc is going to come only in the case of really
critical problem(s).

I'm attaching the rc2->rc3 changelog only because the full changelog got
too big (I guess thats why my -rc2 announce mail didnt go to lk).


Summary of changes from v2.4.19-rc2 to v2.4.19-rc3
============================================

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.622)
	[PATCH] PATCH: fix aha152x

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.623)
	[PATCH] PATCH: update atp870u driver

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.624)
	[PATCH] PATCH: new PCI idents for gart

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.625)
	[PATCH] PATCH: AMD766/768 $PIR PCI table entries

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.626)
	[PATCH] PATCH: fix unload crash in AF_ROSE

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.627)
	[PATCH] PATCH: wrong flag type

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.628)
	[PATCH] PATCH: more scsi blacklist

<bunk@fs.tum.de> (02/07/17 1.629)
	[PATCH] fix .text.exit error in orinoco_plx.c

<rusty@rustcorp.com.au> (02/07/17 1.630)
	[PATCH] The real netfilter conntrack SMP overrun fix

<geert@linux-m68k.org> (02/07/17 1.631)
	[PATCH] 2.4.19-rc2 and !CONFIG_BLK_DEV_IDEPCI

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.632)
	[PATCH] PATCH: APM freeze on resume with SMP kernel cure

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.633)
	[PATCH] PATCH: fix oops printing

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.634)
	[PATCH] PATCH: fpu fault

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.635)
	[PATCH] PATCH: HP 01.09 megaraid

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.636)
	[PATCH] PATCH: maestro hang

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.637)
	[PATCH] PATCH: (low prio) stereo reporting

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.638)
	[PATCH] PATCH: hotplug

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.639)
	[PATCH] PATCH: Dunord PCI decode workaround

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.640)
	[PATCH] PATCH: (low priority) bose speakers

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.641)
	[PATCH] PATCH: fix make kernel-doc

<alan@lxorguk.ukuu.org.uk> (02/07/17 1.642)
	[PATCH] PATCH: personality clashes

<hugh@veritas.com> (02/07/17 1.643)
	[PATCH] tmpfs double kunmap

<alan@lxorguk.ukuu.org.uk> (02/07/19 1.644)
	[PATCH] Add missing PCI ID

<marcelo@plucky.distro.conectiva> (02/07/19 1.645)
	Add missing ALI chipset enum in AGP

<marcelo@plucky.distro.conectiva> (02/07/19 1.646)
	Fix wrong #ifdef in ide-pci.c: Was causing problems with FastTrak

<marcelo@plucky.distro.conectiva> (02/07/19 1.647)
	Changed EXTRAVERSION to -rc3


