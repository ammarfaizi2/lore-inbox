Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272716AbRHaO4n>; Fri, 31 Aug 2001 10:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272717AbRHaO4e>; Fri, 31 Aug 2001 10:56:34 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:1748 "EHLO e23.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S272716AbRHaO4Y>;
	Fri, 31 Aug 2001 10:56:24 -0400
Date: Fri, 31 Aug 2001 07:52:01 -0700
From: Jonathan Lahr <lahr@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: lahr@beaverton.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010831075201.N23680@us.ibm.com>
In-Reply-To: <20010830134930.F23680@us.ibm.com> <20010831075613.A2855@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010831075613.A2855@suse.de>; from axboe@suse.de on Fri, Aug 31, 2001 at 07:56:13AM +0200
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

Please elaborate on "no, no, no".   Are you suggesting that no further
improvements can be made or should be attempted on the 2.4 i/o subsystem?

Jonathan

Jens Axboe [axboe@suse.de] wrote:
> On Thu, Aug 30 2001, Jonathan Lahr wrote:
> > 
> > Included below is a snapshot of a patch I am developing to reduce 
> > io_request_lock contention in 2.4.  
> 
> No no no, you are opening a serious can of worms. No offense, but did
> you really think this would fly?! This is already being taken care of
> for 2.5, lets leave 2.4 alone in this regard.
> 
> -- 
> Jens Axboe

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

