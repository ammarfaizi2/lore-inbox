Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSAFCLr>; Sat, 5 Jan 2002 21:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286938AbSAFCLk>; Sat, 5 Jan 2002 21:11:40 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16276 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286949AbSAFCLJ>;
	Sat, 5 Jan 2002 21:11:09 -0500
Date: Sun, 6 Jan 2002 05:08:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201060427590.4730-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201060508110.5193-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


doh, the -B1 patch was short by 10k, -B2 is OK:

   http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-B2.patch

	Ingo

