Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271770AbRHRENZ>; Sat, 18 Aug 2001 00:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271771AbRHRENT>; Sat, 18 Aug 2001 00:13:19 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:42781 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271770AbRHRENI>; Sat, 18 Aug 2001 00:13:08 -0400
Date: Sat, 18 Aug 2001 06:13:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: o_direct-14 and blkdev-pagecache-14
Message-ID: <20010818061330.C1719@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can find the latest O_DIRECT and blkdev in pagecache patches against
vanilla 2.4.9 here (not only in -aa):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.9/o_direct-14
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.9/blkdev-pagecache-14

As usual the blkdev-pagecache patch depends on o_direct so it is an
incremental patch.

Thanks to Janet Morgan for the O_DIRECT auditing.

Andrea
