Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284182AbRLFUbX>; Thu, 6 Dec 2001 15:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284245AbRLFUbK>; Thu, 6 Dec 2001 15:31:10 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33594 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284244AbRLFUa6>; Thu, 6 Dec 2001 15:30:58 -0500
Date: Thu, 6 Dec 2001 21:31:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17pre4aa1
Message-ID: <20011206213135.Z6125@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.4.17pre1aa1: 00_lvm-1.0.1-rc4-5.bz2
Only in 2.4.17pre4aa1: 00_lvm-1.0.1-rc4-6.bz2
Only in 2.4.17pre1aa1: 00_rwsem-fair-24
Only in 2.4.17pre1aa1: 00_rwsem-fair-24-recursive-6
Only in 2.4.17pre4aa1: 00_rwsem-fair-25
Only in 2.4.17pre4aa1: 00_rwsem-fair-25-recursive-6
Only in 2.4.17pre1aa1: 00_silent-stack-overflow-11
Only in 2.4.17pre4aa1: 00_silent-stack-overflow-12
Only in 2.4.17pre1aa1: 10_vm-18
Only in 2.4.17pre4aa1: 10_vm-19

	Rediffed.

Only in 2.4.17pre4aa1: 00_pci-dma_mask-1

	Don't think you need GFP_DMA if the dma_mask of the device
	is over 4G.

Only in 2.4.17pre1aa1: 00_time_vs_gettimeofday-1

	Merged in mainline.

Only in 2.4.17pre1aa1: 60_tux-2.4.16-final-A3.bz2
Only in 2.4.17pre4aa1: 60_tux-2.4.16-final-C9.bz2

	Latest updates from Ingo at www.redhat.com/~mingo/.

Andrea
