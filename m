Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVAZXfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVAZXfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVAZXUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:20:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18963 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262462AbVAZSGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:06:04 -0500
Date: Wed, 26 Jan 2005 19:06:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, Jean Delvare <khali@linux-fr.org>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050126180601.GB5297@stusta.de>
References: <20050124175449.GK3515@stusta.de> <20050124213442.GC18933@kroah.com> <20050124214751.GA6396@infradead.org> <20050125060256.GB2061@kroah.com> <20050125195918.460f2b10.khali@linux-fr.org> <20050126003927.189640d4@zanzibar.2ka.mipt.ru> <20050125224051.190b5ff9.khali@linux-fr.org> <20050126013556.247b74bc@zanzibar.2ka.mipt.ru> <20050126101434.GA7897@infradead.org> <1106737157.5257.139.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106737157.5257.139.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 01:59:17PM +0300, Evgeniy Polyakov wrote:
> On Wed, 2005-01-26 at 10:14 +0000, Christoph Hellwig wrote:
> > On Wed, Jan 26, 2005 at 01:35:56AM +0300, Evgeniy Polyakov wrote:
> > > I have one rule - if noone answers that it means noone objects,
> > > or it is not interesting for anyone, and thus noone objects.
> > 
> > That's simply not true.  The amount of patches submitted is extremly
> > huge and the reviewers don't have time to look at everythning.
> > 
> > If no one replies it simply means no one has looked at it in enough
> > detail to comment yet.
> 
> That is why I resent it several times.
> Then I asked for inclusion.
> 
> I never send it to lkml just because simple static/non static + module
> name
> discussion in lkml already overflowed into more than 20 messages...

Your opinion on some things are different than the opinions of other 
people on some issues. That's normal.

Then a discussion arises.
That's normal and part of a review of some code.
E.g. the "module name discussion" covered a real problem.

Be it 1 email or be it 100 emails - the main point is simply that all 
code in the kernel should be as good as possible and as near as possible 
to kernel standards.

The Linux kernel is a big project with _many_ people involved.
I've also had people telling me that this or that I sent in a patch was 
nonsense. That's normal (and a criticism of your code is not meant as a 
personal insult) and leads to better code in the kernel.

>         Evgeniy Polyakov

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

