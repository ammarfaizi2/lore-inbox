Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUGYNbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUGYNbI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 09:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUGYNbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 09:31:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56564 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263962AbUGYNbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 09:31:03 -0400
Date: Sun, 25 Jul 2004 15:30:57 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Timothy Miller <miller@techsource.com>
Cc: Andrew Morton <akpm@osdl.org>, corbet@lwn.net,
       linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040725133057.GY19329@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de> <20040722160112.177fc07f.akpm@osdl.org> <41017BBF.6020106@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41017BBF.6020106@techsource.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 04:57:35PM -0400, Timothy Miller wrote:
> 
> Andrew Morton wrote:
> >Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> >>my personal opinon is that this new development model isn't a good 
> >>idea from the point of view of users:
> >>
> >>There's much worth in having a very stable kernel. Many people use for 
> >>different reasons self-compiled ftp.kernel.org kernels. 
> >
> >
> >Well.  We'll see.  2.6 is becoming stabler, despite the fact that we're
> >adding features.
> >
> >I wouldn't be averse to releasing a 2.6.20.1 which is purely stability
> >fixes against 2.6.20 if there is demand for it.  Anyone who really cares
> >about stability of kernel.org kernels won't be deploying 2.6.20 within a
> >few weeks of its release anyway, so by the time they doodle over to
> >kernel.org they'll find 2.6.20.2 or whatever.
> 
> 
> So instead of even minor numbers indicating stability, you have pushed 
> two levels down so that higher sub-revision (minorminorminor?) numbers 
> indicate increased levels of stability?
> 
> Kinda makes sense.
> 
> Does that mean that 2.6.21 and 2.6.20.1 are two separate forks of 
> 2.6.20, one for development, and the other for stability?
> 
> How is this fundamentally different from how it was done before with 
> odd/even minor numbers?
>...

Kernel 2.4 continues to be actively supported for several years after 
the release of kernel 2.6 .

How long do you assume will kernel 2.6.20 be supported after the release 
of kernel 2.6.21?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

