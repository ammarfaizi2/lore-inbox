Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTENUKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTENUKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:10:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29389
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262728AbTENUKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:10:10 -0400
Date: Wed, 14 May 2003 22:22:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21rc2aa1
Message-ID: <20030514202258.GF1429@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc2aa1.gz

Diff between 2.4.21pre5aa2 and 2.4.21rc2aa1:

Only in 2.4.21rc2aa1: 00_01_cciss-1
Only in 2.4.21rc2aa1: 00_02_cciss-1
Only in 2.4.21rc2aa1: 00_03_cciss-1

	CCISS driver updates found on l-k.

Only in 2.4.21pre5aa2: 00_conntrack-hash-1
Only in 2.4.21pre5aa2: 00_i810-unlock_page-fastcall-1
Only in 2.4.21pre5aa2: 30_00_fix_symlink-1
Only in 2.4.21pre5aa2: 30_01_fix_softirq-1
Only in 2.4.21pre5aa2: 30_17-fix_read-1
Only in 2.4.21pre5aa2: 72_swapl-1

	Merged in mainline.

Only in 2.4.21pre5aa2: 00_cpu-affinity-syscall-rml-3
Only in 2.4.21rc2aa1: 00_cpu-affinity-syscall-rml-4
Only in 2.4.21pre5aa2: 00_drop-inetpeer-cache-3.gz
Only in 2.4.21rc2aa1: 00_drop-inetpeer-cache-4.gz
Only in 2.4.21pre5aa2: 00_extraversion-21
Only in 2.4.21rc2aa1: 00_extraversion-22
Only in 2.4.21pre5aa2: 00_sched-O1-aa-2.4.19rc3-10.gz
Only in 2.4.21rc2aa1: 00_sched-O1-aa-2.4.19rc3-11.gz
Only in 2.4.21pre5aa2: 00_smp-timers-not-deadlocking-2
Only in 2.4.21rc2aa1: 00_smp-timers-not-deadlocking-3
Only in 2.4.21pre5aa2: 05_vm_23_per-cpu-pages-1
Only in 2.4.21rc2aa1: 05_vm_23_per-cpu-pages-2
Only in 2.4.21pre5aa2: 10_sched-o1-hyperthreading-3
Only in 2.4.21rc2aa1: 10_sched-o1-hyperthreading-4
Only in 2.4.21pre5aa2: 20_pte-highmem-29.gz
Only in 2.4.21rc2aa1: 20_pte-highmem-30.gz
Only in 2.4.21pre5aa2: 30_p3-p4-optimize-1
Only in 2.4.21rc2aa1: 30_p3-p4-optimize-2
Only in 2.4.21pre5aa2: 60_tux-syscall-4
Only in 2.4.21rc2aa1: 60_tux-syscall-5
Only in 2.4.21rc2aa1: 82_x86_64-suse-11
Only in 2.4.21pre5aa2: 82_x86_64-suse-9
Only in 2.4.21pre5aa2: 84_x86-64-arch-2
Only in 2.4.21rc2aa1: 84_x86-64-arch-3
Only in 2.4.21pre5aa2: 9910_shm-largepage-11.gz
Only in 2.4.21rc2aa1: 9910_shm-largepage-12.gz
Only in 2.4.21pre5aa2: 9950_futex-3.gz
Only in 2.4.21rc2aa1: 9950_futex-4.gz
Only in 2.4.21pre5aa2: 9995_frlock-gettimeofday-4
Only in 2.4.21rc2aa1: 9995_frlock-gettimeofday-5
Only in 2.4.21pre5aa2: 9999_gcc-3.3-3
Only in 2.4.21rc2aa1: 9999_gcc-3.3-6

	Rediffed.

Only in 2.4.21rc2aa1: 00_fix-end_kio_request-race-1

	Must wakeup with end_buffer_io_kiobuf as last thing to be sure the
	wakeup will happen on a still allocated kiobuf. Fixed by
	Chris Mason.

