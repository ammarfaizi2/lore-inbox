Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317809AbSGKJyS>; Thu, 11 Jul 2002 05:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317807AbSGKJyR>; Thu, 11 Jul 2002 05:54:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19670 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317806AbSGKJyO>;
	Thu, 11 Jul 2002 05:54:14 -0400
Date: Thu, 11 Jul 2002 11:56:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Message-ID: <20020711095653.GD808@suse.de>
References: <20020709200711.GA13401@win.tue.nl> <200207110954.LAA08806@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207110954.LAA08806@cave.bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11 2002, Rogier Wolff wrote:
> Andries Brouwer wrote:
> > On Tue, Jul 09, 2002 at 12:22:49PM +0200, Jens Axboe wrote:
> > 
> > > I've forward ported the 2.4 IDE core to 2.5.25.
> > 
> > Very good!
> 
> Ehmm. We have had "old IDE support" in the kernel for "ages".  We have
> two aic7xxx driver, two rtl8139 drivers, two, or more ncr53c8xx drivers. 
> 
> So why in the case of IDE has the "new IDE" driver not been forked and
> implemented under a new "name" such that those working on other stuff
> can chose to use the "old reliable" driver while others daring to test
> the new advanced rewrite can do so?

That's a really good question, in retrospect this is what should have
happened IMO.

-- 
Jens Axboe

