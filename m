Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263261AbSJHNyq>; Tue, 8 Oct 2002 09:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbSJHNyN>; Tue, 8 Oct 2002 09:54:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47776 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263237AbSJHNxO>;
	Tue, 8 Oct 2002 09:53:14 -0400
Date: Tue, 8 Oct 2002 15:58:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Morten Helgesen <morten.helgesen@nextframe.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ide tcq support, 2.5.40-bk
Message-ID: <20021008135851.GA2664@suse.de>
References: <20021007140054.GD1160@suse.de> <20021008155748.A134@sexything>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008155748.A134@sexything>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08 2002, Morten Helgesen wrote:
> Hi, 
> 
> On Mon, Oct 07, 2002 at 04:00:54PM +0200, Jens Axboe wrote:
> > Hi,
> > 
> > Tagged command queueing support for IDE is available again. It has a few
> > rough edges from a source style POV, nothing that should impact
> > stability though.
> > 
> 
> [snip]
> 
> great work as usual - running it on 2.5.41. I`ve given it a good
> beating on my old WD Experts, but haven`t met any problems yet.

Thanks for testing!

> I`d like this to go into mainline (again) - when Jens feels 
> the time is right, of course.

I submitted it earlier today.

-- 
Jens Axboe

