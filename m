Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275573AbRJAVju>; Mon, 1 Oct 2001 17:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275576AbRJAVjk>; Mon, 1 Oct 2001 17:39:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27406 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275573AbRJAVjg>; Mon, 1 Oct 2001 17:39:36 -0400
Date: Mon, 1 Oct 2001 14:39:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.11-pre2
Message-ID: <Pine.LNX.4.33.0110011438230.990-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Available in the usual places..

		Linus

---
pre2:
 - me/Al Viro: fix bdget() oops with block device modules that don't
   clean up after they exit
 - Alan Cox: continued merging (drivers, license tags)
 - David Miller: sparc update, network fixes
 - Christoph Hellwig: work around broken drivers that add a gendisk more
   than once
 - Jakub Jelinek: handle more ELF loading special cases
 - Trond Myklebust: NFS client and lockd reclaimer cleanups/fixes
 - Greg KH: USB updates
 - Mikael Pettersson: sparate out local APIC / IO-APIC config options

pre1:
 - Chris Mason: fix ppp race conditions
 - me: buffers-in-pagecache coherency, buffer.c cleanups
 - Al Viro: block device cleanups/fixes
 - Anton Altaparmakov: NTFS 1.1.20 update
 - Andrea Arcangeli: VM tweaks

