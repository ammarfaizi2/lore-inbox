Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRDPQMX>; Mon, 16 Apr 2001 12:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRDPQMO>; Mon, 16 Apr 2001 12:12:14 -0400
Received: from feeder.cyberbills.com ([64.41.210.81]:20241 "EHLO
	sjc-smtp1.cyberbills.com") by vger.kernel.org with ESMTP
	id <S131233AbRDPQMI>; Mon, 16 Apr 2001 12:12:08 -0400
Date: Mon, 16 Apr 2001 09:12:00 -0700 (PDT)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac7
Message-ID: <Pine.LNX.4.31ksi3.0104160910330.20561-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=== Cut ===
make[3]: Entering directory `/tmp/build-kernel/usr/src/linux-2.4.3ac7/drivers/net/wan'
ld -m elf_i386 -r -o wanpipe.o sdlamain.o sdla_ft1.o sdla_x25.o sdla_fr.o sdla_chdlc.o sdla_ppp.o wanpipe_multppp.o
gcc -D__KERNEL__ -I/tmp/build-kernel/usr/src/linux-2.4.3ac7/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /tmp/build-kernel/usr/src/linux-2.4.3ac7/include/linux/modversions.h   -c -o cycx_x25.o cycx_x25.c
cycx_x25.c: In function `new_if':
cycx_x25.c:364: structure has no member named `port'
cycx_x25.c:365: structure has no member named `protocol'
cycx_x25.c:371: structure has no member named `local_addr'
cycx_x25.c:388: structure has no member named `local_addr'
make[3]: *** [cycx_x25.o] Error 1
make[3]: Leaving directory `/tmp/build-kernel/usr/src/linux-2.4.3ac7/drivers/net/wan'
=== Cut ===

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV 89014

