Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289762AbSBXPzp>; Sun, 24 Feb 2002 10:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSBXPzf>; Sun, 24 Feb 2002 10:55:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8549 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289762AbSBXPz0>; Sun, 24 Feb 2002 10:55:26 -0500
Date: Sun, 24 Feb 2002 16:55:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18rc4aa1
Message-ID: <20020224165531.A14179@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18rc4aa1.gz
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18rc4aa1/

Only in 2.4.18rc2aa2: 00_block-highmem-all-18b-2.gz
Only in 2.4.18rc4aa1: 00_block-highmem-all-18b-3.gz
Only in 2.4.18rc2aa2: 10_block-highmem-all-18b-2

	Don't mark it experimental anymore and avoid changing the ll_rw_block
	queue changes in this patch, return to the mainline values. If needed
	they should go into a separate patch for clarity.
	Use CONFIG_DISCONTIGMEM for some microoptimization.

Only in 2.4.18rc4aa1: 00_prepare-write-fixes-1

	Fixed a few bugs in the block_prepare_write while dealing with
	get_block failures.

Only in 2.4.18rc2aa2: 00_ptrace-fix-1

	Merged in mainline.

Only in 2.4.18rc2aa2: 10_vm-25
Only in 2.4.18rc4aa1: 10_vm-27

	Further updates.

Only in 2.4.18rc2aa2: 20_balance-dirty-wait-1

	Dropped (to see if write performance increases).

Only in 2.4.18rc2aa2: 20_pte-highmem-13
Only in 2.4.18rc4aa1: 20_pte-highmem-14

	Merged ia64.

Only in 2.4.18rc4aa1: 70_xfs-1.gz

	Merged SGI's XFS integrated with -aa VM.

Andrea
