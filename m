Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSLZKUH>; Thu, 26 Dec 2002 05:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSLZKUH>; Thu, 26 Dec 2002 05:20:07 -0500
Received: from [195.223.140.107] ([195.223.140.107]:3968 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S262859AbSLZKUH>;
	Thu, 26 Dec 2002 05:20:07 -0500
Date: Thu, 26 Dec 2002 11:28:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre2aa2
Message-ID: <20021226102814.GB6938@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm leaving for vacations in 5 minutes so hopefully this will compile
for everybody ;) [I know, mylex still doesn't compile without backing
out the elevator-lowlatency patch but I hadn't time to fix it yet], I'll
be back online on 3 Jan.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre2aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre2aa2/

diff between 2.4.21pre2aa1 and 2.4.21pre2aa2:

Only in 2.4.21pre2aa1: 10_rawio-vary-io-15
Only in 2.4.21pre2aa2: 10_rawio-vary-io-16

	Fix compilation.

Andrea
