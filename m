Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbRAJABA>; Tue, 9 Jan 2001 19:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbRAJAAu>; Tue, 9 Jan 2001 19:00:50 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20528 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129933AbRAJAAj>; Tue, 9 Jan 2001 19:00:39 -0500
Date: Wed, 10 Jan 2001 01:00:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010110010053.M29904@athlon.random>
In-Reply-To: <20010109205420.H29904@athlon.random> <Pine.LNX.4.30.0101092108240.8236-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101092108240.8236-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 09:10:24PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 09:10:24PM +0100, Ingo Molnar wrote:
> 
> On Tue, 9 Jan 2001, Andrea Arcangeli wrote:
> 
> > BTW, I noticed what is left in blk-13B seems to be my work (Jens's
> > fixes for merging when the I/O queue is full are just been integrated
> > in test1x).  [...]
> 
> it was Jens' [i think those were implemented by Jens entirely]
> batch-freeing changes that made the most difference. (we did

Confirm, the bach-freeing was Jens's work.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
