Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbREZWdY>; Sat, 26 May 2001 18:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbREZWdO>; Sat, 26 May 2001 18:33:14 -0400
Received: from chiara.elte.hu ([157.181.150.200]:4104 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261458AbREZWdF>;
	Sat, 26 May 2001 18:33:05 -0400
Date: Sat, 26 May 2001 21:42:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ben LaHaise <bcrl@redhat.com>, Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526203104.E1834@athlon.random>
Message-ID: <Pine.LNX.4.33.0105262141010.1695-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 May 2001, Andrea Arcangeli wrote:

> On Sat, May 26, 2001 at 02:11:15PM -0400, Ben LaHaise wrote:
> > No.  It does not fix the deadlock.  Neither does the patch you posted.
>
> can you give a try if you can deadlock 2.4.5aa1 just in case, and post a
> SYSRQ+T + system.map if it still deadlocks?

Andrea, can you rather start running the Cerberus testsuite instead? All
these deadlocks happen pretty early during the test, and we've been fixing
tons of these deadlocks, and no, it's not easy.

	Ingo

