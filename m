Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbSJYNEq>; Fri, 25 Oct 2002 09:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbSJYNEq>; Fri, 25 Oct 2002 09:04:46 -0400
Received: from dsl-62-3-75-185.zen.co.uk ([62.3.75.185]:6784 "EHLO
	giantx.co.uk") by vger.kernel.org with ESMTP id <S261392AbSJYNEp>;
	Fri, 25 Oct 2002 09:04:45 -0400
Date: Fri, 25 Oct 2002 14:10:50 +0100
From: Nyk Tarr <nyk@giantx.co.uk>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
Message-ID: <20021025131050.GA593@giantx.co.uk>
References: <20021025103631.GA588@giantx.co.uk> <20021025103938.GN4153@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025103938.GN4153@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 12:39:38PM +0200, Jens Axboe wrote:
> On Fri, Oct 25 2002, Nyk Tarr wrote:
> > 
> > Hi,
> > 
> > I got this nice error after doing an 'eject /cdrom'
> 
> [snip]
> 
> 2.5.44 and thus 2.5.44-acX has seriously broken REQ_BLOCK_PC, so it's no
> wonder that it breaks hard. Alan, I can sync the sgio patches for you if
> you want.
> 
> Nyk, if you could try
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-15.bz2
> 
> that would be great, thanks.

This also seems to hang and die. No panic in the logs this time, but
some stuff scrolling off the screen on console. Sadly I've nothing to
use as serial console at the mo' but I'll try some other options...

-- 
/__
\_|\/
   /\
