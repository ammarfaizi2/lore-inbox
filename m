Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSECSgn>; Fri, 3 May 2002 14:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSECSgn>; Fri, 3 May 2002 14:36:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21032 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315119AbSECSgl>; Fri, 3 May 2002 14:36:41 -0400
Date: Fri, 3 May 2002 20:37:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre8aa1 & vm-34
Message-ID: <20020503203738.E1396@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Full patchkit:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1/

Only VM updates:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre8/vm-34.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre8/vm-34/

Diff between 2.4.19pre7aa3 and 2.4.19pre8aa1 besides moving from pre7 to
pre8:

Only in 2.4.19pre7aa3: 00_19pre7_x86_setup_cleanups-1
Only in 2.4.19pre7aa3: 00_backout-kio-request-1
Only in 2.4.19pre7aa3: 00_bh-IPI-1
Only in 2.4.19pre7aa3: 00_k7-prefetch-1
Only in 2.4.19pre7aa3: 00_kiobuf_init-1
Only in 2.4.19pre7aa3: 00_spinlock-cacheline-3
Only in 2.4.19pre7aa3: 00_std-serial-first-1
Only in 2.4.19pre7aa3: 00_timer_bh-deadlock-1

	Merged in mainline. BTW, please merge also the other part of the
	10_tlb-state now called 10_tlb-state-2.

Only in 2.4.19pre7aa3: 00_block-highmem-all-18b-10.gz
Only in 2.4.19pre8aa1: 00_block-highmem-all-18b-11.gz
Only in 2.4.19pre7aa3: 00_nfs-rpc-ping-1
Only in 2.4.19pre8aa1: 00_nfs-rpc-ping-2
Only in 2.4.19pre7aa3: 00_rwsem-fair-28
Only in 2.4.19pre7aa3: 00_rwsem-fair-28-recursive-8
Only in 2.4.19pre8aa1: 00_rwsem-fair-29
Only in 2.4.19pre8aa1: 00_rwsem-fair-29-recursive-8
Only in 2.4.19pre7aa3: 05_vm_17_rest-3
Only in 2.4.19pre8aa1: 05_vm_17_rest-4
Only in 2.4.19pre7aa3: 10_rawio-vary-io-7
Only in 2.4.19pre8aa1: 10_rawio-vary-io-8
Only in 2.4.19pre7aa3: 10_tlb-state-1
Only in 2.4.19pre8aa1: 10_tlb-state-2
Only in 2.4.19pre7aa3: 30_dyn-sched-5
Only in 2.4.19pre8aa1: 30_dyn-sched-6
Only in 2.4.19pre7aa3: 30_x86_setup-boot-cleanup-2
Only in 2.4.19pre8aa1: 30_x86_setup-boot-cleanup-3
Only in 2.4.19pre7aa3: 60_tux-exports-2
Only in 2.4.19pre8aa1: 60_tux-exports-3
Only in 2.4.19pre7aa3: 70_xfs-1.1-0.gz
Only in 2.4.19pre8aa1: 70_xfs-1.1-1.gz

	Rediffed due rejects.

Only in 2.4.19pre7aa3: 00_nfs-tcp-tweaks-4
Only in 2.4.19pre7aa3: 00_nfs-tcp-tweaks-4-rmv-cong-nonsense-3

	Replaced by mainline.

Only in 2.4.19pre7aa3: 00_wake_up_page-1

	Backed out because superflous. (noticed by Christoph Hellwig)

Only in 2.4.19pre7aa3: 81_x86_64-arch-5.gz
Only in 2.4.19pre8aa1: 81_x86_64-arch-6.gz
Only in 2.4.19pre8aa1: 84_x86_64-io-compile-1
Only in 2.4.19pre7aa3: 84_x86_64-out_of_line_bug-1
Only in 2.4.19pre7aa3: 85_x86_64-mmx-xmm-init-3
Only in 2.4.19pre8aa1: 85_x86_64-mmx-xmm-init-4

	Latest updates from cvs.x86-64.org CVS.

Andrea
