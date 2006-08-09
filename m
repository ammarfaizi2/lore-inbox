Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWHIWAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWHIWAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWHIWAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:00:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11538 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751403AbWHIWAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:00:52 -0400
Date: Thu, 10 Aug 2006 00:00:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Pavel Machek <pavel@suse.cz>, Josh Boyer <jwboyer@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-ID: <20060809220048.GE3691@stusta.de>
References: <200608091749_MC3-1-C796-5E8D@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091749_MC3-1-C796-5E8D@compuserve.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 05:45:53PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <20060808195509.GR3691@stusta.de>
> 
> On Tue, 8 Aug 2006 21:55:10 +0200, Adrian Bunk wrote:
> 
> > > > > I believe I had 'fix pdflush after suspend' queued in Greg's tree. Is
> > > > > it still queued or should I resend?
> > > > 
> > > > Is this "pdflush: handle resume wakeups"?
> > > 
> > > Yes. Do you have it somewhere or should I dig it up?
> > 
> > I've applied it.
> 
> Umm, is there some place we can check to see what you've applied?

git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

> I sent you "tty: serialize flush_to_ldisc" and I've got a few more
> but I don't want to duplicate what you already have.

Sorry that I hadn't answered your email.

That patch is in 2.6.17.8, and I will look at it since I'm currently 
going through all 2.6.17.7 and 2.6.17.8 patches looking for patches I 
should apply.

> Chuck

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

