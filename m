Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUAYVss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUAYVss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:48:48 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60911 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265255AbUAYVsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:48:15 -0500
Date: Sun, 25 Jan 2004 22:48:00 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, cova@ferrara.linux.it, eric@cisu.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125214800.GO513@fs.tum.de>
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it> <20040125173048.GL513@fs.tum.de> <20040125174837.GB16962@colin2.muc.de> <20040125131153.16bb662b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125131153.16bb662b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 01:11:53PM -0800, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
>...
> > > Th patch below replaces use-funit-at-a-time.patch and uses 
> > > scripts/gcc-version.sh from add-config-for-mregparm-3-ng* to use 
> > > -funit-at-a-time only with gcc >= 3.4 .
> > 
> > I disagree with that change.
> 
> Well there doesn't seem much doubt that -funit-at-a-time causes Fabio's
> kernel to fail.  Do we know exactly which compiler he is using?

  gcc (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

