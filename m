Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbTA1Jfh>; Tue, 28 Jan 2003 04:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbTA1Jfg>; Tue, 28 Jan 2003 04:35:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25540 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264950AbTA1Jfe>;
	Tue, 28 Jan 2003 04:35:34 -0500
Date: Tue, 28 Jan 2003 10:44:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>,
       Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Solved 2.4.21-pre3aa1 and RAID-0 issue (was: Re: 2.4.21-pre3aa1 and RAID0 issue]
Message-ID: <20030128094433.GX17791@suse.de>
References: <200212270856.13419.harisri@bigpond.com> <200301271441.11112.harisri@bigpond.com> <20030127113002.GB889@suse.de> <200301282046.58473.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301282046.58473.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28 2003, Srihari Vijayaraghavan wrote:
> Hello Jens,
> 
> On Monday 27 January 2003 22:30, Jens Axboe wrote:
> > Could you please try this patch on top of 2.4.21-pre3aa1 instead of
> > backing out blk-atomic? Does that work, too? Thanks!
> 
> Yes, the RAID-0 works fine on 2.4.21-pre3aa1 after applying your patch on top 
> of it.

Great, thanks for confirming that it solves the problem.

-- 
Jens Axboe

