Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292285AbSBTUeo>; Wed, 20 Feb 2002 15:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292292AbSBTUeZ>; Wed, 20 Feb 2002 15:34:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:5722 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292285AbSBTUeG>; Wed, 20 Feb 2002 15:34:06 -0500
Date: Wed, 20 Feb 2002 21:34:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.21pre2aa2
Message-ID: <20020220213405.C1291@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.21pre2aa2.gz
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.21pre2aa2/

Only in 2.2.21pre2aa2: 00_af_unix-null-1

	Fix null pointer check in af_unix code, from Paul Menage.

Only in 2.2.21pre2aa1: 98_page-coloring-1
Only in 2.2.21pre2aa2: 98_page-coloring-13

	Latest greatest updates for the page coloring feature. Recommended use
	for the number crunching is with shrink_cache=1 mode=1. Also selectable
	via boot option, read the code for details. Leads to improvements of
	400% on alpha. Performance are completly reproducible after the
	feature is enabled. Works on x86 and on all other archs too.
	Mandatory feature for all the alpha clusters. Thanks for the
	collaboration in the developement of this patch to the Compaq
	department in Annecy and to Jason Papadopoulos for large part of
	the allocator engine.

Andrea
