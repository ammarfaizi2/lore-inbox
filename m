Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbTA1MMc>; Tue, 28 Jan 2003 07:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbTA1MMc>; Tue, 28 Jan 2003 07:12:32 -0500
Received: from [195.223.140.107] ([195.223.140.107]:32896 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265238AbTA1MMb>;
	Tue, 28 Jan 2003 07:12:31 -0500
Date: Tue, 28 Jan 2003 13:24:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Srihari Vijayaraghavan <harisri@bigpond.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Solved 2.4.21-pre3aa1 and RAID-0 issue (was: Re: 2.4.21-pre3aa1 and RAID0 issue]
Message-ID: <20030128122407.GK1237@dualathlon.random>
References: <200212270856.13419.harisri@bigpond.com> <200301271441.11112.harisri@bigpond.com> <20030127113002.GB889@suse.de> <200301282046.58473.harisri@bigpond.com> <20030128094433.GX17791@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128094433.GX17791@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 10:44:33AM +0100, Jens Axboe wrote:
> On Tue, Jan 28 2003, Srihari Vijayaraghavan wrote:
> > Hello Jens,
> > 
> > On Monday 27 January 2003 22:30, Jens Axboe wrote:
> > > Could you please try this patch on top of 2.4.21-pre3aa1 instead of
> > > backing out blk-atomic? Does that work, too? Thanks!
> > 
> > Yes, the RAID-0 works fine on 2.4.21-pre3aa1 after applying your patch on top 
> > of it.
> 
> Great, thanks for confirming that it solves the problem.

thanks. the patch is obviously right indeed.

Andrea
