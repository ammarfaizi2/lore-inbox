Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVKPH4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVKPH4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbVKPH4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:56:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63260 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030208AbVKPH4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:56:32 -0500
Date: Wed, 16 Nov 2005 08:57:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Coywolf Qi Hunt <qiyong@fc-cn.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] new block/ directory comment tidy
Message-ID: <20051116075732.GQ7787@suse.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <20051113090156.GA4417@infradead.org> <20051113110517.GG3699@suse.de> <20051116061525.GA3035@localhost.localdomain> <20051116074850.GA20259@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116074850.GA20259@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2005, Christoph Hellwig wrote:
> On Wed, Nov 16, 2005 at 02:15:25PM +0800, Coywolf Qi Hunt wrote:
> > On Sun, Nov 13, 2005 at 12:05:18PM +0100, Jens Axboe wrote:
> > > On Sun, Nov 13 2005, Christoph Hellwig wrote:
> > > > Shouldn't fs/bio.c, fs/block_dev.c and fs/partitions/* move to block/
> > > > aswell?
> > > 
> > > Yup, that's the intention. I just started off with drivers/block/* to
> > > get it going.
> >  
> > 
> > New block/ directory comment tidy.
> 
> Please just kill these lines instead.

Agree, they don't really add anything.

-- 
Jens Axboe

