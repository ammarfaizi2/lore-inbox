Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267658AbTAaBas>; Thu, 30 Jan 2003 20:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267662AbTAaBas>; Thu, 30 Jan 2003 20:30:48 -0500
Received: from [195.223.140.107] ([195.223.140.107]:640 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267658AbTAaBar>;
	Thu, 30 Jan 2003 20:30:47 -0500
Date: Fri, 31 Jan 2003 02:40:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre4aa1
Message-ID: <20030131014020.GA8395@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre4aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre4aa1/

Diff between 2.4.21pre3aa1 and 2.4.21pre4aa1:

Only in 2.4.21pre3aa1: 00_bdflush-docs-1
Only in 2.4.21pre3aa1: 00_o_direct-align-1
Only in 2.4.21pre3aa1: 00_sd-cleanup-3
Only in 2.4.21pre3aa1: 00_slabinfo-shared-address-space-1
Only in 2.4.21pre3aa1: 30_alpha-wildfire-numa-generic-1

	Merged in mainline.

Only in 2.4.21pre3aa1: 00_extraversion-16
Only in 2.4.21pre4aa1: 00_extraversion-17
Only in 2.4.21pre3aa1: 00_rwsem-fair-34
Only in 2.4.21pre3aa1: 00_rwsem-fair-34-recursive-8
Only in 2.4.21pre4aa1: 00_rwsem-fair-35
Only in 2.4.21pre4aa1: 00_rwsem-fair-35-recursive-8
Only in 2.4.21pre3aa1: 00_sched-O1-aa-2.4.19rc3-8.gz
Only in 2.4.21pre4aa1: 00_sched-O1-aa-2.4.19rc3-9.gz
Only in 2.4.21pre3aa1: 10_rawio-vary-io-17
Only in 2.4.21pre4aa1: 10_rawio-vary-io-18
Only in 2.4.21pre3aa1: 20_numa-mm-5
Only in 2.4.21pre4aa1: 20_numa-mm-6
Only in 2.4.21pre3aa1: 82_x86_64-suse-6
Only in 2.4.21pre4aa1: 82_x86_64-suse-7
Only in 2.4.21pre3aa1: 83_x86_64-x86-1
Only in 2.4.21pre3aa1: 84_x86-64-arch-1
Only in 2.4.21pre4aa1: 84_x86-64-arch-2
Only in 2.4.21pre3aa1: 85_x86-64-includes-1
Only in 2.4.21pre4aa1: 85_x86-64-includes-2
Only in 2.4.21pre3aa1: 90_proc-mapped-base-4
Only in 2.4.21pre4aa1: 90_proc-mapped-base-5
Only in 2.4.21pre3aa1: 96_inode_read_write-atomic-5
Only in 2.4.21pre4aa1: 96_inode_read_write-atomic-6
Only in 2.4.21pre3aa1: 9900_aio-14.gz
Only in 2.4.21pre4aa1: 9900_aio-15.gz

	Rediffed.

Only in 2.4.21pre4aa1: 00_generic_file_write_nolock-1
Only in 2.4.21pre3aa1: 00_o_direct-read-overflow-write-locking-xfs-2
Only in 2.4.21pre3aa1: 60_pagecache-atomic-7
Only in 2.4.21pre4aa1: 60_pagecache-atomic-8
Only in 2.4.21pre4aa1: 70_xfs-1.2-1
Only in 2.4.21pre3aa1: 70_xfs-cvs-020905-1
Only in 2.4.21pre3aa1: 71_xfs-aa-1
Only in 2.4.21pre4aa1: 71_xfs-aa-2
Only in 2.4.21pre3aa1: 71_xfs-sched-1
Only in 2.4.21pre3aa1: 71_xfs-zalloc-fix-1

	Merged xfs 1.2, patches from Christoph Hellwig.

Only in 2.4.21pre3aa1: 00_getcwd-err-1
Only in 2.4.21pre4aa1: 00_getcwd-err-2

	Part of it merged in mainline.

Only in 2.4.21pre4aa1: 00_tcp-retrans-collapse-1

	Fix from David Miller and Alexey Kuznetsov for hw checksum
	missing memcpy of payload during retrans collapse.

Only in 2.4.21pre3aa1: 00_vma-file-merge-1
Only in 2.4.21pre4aa1: 00_vma-file-merge-2

	Two minor micro-optimizations (no functional noticeable difference).

Only in 2.4.21pre4aa1: 30_p3-p4-optimize-1

	Use prefetch for p4 too, and use the pentium4 and pentium4 compiler
	switchs so it avoids incl/decl (from Margit Schubert-While)

Only in 2.4.21pre3aa1: 9985_blk-atomic-aa5
Only in 2.4.21pre4aa1: 9985_blk-atomic-aa6

	Fix raid.

Only in 2.4.21pre3aa1: 9995_frlock-gettimeofday-1
Only in 2.4.21pre4aa1: 9995_frlock-gettimeofday-2

	Fix 486 SMP and the notsc mode (however nobody should need
	notsc these days on x86, numaq uses cyclone autodetected at boot now)

Only in 2.4.21pre4aa1: 9996_kiobuf-slab-1

	Keep the kiobuf + bhs cache in the slab rather than in the file
	structure, so it scales also while sharing the same file from two
	different filedescriptors at the same time (like with threads or
	after forks). From Jun Nakajima.

Andrea
