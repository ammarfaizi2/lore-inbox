Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280947AbRKTRb5>; Tue, 20 Nov 2001 12:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281180AbRKTRbr>; Tue, 20 Nov 2001 12:31:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:36130 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280947AbRKTRba>; Tue, 20 Nov 2001 12:31:30 -0500
Date: Tue, 20 Nov 2001 18:31:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15pre7aa1
Message-ID: <20011120183132.D2133@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre7aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre7aa1/

Only in 2.4.15pre7aa1: 00_block-highmem-all-18-1.bz2

	Trying new version again after Jens fixed the previous bugs.

Only in 2.4.15pre6aa1: 00_loop-sem-1

	In mainline.

Only in 2.4.15pre6aa1: 00_lowlatency-fixes-2
Only in 2.4.15pre7aa1: 00_lowlatency-fixes-3

	Make sure to reschedule also during balance_dirty() and try
	to decrease the write sched latency further.

Only in 2.4.15pre6aa1: 00_lvm-1.0.1-rc4-4.bz2
Only in 2.4.15pre7aa1: 00_lvm-1.0.1-rc4-5.bz2

	Rediffed.

Only in 2.4.15pre6aa1: 00_o_direct-4
Only in 2.4.15pre7aa1: 00_o_direct-5

	Rediffed.

Only in 2.4.15pre6aa1: 10_vm-14
Only in 2.4.15pre7aa1: 10_vm-15
Only in 2.4.15pre6aa1: 10_vm-14-no-anonlru-1
Only in 2.4.15pre6aa1: 10_vm-14-no-anonlru-1-simple-cache-1

	Reintroduced anon pages into the lru to better trigger
	the swap activities.

Only in 2.4.15pre6aa1: 50_uml-patch-2.4.14-2.bz2
Only in 2.4.15pre7aa1: 50_uml-patch-2.4.14-5.bz2

	Latest update from Jeff.

Andrea
