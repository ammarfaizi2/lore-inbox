Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130843AbQK1FJh>; Tue, 28 Nov 2000 00:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130749AbQK1FJ2>; Tue, 28 Nov 2000 00:09:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25867 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S130843AbQK1FJK>; Tue, 28 Nov 2000 00:09:10 -0500
Date: Mon, 27 Nov 2000 20:38:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre2
In-Reply-To: <14883.10909.19147.677679@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.10.10011272036310.1117-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2000, Neil Brown wrote:
> 
> What happens about the stuff that went in to 2.4.0test11-ac{1,2,3,4}?
> Are you going to "sync-up" with Alan, or should we send bits directly
> to you?

Either, or both.

Alan feeds me his patches in small chunks anyway, and does a good job of
keeping stuff separate. Re-sending directly to me means that Alan would
just drop that part of the patch - or that I'd get the patch twice. Both
of which work ok, as long as it's the _same_ patch.

If you've made modifications since sending the stuff to Alan, you should
synchronize with Alan too - just to make sure that I don't en dup applying
the old stuff through Alan.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
