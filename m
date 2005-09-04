Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVIDUA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVIDUA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVIDUA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:00:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44048 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751089AbVIDUA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:00:58 -0400
Date: Sun, 4 Sep 2005 22:00:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-ID: <20050904200055.GC3741@stusta.de>
References: <20050901035542.1c621af6.akpm@osdl.org> <20050903122126.GM3657@stusta.de> <20050903123410.1320f8ab.akpm@osdl.org> <20050903195423.GP3657@stusta.de> <20050903130632.3124e19b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903130632.3124e19b.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 01:06:32PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > On Sat, Sep 03, 2005 at 12:34:10PM -0700, Andrew Morton wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > Hi Andrew,
> > > > 
> > > > it seems you dropped 
> > > > schedule-obsolete-oss-drivers-for-removal-version-2.patch, but there's 
> > > > zero mentioning of this dropping in the changelog of 2.6.13-mm1.
> > > > 
> > > > Can you explain why you did silently drop it?
> > > 
> > > It spat rejects and when I looked at the putative removal date I just
> > > didn't believe it anyway.  Send a rediffed one if you like, but
> > > October 2005 is unrealistic.
> > 
> > That the date is no longer realistic is clear. What disappoints me is 
> > that you didn't mention in the changelog of 2.6.13-mm1 where I'd have 
> > noticed it.
> 
> Sometimes I can't be bothered getting into email threads over relatively
> unimportant stuff.  Usually it's related to the number of bugs we have.

This is not about email threads.

You send a changelog when you announce a new -mm kernel.
Why didn't you simply mention that you dropped this patch due to rejects 
in the changelog you are sending?

> > It semms I need my own bookkeeping of patches I sent that are in -mm to 
> > notice when they get lost.
> 
> This is called "quilt".
> 
> > The only positive side effect of this is that 
> > I can use this to push you harder to forward some patches of me to Linus 
> > that stay unforwarded in -mm for several months...
> 
> A single release cycle is 2-3 months.

And I'm talking about patches waiting in -mm for more than 5 months.

> I'll probably be dropping some of the patches which unexport symbols, btw. 
> ANy ones which aren't really, really obvious.  We have a process for this.

You accept patches into -mm, and without any new issues with these 
patches you tell me more than five months later "I'll probably be 
dropping some of the patches which unexport symbols, btw."?

If this is how my work is appreciated here I'll better stop wasting part 
of my spare time and unsubscribe from linux-kernel.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

