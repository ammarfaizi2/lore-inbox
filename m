Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266755AbUGUWCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266755AbUGUWCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUGUWCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:02:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42717 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266755AbUGUWCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:02:48 -0400
Date: Thu, 22 Jul 2004 00:02:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg KH <greg@kroah.com>
Cc: Jesse Stockall <stockall@magma.ca>, Oliver Neukum <oliver@neukum.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040721220237.GX14733@fs.tum.de>
References: <20040721141524.GA12564@kroah.com> <200407211626.55670.oliver@neukum.org> <20040721145208.GA13522@kroah.com> <1090444782.8033.4.camel@homer.blizzard.org> <20040721212745.GC18110@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721212745.GC18110@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 05:27:52PM -0400, Greg KH wrote:
> On Wed, Jul 21, 2004 at 05:19:42PM -0400, Jesse Stockall wrote:
> > On Wed, 2004-07-21 at 10:52, Greg KH wrote:
> > > 
> > > And as Lars points out, the code is unmaintained, unused, and buggy.
> > > All good reasons to rip out it out at any moment in time.
> > 
> > Unused? Since when does every Linux user use a vendor supplied kernel? I
> > have no use for devfs, never used it in the past, and I'm a happy udev
> > user now, but that doesn't change the fact that there are many devfs
> > users out there.
> > 
> > What does this gain us right now?
> 
> It fixes an obviously broken chunk of code that is not maintained by
> _anyone_.  And it will clean up all device drivers a _lot_ to have this
> gone, which will benifit everyone in the long run.

I wouldn't disagree with this statement. I'd be very surprised if 2.7.2 
would still contain devfs.

> As for "right now"?  Why not?  I'm just embracing the new development
> model of the kernel :)

Could anyone please explain this mysterious "new development model of  
the kernel"?

Is this some personal fight from you against Linus or someone else you 
are trying to bring to linux-kernel, or WTF has happened???

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

