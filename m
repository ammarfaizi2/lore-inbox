Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRKDCZa>; Sat, 3 Nov 2001 21:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277559AbRKDCZU>; Sat, 3 Nov 2001 21:25:20 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:41492 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277533AbRKDCZH>; Sat, 3 Nov 2001 21:25:07 -0500
Date: Sun, 4 Nov 2001 03:25:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20aa1
Message-ID: <20011104032507.K1898@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20aa1/

Diff between 2.2.20pre10aa1 and 2.2.20aa1 (besides moving on top of
2.2.20):

Only in 2.2.20aa1: 00_local-freelist-race-1

	Fix irq race in the page allocator (spotted by Linus).

Andrea
