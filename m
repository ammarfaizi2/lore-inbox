Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275485AbRJPJHR>; Tue, 16 Oct 2001 05:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275571AbRJPJHI>; Tue, 16 Oct 2001 05:07:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:530 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S275485AbRJPJG7>; Tue, 16 Oct 2001 05:06:59 -0400
Date: Tue, 16 Oct 2001 11:07:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13pre3aa1
Message-ID: <20011016110708.D2380@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.4.13pre2aa1: 00_lvm-1.0.1-rc4-1.bz2
Only in 2.4.13pre3aa1: 00_lvm-1.0.1-rc4-2.bz2

	Rediffed merging the unsigned long change in the blkdev size ioctl.

Only in 2.4.13pre2aa1: 00_vm-3.1
Only in 2.4.13pre3aa1: 00_vm-3.2

	Further vm minor updates. In particular make sure not to overstimate
	the amount of buffers available during balance_dirty(), by using the
	exact per-classzone active/inactive info.

Only in 2.4.13pre2aa1: 50_uml-patch-2.4.12-1-1.bz2
Only in 2.4.13pre3aa1: 50_uml-patch-2.4.12-3-1.bz2

	Latest update from Jeff.

Only in 2.4.13pre2aa1: 60_tux-2.4.10-ac10-F5.bz2
Only in 2.4.13pre3aa1: 60_tux-2.4.10-ac12-H1.bz2

	Latest update from Ingo.

Andrea
