Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTIRHbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 03:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTIRHbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 03:31:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43933 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263008AbTIRHbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 03:31:18 -0400
Date: Thu, 18 Sep 2003 09:30:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: Re: laptop mode for 2.4.23-pre4 and up
Message-ID: <20030918073058.GU906@suse.de>
References: <20030913103014.GA7535@gamma.logic.tuwien.ac.at> <20030914152755.GA27105@suse.de> <20030915093221.GE2268@gamma.logic.tuwien.ac.at> <20030917075432.GG906@suse.de> <16232.50511.199563.3211@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16232.50511.199563.3211@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18 2003, Peter Chubb wrote:
> >>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:
> 
> Jens> On Mon, Sep 15 2003, Norbert Preining wrote:
> >> On Son, 14 Sep 2003, Jens Axboe wrote: > > Will there be a new
> >> incantation of the laptop-mode patch for 2.4.23-pre4
> >> > 
> >> > Sure, I'll done a new patch in the next few days. 
> 
> Are you thinking of pushing something like this into 2.6 as well?

Definitely. Andrew had a more invasive version back in 2.5.2x iirc, that
might be a good basis if someone were to look into this before me...

> I ask, because 2.6 seems to drive the laptop significantly harder than
> 2.4 anyway --- battery life is lower, the disk light is on more, and the
> machine runs hotter.

Hmm that sounds a bit strange. I just put 2.6 on my powerbook, haven't
really used it enough yet to notice a difference. I'll keep it in mind,
though.

-- 
Jens Axboe

