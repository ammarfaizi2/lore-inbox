Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311288AbSCLQow>; Tue, 12 Mar 2002 11:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311285AbSCLQoX>; Tue, 12 Mar 2002 11:44:23 -0500
Received: from zeus.kernel.org ([204.152.189.113]:29917 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289484AbSCLQoG>;
	Tue, 12 Mar 2002 11:44:06 -0500
Date: Tue, 12 Mar 2002 17:41:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre3aa1
Message-ID: <20020312174156.D1703@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre3aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre3aa1/

vm-31 (no differences with vm-30 except it applies cleanly to pre3 :)
can be download from here:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre3/vm-31

Only in 2.4.19pre3aa1: 00_alpha-page_address-1
Only in 2.4.19pre3aa1: 00_alpha-page_zone-1

	Fixup some alpha MM compilation problem.

Only in 2.4.19pre2aa2: 00_amd-viper-7441-guessed-1
Only in 2.4.19pre2aa2: 00_flush_icache_range-3

	Obsoleted by mainline.

Only in 2.4.19pre2aa2: 00_block-highmem-all-18b-6.gz
Only in 2.4.19pre3aa1: 00_block-highmem-all-18b-7.gz

	Fixed some MM bit.

Only in 2.4.19pre2aa2: 00_dnotify-fl_owner-1
Only in 2.4.19pre3aa1: 00_dnotify-fl_owner-2

	New better fix from Stephen Rothwell.

Only in 2.4.19pre3aa1: 00_really-write-inode-1

	Make sure to flush the latest inode updates
	to disk before returning from sync_one().
	Fix from Benjamin LaHaise.

Only in 2.4.19pre2aa2: 00_rwsem-fair-27
Only in 2.4.19pre2aa2: 00_rwsem-fair-27-recursive-8
Only in 2.4.19pre3aa1: 00_rwsem-fair-28
Only in 2.4.19pre3aa1: 00_rwsem-fair-28-recursive-8
Only in 2.4.19pre2aa2: 00_silent-stack-overflow-15
Only in 2.4.19pre3aa1: 00_silent-stack-overflow-16
Only in 2.4.19pre2aa2: 10_numa-sched-15
Only in 2.4.19pre3aa1: 10_numa-sched-16
Only in 2.4.19pre2aa2: 10_vm-30
Only in 2.4.19pre3aa1: 10_vm-31
Only in 2.4.19pre2aa2: 20_pte-highmem-15
Only in 2.4.19pre3aa1: 20_pte-highmem-17
Only in 2.4.19pre2aa2: 30_dyn-sched-4
Only in 2.4.19pre3aa1: 30_dyn-sched-5
Only in 2.4.19pre3aa1: 50_uml-patch-2.4.18-2-2.gz
Only in 2.4.19pre2aa2: 50_uml-patch-2.4.18-2.gz
Only in 2.4.19pre2aa2: 70_xfs-5.gz
Only in 2.4.19pre3aa1: 70_xfs-6.gz

	Rediffed.

Only in 2.4.19pre3aa1: 00_sr-scatter-pad-1

	Fix oops in the 1k emulation. Fix from Jens.

Only in 2.4.19pre3aa1: 10_reiserfs-o_direct-1
Only in 2.4.19pre2aa2: 20_reiser-o_direct-2

	Mostly obsoleted, but direct_IO API change
	needed by nfs remains.

Only in 2.4.19pre2aa2: 51_uml-ac-to-aa-6
Only in 2.4.19pre3aa1: 51_uml-ac-to-aa-7
Only in 2.4.19pre2aa2: 52_uml-pgtable_cache_init-1
Only in 2.4.19pre3aa1: 55_uml-page_address-1
Only in 2.4.19pre3aa1: 56_uml-pte-highmem-1
Only in 2.4.19pre3aa1: 57_uml-dyn_sched-1

	Fixedup uml to work well with various recent
	changes.

Only in 2.4.19pre3aa1: 72_xfs-fixes-1

	Recent xfs fixes from Eric Sandeen and Andi Kleen.

Only in 2.4.19pre3aa1: 80_x86_64-common-code-1
Only in 2.4.19pre3aa1: 81_x86_64-arch-1.gz
Only in 2.4.19pre3aa1: 82_x86-64-compile-aa-1
Only in 2.4.19pre3aa1: 82_x86-64-pte-highmem-1

	x86-64 port. From SuSE Labs.

Andrea
