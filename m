Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269455AbRHGU7k>; Tue, 7 Aug 2001 16:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269435AbRHGU7a>; Tue, 7 Aug 2001 16:59:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:10840 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269438AbRHGU7S>; Tue, 7 Aug 2001 16:59:18 -0400
Date: Tue, 7 Aug 2001 23:00:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20pre8aa1
Message-ID: <20010807230030.B688@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.2.20pre7aa1 and 2.2.20pre8aa1:

Moved on top of 2.2.20pre8.

Only in 2.2.20pre7aa1: 00_alpha-epoch-2
Only in 2.2.20pre8aa1: 00_alpha-mips-rtc-1

	Alpha epoch guess updates from Christopher C. Chimelis.

Only in 2.2.20pre8aa1: 00_alpha-fp-disabled-1

	local DoS fix (if fpu disabled via palcode) from Daniel Potts.

Only in 2.2.20pre8aa1: 00_alpha-illop-1

	kill task with illegal opcode from Rick Gorton.

Only in 2.2.20pre8aa1: 00_alpha-smp_tune_scheduling-1

	Christopher C. Chimelis reported some machine has
	trouble with the tune_scheduling function, so updated
	to take care of the cpuid of the boot cpu.

Only in 2.2.20pre8aa1: 00_poll-max_fds-1

	Fix poll semantics in sync with 2.4.8pre.

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20pre8aa1/
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20pre8aa1.bz2

Andrea
