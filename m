Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbRFTOmW>; Wed, 20 Jun 2001 10:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbRFTOmM>; Wed, 20 Jun 2001 10:42:12 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36637 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264885AbRFTOmA>; Wed, 20 Jun 2001 10:42:00 -0400
Date: Wed, 20 Jun 2001 16:41:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20pre5aa1
Message-ID: <20010620164156.G22569@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.2.20pre3aa1 and 2.2.20pre5aa1:

Only in 2.2.20pre3aa1: 00_newboot-2.2.20-pre2-1.diff.gz

	Merged in 2.2.20pre5.

Only in 2.2.20pre3aa1: 00_mips-irix-dumpable-1

	Not needed anymore with the do_coredump() common code.

Only in 2.2.20pre3aa1: 00_parent-timeslice-loss-fix-4
Only in 2.2.20pre5aa1: 00_parent-timeslice-loss-fix-5

	Fixup rejects with asm_offsets.h sparc/sparc64 updates in pre5.

Andrea
