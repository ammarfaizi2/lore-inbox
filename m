Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316764AbSFUTix>; Fri, 21 Jun 2002 15:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSFUTiw>; Fri, 21 Jun 2002 15:38:52 -0400
Received: from p508878AB.dip.t-dialin.net ([80.136.120.171]:50068 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316764AbSFUTiu>; Fri, 21 Jun 2002 15:38:50 -0400
Date: Fri, 21 Jun 2002 13:38:50 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Linux 2.5.23-ct1
Message-ID: <Pine.LNX.4.44.0206211335380.20282-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some time out of sight, I'm back now and here is my kernel.

It's basically some stuff + kbuild-2.5

<URL:ftp://luckynet.dynu.com/pub/linux/2.5.23-ct1/patch-2.5.23-ct1.bz2>

2.5.24-ct1 coming soon

<ac9410@bellsouth.net>:
  o [patch] 2.5.23 i2c updates 1/4
  o [patch] 2.5.23 i2c updates 2/4
  o [patch] 2.5.23 i2c updates 3/4
  o [patch] 2.5.23 i2c updates 4/4

<cananian@lesser-magoo.lcs.mit.edu>:
  o 2.5.23: missing tqueue.h in cpia_pp.c

<gerald@io.com>:
  o small cleanup of ide parameter parsing

<jwhite@codeweavers.com>:
  o Fix bug parsing option of isofs driver
  o Reverse isofs unhide option to hide

<lists-sender-14a37a@bittwiddlers.com>:
  o 2.5.23 tqueue patches

<manik@cisco.com>:
  o (off 2.5.22) replacing __builtin_expect with unlikely in
  o [Trivial Patch] : (2.5 latest) More __builtin_expect() cleanup in

<mgross@unix-os.sc.intel.com>:
  o tcore for 2.5.23 kernel

<patch@luckynet.dynu.com>:
  o kbuild-2.5 other arches foreport

<willy@debian.org>:
  o Convert cm206 to a tasklet

<wli@holomorphy.com>:
  o [TRIVIAL] beautify nr_free_pages()

Adam J. Richter <adam@yggdrasil.com>:
  o Patch: linux-2.5.23/Rules.make - enable modversions.h to build

Adrian Bunk <bunk@fs.tum.de>:
  o [2.5 patch] drivers/atm/idt77252.h needs linux/tqueue.h
  o [2.5 patch] tqueue.h fixes for ISDN
  o [2.5 patch] fix compilation of ad1848_lib.c

Andi Kleen <ak@muc.de>:
  o Export ioremap_nocache
  o [NEW PATCH, testers needed] was Re: [PATCH] poll/select fast path

Andrew Morton <akpm@zip.com.au>:
  o [Ext2-devel] Shrinking ext3 directories
  o [Ext2-devel] Shrinking ext3 directories
  o [Ext2-devel] Shrinking ext3 directories

Andrey Panin <pazke@orbita1.ru>:
  o [RFC] SGI VISWS support for 2.5

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o [PATCHlet] 2.5.23 usb, ide

Anton Altaparmakov <aia21@cantab.net>:
  o [2.5-BK-PATCH] NTFS 2.0.9 update
  o [2.5BK-PATCH] NTFS 2.0.10: Limit inodes to 2^32 - 1

b.zolnierkiewicz@elka.pw.edu.pl <B.Zolnierkiewicz@elka.pw.edu.pl>:
  o [redone PATCH 2.5.22] simple ide-tape/floppy.c cleanup

Benjamin LaHaise <bcrl@redhat.com>:
  o [patch] export default_wake_function
  o [patch] credentials for 2.5.23

Greg Kroah-Hartman <greg@kroah.com>:
  o Re: 2.5.22 fix for pci_hotplug
  o Re: [2.5 patch] drivers/hotplug/cpqphp.h must include tqueue.h
  o Re: 2.5.22 fix for pci_hotplug

Ingo Molnar <mingo@elte.hu>:
  o [patch] migration thread & hotplug fixes, 2.5.23
  o [patch] scheduler bits from 2.5.23-dj1

James Simmons <jsimmons@transvirtual.com>:
  o [UPDATES] fbdev ports and fixes

Keith Owens <kaos@ocs.com.au>:
  o kbuild-2.5 core 19
  o kbuild-2.5 common 2.5.21
  o kbuild-2.5 i386 2.5.21
  o kbuild-2.5 s/390 2.5.21
  o kbuild-2.5 s/390x 2.5.21

Linus Torvalds <torvalds@transmeta.com>:
  o Re: Linux 2.5.23 cpu_online_map undeclared

Martin Dalecki <dalecki@evision-ventures.com>:
  o Re: linux 2.5.23

Peter Chubb <peter@chubb.wattle.id.au>:
  o ppp_generic.c doesn't compile on IA64

Robert Love <rml@tech9.net>:
  o 2.5: mark variables as __initdata
  o 2.5-dj: configurable NR_CPUS

Rusty Russell <rusty@rustcorp.com.au>:
  o Trivial rename bitmap_member -> DECLARE_BITMAP
  o Fixed set_affinity/get_affinity syscalls

Stelian Pop <stelian.pop@fr.alcove.com>:
  o [PATCH 2.5] include <linux/tqueue.h> in pcmcia drivers

Stephen Rothwell <sfr@canb.auug.org.au>:
  o make kstack_depth_to_print and some APM stuff static
  o ext2 statics
  o ipv6 statics
  o Consolidate include/asm/signal.h

-- 
Lightweight patch manager using pine. If you have any objections, tell me.

