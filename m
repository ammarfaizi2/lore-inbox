Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSGSUz3>; Fri, 19 Jul 2002 16:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSGSUz3>; Fri, 19 Jul 2002 16:55:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11219 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317059AbSGSUz2>;
	Fri, 19 Jul 2002 16:55:28 -0400
Date: Sat, 20 Jul 2002 22:57:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
In-Reply-To: <Pine.LNX.4.44.0207202235400.23137-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207202256001.23747-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the following patch, against 2.5.26:
> 
>   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.26-A2

forgot to mention that the patch applies ontop the scheduler-improvements
patch:

    http://redhat.com/~mingo/O(1)-scheduler/sched-nobatch-2.5.26-C2

	Ingo

