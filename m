Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbRE2KUQ>; Tue, 29 May 2001 06:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261735AbRE2KUG>; Tue, 29 May 2001 06:20:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49161 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261715AbRE2KUD>;
	Tue, 29 May 2001 06:20:03 -0400
Date: Tue, 29 May 2001 12:19:54 +0200
From: Jens Axboe <axboe@kernel.org>
To: Fabio Riccardi <fabio@chromium.com>
Cc: "Leeuw van der, Tim" <tim.leeuwvander@nl.unisys.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac2
Message-ID: <20010529121954.J26871@suse.de>
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB033ED2F0@NL-ASD-EXCH-1> <3B13542A.5DBA3903@chromium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B13542A.5DBA3903@chromium.com>; from fabio@chromium.com on Tue, May 29, 2001 at 12:47:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29 2001, Fabio Riccardi wrote:
> "Leeuw van der, Tim" wrote:
> 
> > But the claim was that 2.4.5-ac2 is faster than 2.4.5 plain, so which
> > changes are in 2.4.5-ac2 that would make it faster than 2.4.5 plain? Also, I
> > don't know if 2.4.5-ac1 is as fast as 2.4.5-ac2 for Fabio. If not, then it's
> > a change in the 2.4.5-ac2 changelog. If it is as fast, it is one of the
> > changes in the 2.4.5-ac1 changelog.
> 
> 2.4.5-ac1 crashed on my machine, vanilla 2.4.5 worked but slower than 2.4.2
> 
> 2.4.5-ac2 is _a lot_ faster than all the 2.4.4 and of vanilla 2.4.5
> 
> please notice that I have a 4G machine, dual proc, and I run a very
> memory/IO/CPU intensive test, so your mileage may vary with different
> applications.

Could you try the 4GB I/O patches and see if they boost performance of
such cases?

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5/

-- 
Jens Axboe

