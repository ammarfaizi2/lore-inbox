Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264228AbUEMOKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUEMOKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUEMOKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:10:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12534 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264228AbUEMOJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:09:47 -0400
Date: Thu, 13 May 2004 16:09:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040513140939.GF22202@fs.tum.de>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121206.A8620@infradead.org> <20040513042540.073478ea.akpm@osdl.org> <20040513131842.GC22202@fs.tum.de> <1084455572.2583.395.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084455572.2583.395.camel@watt.suse.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 09:39:32AM -0400, Chris Mason wrote:
> On Thu, 2004-05-13 at 09:18, Adrian Bunk wrote:
> > On Thu, May 13, 2004 at 04:25:40AM -0700, Andrew Morton wrote:
> > >...
> > > Wim explained that any application changes now won't be widely deployed for
> > > another year.  During that period the ability to run existing Oracle setups
> > > requires that hugepage allocation be available to unprivileged
> > > applications.
> > >...
> > > It means that if people install a kernel.org machine on their database
> > > server, the database *just won't work*.  This is not good for those users,
> > > for the kernel developers or for Linux's reputation in general.
> > >...
> > 
> > That sounds silly when talking about Oracle.
> > 
> > Oracle says:
> >   Which Kernels are supported?
> > 
> >   Oracle does not support modified or recompiled kernels. Recompiled 
> >   kernels are not supported with or without source modifications.
> > 
> > 
> > I doubt there are many "existing Oracle setups" that will risk to lose 
> > all Oracle support by installing a different kernel.
> > 
> No, I doubt so as well.  Then again, why force them into a vendor
> kernel?  At the very least, it would be nice to be able to benchmark
> vanilla against the vendors.
>...

I think I recall times when code contributions to the kernel were only 
judged by their quality and not by the needs of some non-free apps or 
what vendors did.

Either my memory is wrong, or these times are gone now...

> -chris

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

