Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWGUMjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWGUMjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 08:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWGUMjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 08:39:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29494 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161067AbWGUMjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 08:39:12 -0400
Date: Fri, 21 Jul 2006 14:38:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Panagiotis Issaris <takis@gna.org>
Cc: takis@issaris.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Conversions from kmalloc+memset to k(z|c)alloc
Message-ID: <20060721123827.GA26368@suse.de>
References: <20060721113210.GB11822@issaris.org> <20060721121352.GB25045@suse.de> <1153485124.9489.37.camel@hemera>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153485124.9489.37.camel@hemera>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21 2006, Panagiotis Issaris wrote:
> Hi,
> 
> On vr, 2006-07-21 at 14:13 +0200, Jens Axboe wrote:
> > On Fri, Jul 21 2006, takis@issaris.org wrote:
> > > From: Panagiotis Issaris <takis@issaris.org>
> > > 
> > > block: Conversions from kmalloc+memset to kzalloc
> > 
> > They are already done in the block git repo.
> Weird, I had even checked if they weren't already done:
> http://kernel.org/git/?p=linux/kernel/git/axboe/linux-2.6-block.git;a=blob;h=102ebc2c5c34c73f8e7f76c589559ddfde0d9885;hb=82d6897fefca6206bca7153805b4c5359ce97fc4;f=block/cfq-iosched.c
> 
> Am I looking at the wrong repos, or is it just not in sync
> with your daily work?

It should be in the iosched branch.

-- 
Jens Axboe

