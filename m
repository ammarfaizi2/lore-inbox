Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136562AbRA1Cne>; Sat, 27 Jan 2001 21:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136668AbRA1CnY>; Sat, 27 Jan 2001 21:43:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16393 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136562AbRA1CnL>;
	Sat, 27 Jan 2001 21:43:11 -0500
Date: Sun, 28 Jan 2001 03:43:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Bratcher <mbratche@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0 loop device still hangs
Message-ID: <20010128034300.A32375@suse.de>
In-Reply-To: <3A70EF20.1B02B307@rochester.rr.com> <3A72E8C7.138BB69E@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A72E8C7.138BB69E@rochester.rr.com>; from mbratche@rochester.rr.com on Sat, Jan 27, 2001 at 10:27:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27 2001, Mark Bratcher wrote:
> Hey all,
> 
> I applied the patch "loop-3", from Jen Axboe's 2.4.1-pre10 version, to
> my 2.4.0 kernel as Jen had suggested we try for the loop device hang
> problem.
> 
> This patch appears to have gotten rid of the problem (at least after
> testing it once in my previous scenario, which would normally fail 100%
> of the time on 2.4.0 official).
> 
> Thanks Jen!

First of all, I'm all man (not up for debate) so it's Jens not Jen :-)

> Can I continue running this patch on 2.4.0 with impunity, or do I need
> to be careful of anything else? :-)

It should be safe. Thanks for the feedback.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
