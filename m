Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSFTQ7f>; Thu, 20 Jun 2002 12:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSFTQ7e>; Thu, 20 Jun 2002 12:59:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14944 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315370AbSFTQ7b>; Thu, 20 Jun 2002 12:59:31 -0400
Date: Thu, 20 Jun 2002 19:00:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre10aa4
Message-ID: <20020620170047.GB1134@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a mistake from my part in task_rq_lock and integrates the
latest version of e100 e1000 per jam's suggestion, it works again on
alpha (was a tux compile trouble).

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa4.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre10aa4/

Only in 2.4.19pre10aa4: 00_e100-2.0.30-k1.gz
Only in 2.4.19pre10aa4: 00_e1000-4.2.17-k1.gz
Only in 2.4.19pre10aa3: 07_e100-1.8.38.gz
Only in 2.4.19pre10aa3: 08_e100-includes-1
Only in 2.4.19pre10aa3: 09_e100-compilehack-1

	e100 and e1000 from 2.4.19pre10jam2.

Only in 2.4.19pre10aa3: 20_o1-sched-updates-A4-1
Only in 2.4.19pre10aa4: 20_o1-sched-updates-A4-2

	Cleanup alpha and fix lock_rq_task.

Only in 2.4.19pre10aa4: 61_tux-alpha-compile-1

	Fix compile problem with tux on alpha.

Andrea
