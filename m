Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUEMOQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUEMOQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUEMOQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:16:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6902 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264213AbUEMOP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:15:56 -0400
Date: Thu, 13 May 2004 16:15:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040513141548.GG22202@fs.tum.de>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513035134.2e9013ea.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 03:51:34AM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +hugetlb_shm_group-sysctl-gid-0-fix.patch
> > > 
> > >  Don't make gid 0 special for hugetlb shm.
> > 
> > As Oracle has agreed on fixing their DB to use hugetlbfs could we
> > please stop doctoring around on this broken patch and revert it.
> 
> Once I'm convinced that kernel.org kernels will be able to run applications
> which vendor kernels will run, sure.
>...

Vendor 2.4 kernels support the "old" EVMS application.

Despite this fact, the code was rejected by Linus during 2.5.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

