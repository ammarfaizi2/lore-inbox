Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265187AbUE0U26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265187AbUE0U26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265197AbUE0U26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:28:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20690 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265187AbUE0U24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:28:56 -0400
Date: Thu, 27 May 2004 22:28:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mark Beyer - Contractor <mbeyer@unminc.com>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: future of UMSDOS?
Message-ID: <20040527202837.GV16099@fs.tum.de>
References: <20040519184321.GB24287@fs.tum.de> <20040524145150.GQ1912@lug-owl.de> <40B22E8D.6000901@unminc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B22E8D.6000901@unminc.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 10:19:09AM -0700, Mark Beyer - Contractor wrote:
> Jan-Benedict Glaw wrote:
> 
> >On Wed, 2004-05-19 20:43:21 +0200, Adrian Bunk <bunk@fs.tum.de>
> >wrote in message <20040519184321.GB24287@fs.tum.de>:
> > 
> >
> >>Looking at the state of the UMSDOS code in 2.6 I'm currently wondering 
> >>about it's future.
> >>
> >>Are there still potential users and people willing to work on getting it
> >>working, or should it be removed from kernel 2.6?
> >>   
> >>
> >
> >In my early Linux days, UMSDOS was quite a neat thing to have for
> >showing Linux to friends by placing a .zip'ed Linux installation on
> >their MS-DOS machines.
> >
> >So for historic reasons, I think it would be nice to have UMSDOS around.
> > 
> >
> There are still embedded systems that boot from a DOS file system. Yes, 
> there are better methods but for backward compatibility I wouldn't like 
> to see it removed.

It's broken in 2.6.

Does anyone need it enough to fix it?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

