Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314674AbSEFSnZ>; Mon, 6 May 2002 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314672AbSEFSnY>; Mon, 6 May 2002 14:43:24 -0400
Received: from revdns.flarg.info ([213.152.47.19]:35999 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S314674AbSEFSnX>;
	Mon, 6 May 2002 14:43:23 -0400
Date: Mon, 6 May 2002 19:43:20 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.14-dj1
Message-ID: <20020506184320.GA16392@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just clearing out the pending folder, and dropping some more
bits found whilst patch splitting.

As usual,..
Patch against 2.5.13 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.14-dj1
o   Don't prefetch memcpy's to/from io addresses.	(Me)
o   Fix MMX prefetching for x86-64			(Me)
o   Other small MMX copying tweaks for x86-64.		(Me)
o   Drop more silly bits found whilst patch splitting.
o   Fix tcq brown paper bag bug.			(Jens Axboe)
o   OSS API emulation config.in thinko.			(Jaroslav Kysela)
o   Update to IDE-55					(Martin Dalecki)
o   Disallow compilation with gcc 2.91.66		(Andrew Morton)
o   Missed blksize cleanup in rd.c			(Al Viro)
o   NTFS compile fix.					(Andrew Morton)
o   More futex updates.					(Rusty Russell)
o   DE600 region checking cleanup.			(William Stinson)
o   Update VIA quirk URL.				(Erich Schubert)
o   Fix up a few _llseek prototypes.			(Frank Davis)
o   Move busmouse BKL usage to correct place.		(Frank Davis)
o   __d_lookup() microoptimisation.			(Paul Menage)	
o   Fix CAP_SYS_RAWIO thinko for cpqfcTSinit		(Christoph Hellwig)
o   malloc.h -> slab.h for pc300_tty			(Adrian Bunk)
o   Add CONFIG_BROKEN_SCSI_ERROR_HANDLING		(Me)
    | Those who don't care about their data can now
    | choose the same behaviour as mainline.


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
