Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263810AbSIQHYt>; Tue, 17 Sep 2002 03:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263811AbSIQHYt>; Tue, 17 Sep 2002 03:24:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24728 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263810AbSIQHYt>;
	Tue, 17 Sep 2002 03:24:49 -0400
Date: Tue, 17 Sep 2002 09:29:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: Alan Cox <alan@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac4
Message-ID: <20020917072913.GK3289@suse.de>
References: <200209081255.g88CtHJ31280@devserv.devel.redhat.com> <m3elbth9cs.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3elbth9cs.fsf@lapper.ihatent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17 2002, Alexander Hoogerhuis wrote:
> Alan Cox <alan@redhat.com> writes:
> 
> > > Which non-free modues (NVidia?) were loaded on your computer? Is the
> > > problem reproducible without any non-free module loaded _ever_ since the
> > > last reboot?
> > 
> > I've seen this trace without nvidia etc loaded too. Right now the problem
> > I have is that I can't duplicate it. If my box would jut blow up the same
> > way all would be well 8)
> > 
> > What compilers are being used by the folks who see the problem ?
> 
> Back on the same track again, I've managed to get a oops dump from the
> DVD related oops I was having:
> 
> Sep 17 00:03:33 lapper kernel: kernel BUG at /home/alexh/src/linux/linux-2.4-ac-new/include/linux/blkdev.h:153!

this one I fixed, and fix should be in later -ac

-- 
Jens Axboe

