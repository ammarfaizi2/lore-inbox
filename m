Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283378AbRK2SaF>; Thu, 29 Nov 2001 13:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283379AbRK2S3z>; Thu, 29 Nov 2001 13:29:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:58493 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S283378AbRK2S3q>; Thu, 29 Nov 2001 13:29:46 -0500
Date: Thu, 29 Nov 2001 19:30:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17pre1aa1
Message-ID: <20011129193007.A2997@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17pre1aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17pre1aa1/

Only in 2.4.17pre1aa1: 00_blkdev-ulimit-1

	Avoid SIGXFSZ with old libc or with ulimit set on a blkdev.

Only in 2.4.15aa1: 00_iput-unmount-corruption-fix-1
Only in 2.4.15aa1: 00_read_super-stale-inode-1

	Use fix in mainline (equivalent in practice).

Only in 2.4.15aa1: 00_silent-stack-overflow-10
Only in 2.4.17pre1aa1: 00_silent-stack-overflow-11

	Rediffed.

Only in 2.4.17pre1aa1: 00_time_vs_gettimeofday-1

	Make time() monotone against gettimeofday (from Andi Kleen).

Only in 2.4.15aa1: 10_block-highmem-all-18b-1
Only in 2.4.17pre1aa1: 10_block-highmem-all-18b-2

	Alternate fix for the bounce_pfn boundary check (avoid
	bouncing one more page than necessary sometime).

Only in 2.4.15aa1: 10_vm-17
Only in 2.4.17pre1aa1: 10_vm-18

	Minor vm tweaks in function of the feedback received.
	Included Andrews' dirty += BUF_LOCKED.

Only in 2.4.15aa1: 50_uml-patch-2.4.14-5.bz2
Only in 2.4.17pre1aa1: 50_uml-patch-2.4.15-3.bz2

	Latest update from Jeff.

Only in 2.4.17pre1aa1: 60_tux-flush_icache_range-1

	Needed in -aa.

Only in 2.4.15aa1: 60_tux-2.4.15-pre9-B1.bz2
Only in 2.4.17pre1aa1: 60_tux-2.4.16-final-A3.bz2

	Latest update from Ingo.

Andrea
