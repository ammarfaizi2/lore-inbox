Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVLCTfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVLCTfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 14:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVLCTfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 14:35:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2825 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750777AbVLCTfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 14:35:37 -0500
Date: Sat, 3 Dec 2005 20:35:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203193538.GM31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de> <1133620264.2171.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133620264.2171.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 09:31:03AM -0500, Ben Collins wrote:
> On Sat, 2005-12-03 at 14:56 +0100, Adrian Bunk wrote:
> > The current kernel development model is pretty good for people who 
> > always want to use or offer their costumers the maximum amount of the 
> > latest bugs^Wfeatures without having to resort on additional patches for 
> > them.
> > 
> > Problems of the current development model from a user's point of view 
> > are:
> > - many regressions in every new release
> > - kernel updates often require updates for the kernel-related userspace 
> >   (e.g. for udev or the pcmcia tools switch)
> > 
> > One problem following from this is that people continue to use older 
> > kernels with known security holes because the amount of work for kernel 
> > upgrades is too high.
> 
> What you're suggesting sounds just like going back to the old style of
> development where 2.<even>.x is stable, and 2.<odd>.x is development.
> You might as well just suggest that after 2.6.16, we fork to 2.7.0, and
> 2.6.17+ will be stable increments like we always used to do.
> 
> You're just munging the version scheme :)

The 2.6.17+ development model is different from a traditional 2.7 
development model in the sense that 2.6.17+ contains regular relatively 
stable releases.

But yes, what I suggest is partially a step back in a way that it 
doesn't conflict with the current 2.6.17+ development model.

Well, if taking the best from the old style development is improving 
things that isn't something bad.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

