Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRJ2NQu>; Mon, 29 Oct 2001 08:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRJ2NQk>; Mon, 29 Oct 2001 08:16:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27192 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273881AbRJ2NQY>; Mon, 29 Oct 2001 08:16:24 -0500
Date: Mon, 29 Oct 2001 14:17:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14pre3aa4
Message-ID: <20011029141700.E1318@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre3aa4.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre3aa4/

Only in 2.4.14pre3aa4: 00_tmpfs-symlink-1

	Fix from Herbert Xu and Christoph Rohland for the i_size
	of tmpfs symlinks.

Only in 2.4.14pre3aa3: 10_vm-7
Only in 2.4.14pre3aa3: 10_vm-7.1
Only in 2.4.14pre3aa4: 10_vm-8

	Minor vm changes, in particular don't shrink the vfs with the
	pagemap_lru_lock acquired, and use GFP_NOIO in free_more_memory()
	per Linus's suggestion to avoid too much nesting on the stack.

Andrea
