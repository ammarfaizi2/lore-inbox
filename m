Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTDYOLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTDYOLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:11:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55434 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263202AbTDYOLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:11:19 -0400
Date: Fri, 25 Apr 2003 16:23:12 +0200
From: Jens Axboe <axboe@kernel.org>
To: David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@hpl.hp.com>, David Hinds <dhinds@sonic.net>
Subject: Re: Update to orinoco driver (2.4)
Message-ID: <20030425142312.GP1012@suse.de>
References: <20030423054636.GG25455@zax> <20030423060520.GI25455@zax> <1051272644.15776.2.camel@gaston> <20030425125359.GB10133@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030425125359.GB10133@zax>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25 2003, David Gibson wrote:
> On Fri, Apr 25, 2003 at 02:10:45PM +0200, Benjamin Herrenschmidt wrote:
> > On Wed, 2003-04-23 at 08:05, David Gibson wrote:
> > > On Wed, Apr 23, 2003 at 03:46:36PM +1000, David Gibson wrote:
> > > > Hi Marcelo,
> > > > 
> > > > The patch below updates the orinoco driver in 2.4 to 0.13d, the patch
> > > > is against 2.4.21-rc1.  You may want to postpone this update till
> > > > after 2.4.21, but I'd consider it, since it fixes a fair slew of bugs.
> > > 
> > > Duh, sorry.  And now with the actual patch:
> > 
> > Shouldn't it also patch Config.in & Makefile to add the orinoco_tmd.c ?
> 
> Crap, indeed it ought.  It's been so long since I added a file, I
> forgot that bit.  I'll fix that up on Monday.
> 
> > I'm adding this new driver to my pmac bk tree btw.
> 
> Ok.

It works perfectly for me, fwiw.

-- 
Jens Axboe

