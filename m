Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281026AbRKCTms>; Sat, 3 Nov 2001 14:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281027AbRKCTmj>; Sat, 3 Nov 2001 14:42:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:49256 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281026AbRKCTm3>; Sat, 3 Nov 2001 14:42:29 -0500
Date: Sat, 3 Nov 2001 20:42:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14pre7aa1
Message-ID: <20011103204217.A2650@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.4.14pre6aa1: 00_block-highmem-all-18.bz2
Only in 2.4.14pre6aa1: 10_nohighio-discontigmem-1

	Backed out until we sort out the bugreports on real highmem.

Only in 2.4.14pre6aa1: 00_ksoftirqd-1

	Just in mainline.

Only in 2.4.14pre6aa1: 00_netconsole-2.4.10-C2
Only in 2.4.14pre7aa1: 00_netconsole-2.4.10-C2-1.bz2

	Minor update from tux patch.

Only in 2.4.14pre6aa1: 10_vm-10
Only in 2.4.14pre7aa1: 10_vm-11

	Latest vm updates. Merged Linus changes in mainline, also the VM_LOCKED
	one on l-k that certainly make sense to avoid inactive cache pollution.
	Now keeping dirty swap cache around like pre7 does, dubious
	optimization though but I want to see if it makes big differences.
	Fixed three vm corruption bugs (one longstanding pre-2.4.9). Good
	that Linus spotted a silly vm corruption bug that I was adding in
	those updates :), thanks.

Only in 2.4.14pre6aa1: 60_tux-2.4.13-ac4-A3.bz2
Only in 2.4.14pre7aa1: 60_tux-2.4.13-ac5-A5.bz2

	Latest tux update from www.redhat.com/~mingo, from Ingo Molnar.

Only in 2.4.14pre6aa1: 61_tux-logger-1

	Now in tux mainline.

Andrea
