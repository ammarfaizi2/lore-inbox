Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRLUMht>; Fri, 21 Dec 2001 07:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRLUMhi>; Fri, 21 Dec 2001 07:37:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:48923 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280984AbRLUMhY>; Fri, 21 Dec 2001 07:37:24 -0500
Date: Fri, 21 Dec 2001 13:37:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17rc2aa2
Message-ID: <20011221133729.A22527@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc2aa2.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc2aa2/

Only in 2.4.17rc2aa2/: 00_find_or_create_page-1

	Fix crash when grap_cache_page runs oom.

Only in 2.4.17rc2aa2/: 00_get_block-leftovers-1

	Cure fs corruption for ext[23]/reiserfs when disk fill up.
	writepage isn't fixed, but writepage should reserve its
	blocks in the first place.

Only in 2.4.17rc2aa2/: 00_ramdisk-buffercache-1

	Fix ramdisk corruption. (from Linus)

Only in 2.4.17rc2aa2/: 30_alpha-wildfire-numa-generic-1

	Make discontigmem available with an alpha generic kernel.
	(from Jeff Wiedemeier)

Only in 2.4.17rc2aa2/: 52_uml-pgtable_cache_init-1

	Fix uml compilation minor trouble.

Only in 2.4.17rc2aa1: 60_tux-2.4.16-final-D6.bz2
Only in 2.4.17rc2aa2/: 60_tux-2.4.16-final-E2.bz2

	Update to latest tux from Ingo at www.redhat.com/~mingo/ .

Andrea
