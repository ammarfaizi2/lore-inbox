Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132208AbRAIW7H>; Tue, 9 Jan 2001 17:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132050AbRAIW66>; Tue, 9 Jan 2001 17:58:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26126 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132397AbRAIW6s>;
	Tue, 9 Jan 2001 17:58:48 -0500
Date: Tue, 9 Jan 2001 23:58:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Evans <chris@scary.beasts.org>, linux-kernel@vger.kernel.org
Subject: [patch]: ac4 blk (was Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1)
Message-ID: <20010109235830.F12128@suse.de>
In-Reply-To: <Pine.LNX.4.30.0101091755320.25936-100000@ferret.lmh.ox.ac.uk> <Pine.LNX.4.30.0101091940480.7155-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101091940480.7155-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 07:41:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09 2001, Ingo Molnar wrote:
> 
> > > but in 2.4, with the right patch from Jens, it doesnt suck anymore. )
> >
> > Is this "right patch from Jens" on the radar for 2.4 inclusion?
> 
> i do hope so!

Here's a version against 2.4.0-ac4, blk-13B did not apply cleanly due to
moving of i2o files and S/390 dasd changes:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-ac4/blk-13C.bz2

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
