Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261652AbTCGQTS>; Fri, 7 Mar 2003 11:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbTCGQTS>; Fri, 7 Mar 2003 11:19:18 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:55828 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S261652AbTCGQS4>; Fri, 7 Mar 2003 11:18:56 -0500
Date: Fri, 7 Mar 2003 11:29:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.64][COMPILE] opl3sa2.c
Message-ID: <Pine.LNX.4.44.0303071127420.10491-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,sound/oss/.opl3sa2.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=opl3sa2 -DKBUILD_MODNAME=opl3sa2 -c -o sound/oss/opl3sa2.o sound/oss/opl3sa2.c
sound/oss/opl3sa2.c: In function `opl3sa2_pnp_probe':
sound/oss/opl3sa2.c:854: structure has no member named `io_resource'
sound/oss/opl3sa2.c:855: structure has no member named `irq_resource'
sound/oss/opl3sa2.c:856: structure has no member named `dma_resource'
sound/oss/opl3sa2.c:857: structure has no member named `dma_resource'
sound/oss/opl3sa2.c:860: structure has no member named `io_resource'
sound/oss/opl3sa2.c:861: structure has no member named `irq_resource'
sound/oss/opl3sa2.c:862: structure has no member named `dma_resource'
sound/oss/opl3sa2.c:863: structure has no member named `dma_resource'
sound/oss/opl3sa2.c:866: structure has no member named `io_resource'
sound/oss/opl3sa2.c:867: structure has no member named `irq_resource'
make[2]: *** [sound/oss/opl3sa2.o] Error 1
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2

