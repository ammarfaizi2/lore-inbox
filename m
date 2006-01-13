Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422966AbWAMVFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422966AbWAMVFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422967AbWAMVFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:05:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15376 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422966AbWAMVFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:05:18 -0500
Date: Fri, 13 Jan 2006 22:05:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, adobriyan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
Message-ID: <20060113210518.GR29663@stusta.de>
References: <20060107052221.61d0b600.akpm@osdl.org> <20060107210646.GA26124@mipter.zuzino.mipt.ru> <20060107154842.5832af75.akpm@osdl.org> <20060110182422.d26c5d8b.pj@sgi.com> <20060113141154.GL29663@stusta.de> <20060113101054.d62acb0d.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113101054.d62acb0d.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 10:10:54AM -0800, Paul Jackson wrote:
> Adrian wrote:
> > This is the amout of testing I can afford.
> 
> It sounds to me like you are saying that a minute of your time is
> more valuable than a minute of each of several other peoples time.
> 
> The only two people I gladly accept that argument from are Linus
> and Andrew.
> 
> For the rest of us, it is important to minimize the total workload
> of all us combined, not to optimize our individual output.
> 
> What you don't test, several others of us get to test.  Only its often
> more work, for -each- of us, as we each have to figure out which of
> 1000 patches caused the breakage.

I'm working against -mm, and there it's quite common that the kernel 
doesn't build on the majority of architectures due to one or two dozen 
bugs other people introduced.

I didn't know people consider the quality of my patches so under-average 
that they want to require me to fix other people's compile errors first 
and test the compilation on all 24 architectures before I'm allowed to 
submit a patch that touches some architecture-independend code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

