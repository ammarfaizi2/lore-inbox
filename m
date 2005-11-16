Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVKPO0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVKPO0c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbVKPO0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:26:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49159 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030342AbVKPO0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:26:31 -0500
Date: Wed, 16 Nov 2005 15:27:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] new block/ directory comment tidy
Message-ID: <20051116142735.GJ7787@suse.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <20051113090156.GA4417@infradead.org> <20051113110517.GG3699@suse.de> <20051116061525.GA3035@localhost.localdomain> <20051116074850.GA20259@infradead.org> <20051116075732.GQ7787@suse.de> <20051116080855.GA3418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116080855.GA3418@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2005, Coywolf Qi Hunt wrote:
> On Wed, Nov 16, 2005 at 08:57:32AM +0100, Jens Axboe wrote:
> > On Wed, Nov 16 2005, Christoph Hellwig wrote:
> > > On Wed, Nov 16, 2005 at 02:15:25PM +0800, Coywolf Qi Hunt wrote:
> > > > On Sun, Nov 13, 2005 at 12:05:18PM +0100, Jens Axboe wrote:
> > > > > On Sun, Nov 13 2005, Christoph Hellwig wrote:
> > > > > > Shouldn't fs/bio.c, fs/block_dev.c and fs/partitions/* move to block/
> > > > > > aswell?
> > > > > 
> > > > > Yup, that's the intention. I just started off with drivers/block/* to
> > > > > get it going.
> > > >  
> > > > 
> > > > New block/ directory comment tidy.
> > > 
> > > Please just kill these lines instead.
> > 
> > Agree, they don't really add anything.
> 
> They did. Linus could use them as a hint to rescue his kernel source code after
> some filesystem crash. :p
> 
> Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>

Thanks applied.

-- 
Jens Axboe

