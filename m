Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTIGTEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTIGTEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:04:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59637 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261192AbTIGTEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:04:51 -0400
Date: Sun, 7 Sep 2003 21:04:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5 and below: Wine and XMMS problems
Message-ID: <20030907190443.GH14436@fs.tum.de>
References: <20030902231812.03fae13f.akpm@osdl.org> <20030907100843.GM14436@fs.tum.de> <200309072218.28116.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309072218.28116.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 10:18:27PM +1000, Con Kolivas wrote:
> On Sun, 7 Sep 2003 20:08, Adrian Bunk wrote:
> > On Tue, Sep 02, 2003 at 11:18:12PM -0700, Andrew Morton wrote:
> > >...
> > > . Dropped out Con's CPU scheduler work, added Nick's.  This is to help us
> > >   in evaluating the stability, efficacy and relative performance of
> > > Nick's work.
> > >
> > >   We're looking for feedback on the subjective behaviour and on the usual
> > >   server benchmarks please.
> > >...
> >
> > Short story:
> >
> > I'm still using 2.5.72, all of the 2.6.0-test?{,-mm?} kernels have
> > problems
> 
> What's your X and xmms nice values? Many X servers are reniced to -10 and some 

They have both nice value 0.

> shells spawn new apps at nice 5. After that the most common thing I find in 
> reports are upgrades to newer kernels losing hard disk dma at some stage (due 
> to config changes/movements) and it not being noticed.

DMA is wrking without problems.

> Con

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

