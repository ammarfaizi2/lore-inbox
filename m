Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289193AbSANLQr>; Mon, 14 Jan 2002 06:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289196AbSANLQi>; Mon, 14 Jan 2002 06:16:38 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:9491 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289193AbSANLQ0>; Mon, 14 Jan 2002 06:16:26 -0500
Date: Mon, 14 Jan 2002 12:14:47 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: <yodaiken@fsmlabs.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020113223438.A19324@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0201141201040.28881-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 13 Jan 2002 yodaiken@fsmlabs.com wrote:

> 	Nobody has answered my question about the conflict between SMP per-cpu caching
> 	and preempt. Since NUMA is apparently the future of MP in the PC world and
> 	the future of Linux servers, it's interesting to consider this tradeoff.

Preempt is a UP feature so far.

> 	Nobody has answered the question about how to make sure all processes
> 	make progress with preempt.

The same way as without preempt.

> 	Nobody has clearly explained how to avoid what I claim to be the inevitable
> 	result of preempt -- priority inheritance locks (not just semaphores).
> 	What we have is some "we'll figure that out when we get to it".

So far you haven't given any reason, how preempt should lead to this.
(If I missed something, please explain it in a way a mere mortal can
understand it.)

> 	It's not even clear how preempt is supposed to interact with SCHED_FIFO.

The same way as without preempt.

More of other FUD deleted, Victor, could you please stop this?

bye, Roman

