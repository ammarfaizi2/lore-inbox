Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270558AbSISJAI>; Thu, 19 Sep 2002 05:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270563AbSISJAI>; Thu, 19 Sep 2002 05:00:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42947 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S270558AbSISJAH>;
	Thu, 19 Sep 2002 05:00:07 -0400
Date: Thu, 19 Sep 2002 11:01:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: 2.5.34-mm4
Message-ID: <20020919090139.GD936@suse.de>
References: <20020915211002.A13470@wotan.suse.de> <Pine.LNX.3.96.1020916144915.6180F-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020916144915.6180F-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16 2002, Bill Davidsen wrote:
> On Sun, 15 Sep 2002, Andi Kleen wrote:
> 
> > > Overall I find Marcelo kernels to be the most comfortable, followed
> > > by 2.5.  Alan's kernels I find to be the least comfortable in a
> > 
> > ... and -aa kernels are marcelo kernels, just with the the corner
> > cases fixed too. Works very nicely here.
> 
> Corner cases? The IDE, VM and scheduler are different...

The IDE is the same, I'll refrain from commenting on the rest. There's
just an adjustment to the read ahead, which makes sense.

-- 
Jens Axboe

