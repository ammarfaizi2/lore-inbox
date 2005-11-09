Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVKIHyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVKIHyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 02:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVKIHyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 02:54:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50794 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751273AbVKIHyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 02:54:02 -0500
Date: Wed, 9 Nov 2005 08:54:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Neil Brown <neilb@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: userspace block driver?
Message-ID: <20051109075455.GN3699@suse.de>
References: <4371A4ED.9020800@pobox.com> <17265.42782.188870.907784@cse.unsw.edu.au> <4371A944.6070302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4371A944.6070302@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09 2005, Jeff Garzik wrote:
> Neil Brown wrote:
> >On Wednesday November 9, jgarzik@pobox.com wrote:
> >
> >>Has anybody put any thought towards how a userspace block driver
> >>would work?
> >
> >
> >Isn't this was enbd does? 
> >  http://www.it.uc3m.es/~ptb/nbd/
> 
> Is there something there relevant for modern kernels?  I would sure hope 
> I could come up with something more lightweight than that.

I was going to say drbd, but then you did say more lightweight :-)

Is nbd completely screwed these days?

-- 
Jens Axboe

