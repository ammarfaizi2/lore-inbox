Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263144AbSJBPWg>; Wed, 2 Oct 2002 11:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbSJBPWg>; Wed, 2 Oct 2002 11:22:36 -0400
Received: from [195.223.140.120] ([195.223.140.120]:17508 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263144AbSJBPWf>; Wed, 2 Oct 2002 11:22:35 -0400
Date: Wed, 2 Oct 2002 09:11:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20pre8aa2
Message-ID: <20021002071110.GC1158@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre8aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre8aa2/

Changelog between 2.4.20pre8aa1 and 2.4.20pre8aa2:

Only in 2.4.20pre8aa1: 00_extraversion-8
Only in 2.4.20pre8aa2: 00_extraversion-9

	Rediffed.

Only in 2.4.20pre8aa2: 00_proc-cmdline-1

	Read within the page.

Only in 2.4.20pre8aa2: 00_thinkpad-1

	Thinkpad support at http://tpctl.sourceforge.net/ integrated
	by Chip Salzenberg.

Only in 2.4.20pre8aa2: 00_usb_get_string-len-1

	Don't read behind the end of the string
	to avoid timeouts with some hardware. From Andreas Klein.

Only in 2.4.20pre8aa1: 08_qlogicfc-template-aa-3
Only in 2.4.20pre8aa2: 08_qlogicfc-template-aa-4

	Allow qlogicfc to compile.

Only in 2.4.20pre8aa1: 20_sched-o1-fixes-1
Only in 2.4.20pre8aa2: 20_sched-o1-fixes-2

	Resurrect the starvation logic, fix the idle->prio value, and further
	fixes to the run-child-first logic too.

Only in 2.4.20pre8aa2: 84_x86-64-arch-1
Only in 2.4.20pre8aa2: 85_x86-64-includes-1

	Synchronize x86-64 with all the additional features
	(aio, cpu affinity etc..)

Only in 2.4.20pre8aa1: 9900_aio-8.gz
Only in 2.4.20pre8aa2: 9900_aio-9.gz

	Add reiserfs support and fix one bug with timeout
	null to getevents. From Chris Mason.

Andrea
