Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317486AbSFDL4P>; Tue, 4 Jun 2002 07:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317487AbSFDL4O>; Tue, 4 Jun 2002 07:56:14 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:2269 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S317486AbSFDL4N>; Tue, 4 Jun 2002 07:56:13 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jens Axboe <axboe@suse.de>
Date: Tue, 4 Jun 2002 21:56:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15612.43734.121255.771451@notabene.cse.unsw.edu.au>
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
In-Reply-To: message from Jens Axboe on Tuesday June 4
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 4, axboe@suse.de wrote:
> On Mon, Jun 03 2002, Mike Black wrote:
> > RAID5 still doesn't compile....sigh....
> 
> [snip]
> 
> Some people do nothing but complain instead of trying to fix things.
> Sigh...

I've got fixes.... but I want to suggest some changes to the plugging
mechanism, and as it seems to have changed a bit since 2.5.20, I'll
have to sync up my patch before I show it to you...

NeilBrown
