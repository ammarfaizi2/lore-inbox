Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133023AbREHRvF>; Tue, 8 May 2001 13:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133029AbREHRuz>; Tue, 8 May 2001 13:50:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40965 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S133023AbREHRur>;
	Tue, 8 May 2001 13:50:47 -0400
Date: Tue, 8 May 2001 19:50:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Ben Fennema <bfennema@ix.netcom.com>
Cc: cacook@freedom.net, linux-kernel@vger.kernel.org
Subject: Re: write to dvd ram
Message-ID: <20010508195030.J505@suse.de>
In-Reply-To: <91FD33983070D21188A10008C728176C09421202@LDMS6003> <20010508145400Z132655-406+505@vger.kernel.org> <20010508100129.19740@dragon.linux.ix.netcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010508100129.19740@dragon.linux.ix.netcom.com>; from bfennema@ix.netcom.com on Tue, May 08, 2001 at 10:01:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08 2001, Ben Fennema wrote:
> > The log is:
> > Apr 15 20:58:27 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting
> > volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
> 
> At the very least, run 0.9.3 from sourceforce (or the cvs version) and
> see if it works any better.

I was just about to say the same thing, 0.9.3 works well for me. In fact
so well, that I made a patch to bring 2.4.5-pre1 UDF up to date with
current CVS earlier this afternoon (hint hint, Ben :-).

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5-pre1/

udf-0.9.3-2.4.5p1-1.bz2

-- 
Jens Axboe

