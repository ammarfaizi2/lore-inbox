Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSJAKKH>; Tue, 1 Oct 2002 06:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261551AbSJAKKH>; Tue, 1 Oct 2002 06:10:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14830 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261549AbSJAKKH>;
	Tue, 1 Oct 2002 06:10:07 -0400
Date: Tue, 1 Oct 2002 12:15:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.39-mm1
Message-ID: <20021001101520.GB20878@suse.de>
References: <200209301941.41627.conman@kolivas.net> <3D98A7D0.8F07193F@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D98A7D0.8F07193F@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30 2002, Andrew Morton wrote:
> > io_load:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  216.05          33%             3.19
> > 2.5.38                  887.76          8%              13.11
> > 2.5.38-mm3              105.17          70%             1.55
> > 2.5.39                  229.4           34%             3.4
> > 2.5.39-mm1              239.5           33%             3.4
> 
> I think I'll set fifo_batch to 16 again...

As not to compare oranges and apples, I'd very much like to see a
2.5.39-mm1 vs 2.5.39-mm1 with fifo_batch=16. Con, would you do that?
Thanks!

-- 
Jens Axboe

