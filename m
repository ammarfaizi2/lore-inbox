Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbRHKM60>; Sat, 11 Aug 2001 08:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRHKM6R>; Sat, 11 Aug 2001 08:58:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15714 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267532AbRHKM6B>; Sat, 11 Aug 2001 08:58:01 -0400
Date: Sat, 11 Aug 2001 14:58:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8aa1
Message-ID: <20010811145813.B19169@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.4.8pre8aa1: 40_blkdev-pagecache-11
Only in 2.4.8aa1: 40_blkdev-pagecache-12

	Fixed a missing drop_super and some other detail related to
	superblock handling (superblock cannot go away anymore under
	us after a get_super, so some piece of code is been cleaned
	up).

Andrea
