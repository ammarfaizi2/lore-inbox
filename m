Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271769AbRHREGZ>; Sat, 18 Aug 2001 00:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271770AbRHREGP>; Sat, 18 Aug 2001 00:06:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29468 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271769AbRHREGJ>; Sat, 18 Aug 2001 00:06:09 -0400
Date: Sat, 18 Aug 2001 06:06:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20pre9aa2
Message-ID: <20010818060631.B1719@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.2.20pre9aa1 and 2.2.20pre9aa2:

Only in 2.2.20pre9aa1: 00_poll-nfds-1
Only in 2.2.20pre9aa2: 00_poll-nfds-2

	Fixed off by one error in the rlimit check.

Only in 2.2.20pre9aa1: 40_lfs-2.2.19pre16aa1-26.bz2
Only in 2.2.20pre9aa2: 40_lfs-2.2.20pre9aa2-27.bz2

	Drop obsolete (and duplicated) fcntl64 definition in the sparc
	unistd.h. (this was a lonstanding bug, it never triggered yet because
	glibc gets compiled with the 2.4 headers)

Andrea
