Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSFDL6w>; Tue, 4 Jun 2002 07:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317483AbSFDL6v>; Tue, 4 Jun 2002 07:58:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40386 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317482AbSFDL6v>;
	Tue, 4 Jun 2002 07:58:51 -0400
Date: Tue, 4 Jun 2002 13:58:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020604115842.GA5143@suse.de>
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04 2002, Neil Brown wrote:
> On Tuesday June 4, axboe@suse.de wrote:
> > On Mon, Jun 03 2002, Mike Black wrote:
> > > RAID5 still doesn't compile....sigh....
> > 
> > [snip]
> > 
> > Some people do nothing but complain instead of trying to fix things.
> > Sigh...
> 
> I've got fixes.... but I want to suggest some changes to the plugging
> mechanism, and as it seems to have changed a bit since 2.5.20, I'll
> have to sync up my patch before I show it to you...

Excellent. I've sent the last plugging patch to Linus, which appears to
be ok/stable. If you could send changes relative to that, it would be
great.

What changes did you have in mind?

-- 
Jens Axboe

