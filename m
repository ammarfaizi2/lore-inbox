Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJVMH>; Wed, 10 Jan 2001 16:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAJVLr>; Wed, 10 Jan 2001 16:11:47 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:15114 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S129406AbRAJVLg>;
	Wed, 10 Jan 2001 16:11:36 -0500
Date: Wed, 10 Jan 2001 22:11:58 +0100 (CET)
From: <kernel@ddx.a2000.nu>
To: Doug McNaught <doug@wireboard.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: unexplained high load
In-Reply-To: <m3n1czrubv.fsf@belphigor.mcnaught.org>
Message-ID: <Pine.LNX.4.30.0101102209000.4377-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2001, Doug McNaught wrote:

> <kernel@ddx.a2000.nu> writes:
>
> > think this, but problem, machine is running ok
> > no slow response, only load 1.00 (it's not getting lower)
>
> Process stuck in D state?
yes found it, proftpd
can't kill it (also tried -9)
why is this giving me a high load ?



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
