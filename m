Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266779AbUGUXwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266779AbUGUXwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 19:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266780AbUGUXwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 19:52:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42965 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266779AbUGUXwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 19:52:33 -0400
Date: Thu, 22 Jul 2004 01:52:28 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040721235228.GZ14733@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721231123.13423.qmail@lwn.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 05:11:23PM -0600, Jonathan Corbet wrote:

> > Ok, is there anywhere else that isn't subscriber-only that has the scoop?
> 
> For those who weren't here, the basic scoop is this:
> 
> - 2.6 is doing great, despite the fact that (by Andrew's reckoning) some
>   10mb/month of patches are going into it.
> 
> - Linus is majorly pleased with how the partnership with Andrew has been
>   working, and few people feel that he shouldn't be.  He is a little
>   concerned about breaking a highly effective process when 2.7 forks.
> 
> - There is not a whole lot of pressure to create a 2.7 now, but a lot of
>   interest in getting patches into the mainstream quickly.
> 
> The end result is that there may not be a 2.7 for a while.  Instead,
> significant patches will continue to go into 2.6, after a vetting period
> in -mm.  Andrew stated his willingness to consider, for example,
> four-level page tables, MODULE_PARM removal, API changes, and more.  2.7
> will only be created when it becomes clear that there are sufficient
> patches which are truly disruptive enough to require it.  When 2.7 *is*
> created, it could be highly experimental, and may turn out to be a
> throwaway tree.
> 
> Andrew's vision, as expressed at the summit, is that the mainline kernel
> will be the fastest and most feature-rich kernel around, but not,
> necessarily, the most stable.  Final stabilization is to be done by
> distributors (as happens now, really), but the distributors are expected
> to merge their patches quickly.
> 
> Anybody disagree with that summary?

Thanksfor this mail, this is exactly the information that was missing.

Discussing the contents:
Changes that remove functionally like Greg's patch are hopefully 
still 2.7 stuff - 2.6 is a stable kernel series and smooth upgrades 
inside a stable kernel series are a must for many users.

> jon
 
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

