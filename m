Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSFGTrx>; Fri, 7 Jun 2002 15:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSFGTrw>; Fri, 7 Jun 2002 15:47:52 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31792 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317331AbSFGTrv>; Fri, 7 Jun 2002 15:47:51 -0400
Date: Fri, 7 Jun 2002 21:47:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre10aa2
Message-ID: <20020607194749.GS1004@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa2/

Diffs:

Only in 2.4.19pre10aa1: 00_nfs-backout-cto-1
Only in 2.4.19pre10aa2: 00_nfs_mtime-change-if-invalid-1

	Try new patch from Trond to fix mtime updates in cto.

Only in 2.4.19pre10aa1: 90_ext3-commit-interval-1
Only in 2.4.19pre10aa2: 90_ext3-commit-interval-2

	Allow compilation as module. Also moved the bdf_prm into
	a separate .h file, so it is cleaner and now it provides the
	same API of an extern bdflush_interval().

Andrea
