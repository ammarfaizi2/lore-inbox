Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291502AbSBHJd2>; Fri, 8 Feb 2002 04:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291504AbSBHJdS>; Fri, 8 Feb 2002 04:33:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45070 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291502AbSBHJdK>;
	Fri, 8 Feb 2002 04:33:10 -0500
Date: Fri, 8 Feb 2002 10:33:05 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Skip Ford <skip.ford@verizon.net>
Subject: Re: Alpha update for 2.5.3
Message-ID: <20020208103305.M4942@suse.de>
In-Reply-To: <20020208015826.JIFG11848.out009.verizon.net@pool-141-150-235-204.delv.east.verizon.net> <Pine.LNX.4.10.10202071952340.15165-100000@master.linux-ide.org> <20020208040837.MDKA24823.out016.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208040837.MDKA24823.out016.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07 2002, Skip Ford wrote:
> Andre Hedrick wrote:
> > 
> > That code path will go away!
> > That is a diagnostic path only.
> 
> Sorry Jeff, and others, if that's the wrong patch.  It fixed the compile
> error for ide-dma so I used it.  I still haven't been able to test it
> due to link errors with bus_to_virt.

The patch is correct, I'm the one to blame for forgetting to push that.
And as I stated in my original mail, in the future it will be gone.
However, it still needs to compile right now :-)

> So if Andre is saying don't use it, then don't.  My apologies.

No need to apologise, the patch does the right thing.

-- 
Jens Axboe

