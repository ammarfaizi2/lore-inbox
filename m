Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263928AbTCUTwo>; Fri, 21 Mar 2003 14:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263925AbTCUTvk>; Fri, 21 Mar 2003 14:51:40 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53727 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263923AbTCUTvU>; Fri, 21 Mar 2003 14:51:20 -0500
Date: Fri, 21 Mar 2003 21:02:15 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.65-mjb1: lkcd: EXTRA_TARGETS is obsolete
Message-ID: <20030321200215.GN6940@fs.tum.de>
References: <8230000.1047975763@[10.10.2.4]> <20030319153304.GC23258@fs.tum.de> <20030319153707.A24084@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319153707.A24084@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 03:37:07PM +0000, Christoph Hellwig wrote:
> On Wed, Mar 19, 2003 at 04:33:04PM +0100, Adrian Bunk wrote:
> > On Tue, Mar 18, 2003 at 12:22:43AM -0800, Martin J. Bligh wrote:
> > >...
> > > lkcd						LKCD team
> > > 	Linux kernel crash dump support
> > >...
> > 
> > EXTRA_TARGETS is obsolete in 2.5.
> > 
> > The following should do the same:
> 
> No, kerntypes.o should not be linked into the kernel image.

Ups, sorry, my bad.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

