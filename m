Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262994AbSJBGqw>; Wed, 2 Oct 2002 02:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbSJBGqw>; Wed, 2 Oct 2002 02:46:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23170 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262994AbSJBGqu>;
	Wed, 2 Oct 2002 02:46:50 -0400
Date: Wed, 2 Oct 2002 08:51:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       peter@chubb.wattle.id.au
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <20021002065158.GA3867@suse.de>
References: <20021001221421.A7762@infradead.org> <Pine.LNX.4.33.0210011735100.4577-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210011735100.4577-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Linus Torvalds wrote:
> 
> On Tue, 1 Oct 2002, Christoph Hellwig wrote:
> > 
> > What about the 64bit sector_t (aka >2TB blockdevice) patches. 
> 
> I think we should do both 64-bit sector_t and 32-bit dev_t, although both 
> of them depend on how horrible the code ends up being. Example patches?

Peter had patches for 64-bit sector_t, and they looked pretty nice.
Definitely mergeable. Peter, do you have a recent version?

-- 
Jens Axboe

