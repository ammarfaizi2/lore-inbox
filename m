Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277138AbRJHXE4>; Mon, 8 Oct 2001 19:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277591AbRJHXEq>; Mon, 8 Oct 2001 19:04:46 -0400
Received: from [208.129.208.52] ([208.129.208.52]:24849 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277138AbRJHXEj>;
	Mon, 8 Oct 2001 19:04:39 -0400
Date: Mon, 8 Oct 2001 16:10:20 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: Scheduler latency tester ...
Message-ID: <Pine.LNX.4.40.0110081602450.1412-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This weekend i've been playing with the scheduler trying to measure the
impact of some code tuning.
I changed my original threads.c to add cache drain effects on the
scheduler performance plus other tuning features.
For the ones interested the code is here :

http://www.xmailserver.org/lat-sched.c




- Davide


