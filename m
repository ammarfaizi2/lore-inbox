Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUKRVfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUKRVfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbUKRVeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:34:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14096 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262982AbUKRVch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:32:37 -0500
Date: Thu, 18 Nov 2004 22:32:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nicolas Pitre <nico@cam.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
Message-ID: <20041118213232.GG4943@stusta.de>
References: <20041118021538.5764d58c.akpm@osdl.org> <20041118154110.GE4943@stusta.de> <1100793112.8191.7315.camel@hades.cambridge.redhat.com> <Pine.LNX.4.61.0411181132440.12260@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411181132440.12260@xanadu.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 11:34:56AM -0500, Nicolas Pitre wrote:
> On Thu, 18 Nov 2004, David Woodhouse wrote:
> 
> > On Thu, 2004-11-18 at 16:41 +0100, Adrian Bunk wrote:
> > > Let's put the dependencies from the #error into the Kconfig file:
> > 
> > Looks sane to me. Nico?
> 
> And why is the current arrangement actually a problem?

If you are able to select an option, it should also compile (and work).

At least on i386, this is usually true for every single option.

> Nicolas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

