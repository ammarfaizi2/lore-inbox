Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288277AbSBDD3l>; Sun, 3 Feb 2002 22:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288280AbSBDD3W>; Sun, 3 Feb 2002 22:29:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48283 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288277AbSBDD3B>;
	Sun, 3 Feb 2002 22:29:01 -0500
Date: Mon, 4 Feb 2002 06:26:44 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] O(1) scheduler, -K2
Message-ID: <Pine.LNX.4.33.0202040621400.22435-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -K2 O(1) scheduler patch for kernels 2.5.3, 2.4.18-pre7 and 2.4.17 is
available at:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.3-K2.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-K2.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.18-pre7-K2.patch

the -K2 patch includes fixes, cleanups, performance improvements and
interactivity improvements.

Bug reports, comments, suggestions are welcome,

	Ingo

