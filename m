Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSG1WuP>; Sun, 28 Jul 2002 18:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSG1WuK>; Sun, 28 Jul 2002 18:50:10 -0400
Received: from [195.223.140.120] ([195.223.140.120]:17177 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317393AbSG1WuE>; Sun, 28 Jul 2002 18:50:04 -0400
Date: Sat, 27 Jul 2002 03:34:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc3aa2
Message-ID: <20020727013408.GB1160@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ULR:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa2/

Diff between rc3aa1 and rc3aa2:

Only in 2.4.19rc3aa2: 00_apm-do_read-1

	Signed int check from -ac.

Only in 2.4.19rc3aa2: 00_d_unhash-race-1

	Race fix from -ac.

Only in 2.4.19rc3aa2: 00_extraversion-1

	Set extraversion.

Only in 2.4.19rc3aa2: 00_o_direct-blkdev-1

	Allow databases that need hardblocksize granularity to use
	O_DIRECT on the blkdev, rather than rawio, rawio is now
	obsoleted (idea from Chris).

Only in 2.4.19rc3aa1: 00_poll-speedup-2

	Backed out because buggy, sent report to Andi so he can fix it.

Only in 2.4.19rc3aa2: 00_posix-lock-overflow-1

	Handle fl_end being MAX_OFFSET right from -ac.

Only in 2.4.19rc3aa1: 50_uml-patch-2.4.18-42.gz
Only in 2.4.19rc3aa2: 50_uml-patch-2.4.18-43.gz
Only in 2.4.19rc3aa1: 52_uml-sys-read-write-2
Only in 2.4.19rc3aa2: 52_uml-sys-read-write-3

	Latest updates from Jeff.

Only in 2.4.19rc3aa1: 90_buddyinfo-2
Only in 2.4.19rc3aa2: 90_buddyinfo-3

	Fixed a bug that oopsed the kernel, from William.

Only in 2.4.19rc3aa2: 90_module-oops-tracking-1

	Add ID and module oops tracking information into the oops
	so that oopses with modules involved can be resolved
	reliably.

Only in 2.4.19rc3aa1: 90_s390-aa-1
Only in 2.4.19rc3aa2: 90_s390-aa-2

	s390 further compilation updates.

Only in 2.4.19rc3aa2: 90_s390x-aa-1

	s390x compilation updates.

Only in 2.4.19rc3aa1: 96_inode_read_write-atomic-2
Only in 2.4.19rc3aa2: 96_inode_read_write-atomic-3

	Added CONFIG_X86_CMPXCHG8 to fix 486+SMP compilation.

Andrea