Only in 2.4.21pre5aa2: 00_netconsole-2.4.10-C2-2.gz
Only in 2.4.21rc2aa1: 00_netconsole-2.4.10-C2-3.gz

	netconsole fixes from Andi Kleen.

Only in 2.4.21rc2aa1: 00_radeon-3
Only in 2.4.21pre5aa2: 00_radeon-Mobility9000-2

	More updates from Margit.

Only in 2.4.21rc2aa1: 00_remove_inode_page-prune_icache-smp-race-1

	Fix mm corrupting SMP race between remove_inode_page and prune_icache.
	Found by Chris Mason.

Only in 2.4.21rc2aa1: 00_tcp-spurious-dupack-winup-streamers-1

	Avoid suprious duplicate acks for very minor window updates,
	that generates the double outgoing traffic with streaming
	services that tends to fill the whole receive window to buffer.

Only in 2.4.21rc2aa1: 00_tcp-tw-death-2

	Fix from Olof Johansson for tcp_tw_death_row corruption.

Only in 2.4.21rc2aa1: 00_usbnet-zaurus-c700-1

	Allow the new zaurus to connect with usbnet (from Frank Bennett).

Only in 2.4.21pre5aa2: 00_vma-file-merge-2
Only in 2.4.21rc2aa1: 00_vma-file-merge-3

	Fix two bugs, first a fd leak found by Stephen C. Tweedie,
	forgive me for the stupid email I sent as second follow up ;).

	The second bug is a vma merging issue with device driver supplied
	mappings for example with a ->close method, as worse we should
	call its close method, it's simpler and safer to forbid merging
	with those special things. vma file merging is really only worthwhile
	with the normal file mappings.

Only in 2.4.21rc2aa1: 05_vm_24_accessed-ipi-only-smp-1

	Avoid the tlb flushes for the invalid bit in the pagetables
	if in SMP, they certainly ain't worthwhile.

Only in 2.4.21pre5aa2: 07_qlogicfc-2.gz
Only in 2.4.21rc2aa1: 07_qlogicfc-4.gz
Only in 2.4.21pre5aa2: 08_qlogicfc-template-aa-5
Only in 2.4.21rc2aa1: 08_qlogicfc-template-aa-6
Only in 2.4.21pre5aa2: 09_qlogic-link-2
Only in 2.4.21rc2aa1: 09_qlogic-link-3

	qlogic driver update (this also does 64bit dma).

Only in 2.4.21rc2aa1: 21_pte-highmem-mremap-smp-scale-1

	Backported from 2.5 the kmap_atomic functionalty in mremap
	that is more scalable in smp.

Only in 2.4.21rc2aa1: 30_17-mmap-fix-1

	Truncate mappings before updating the attributes on the
	server, otherwise page faults re-dirtying pages can happen
	between the ->setattr() and the vmtruncate(). From Trond Myklebust.

Only in 2.4.21pre5aa2: 9900_aio-18.gz
Only in 2.4.21rc2aa1: 9900_aio-20.gz

	Various minor fixes.

Only in 2.4.21rc2aa1: 9985_blk-atomic-7
Only in 2.4.21pre5aa2: 9985_blk-atomic-aa6

	Stop troubles using BH_Atomic to advertize if the elv_seq is
	significant or not (from Jens Axboe).

	Add atomic guarantee to asynchronous I/O too (before this patch
	the atomic guarantee was provided only with regular (synchronous)
	rawio, now it will be corruption-proof also with rawio+async).
	Thanks to the design of blk-atomic extending the support to asyncio
	is been a two liner.

Only in 2.4.21rc2aa1: 9999_ia64-__clear_bit-1

	Use the right (efficient/inchoerent) __clear_bit.

Only in 2.4.21rc2aa1: 9999_mmap-cache-1

	Add mmap cache to take faster some common case (band-aid to hide
	the O(N) complexity of mmap). Tries to get right 64bit archs in
	32bit emulation with /proc/<pid>/mapped_base functional.

Andrea
