Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVACR52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVACR52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVACR5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:57:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62737 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261615AbVACRyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:54:40 -0500
Date: Mon, 3 Jan 2005 18:54:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Domen Puncer <domen@coderock.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] maintainers: remove moderated arm list
Message-ID: <20050103175438.GL2980@stusta.de>
References: <20041225170825.GA31577@nd47.coderock.org> <20041225172155.A26504@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225172155.A26504@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 05:21:55PM +0000, Russell King wrote:
> On Sat, Dec 25, 2004 at 06:08:25PM +0100, Domen Puncer wrote:
> > If you are subscribed to it, you already know the address. If you are not,
> > you probably don't want bounces.
> 
> I don't particularly agree with this policy of removing such documentation,
> especially as I have a good reason to implement such policy on my mailing
> lists.
> 
> If we must, I guess it's fine, but I expect *you* to provide the support
> to people to people who don't know where to go for it if *you* remove this.

I'm sometimes doing patches that cover many files, and I want to Cc the 
patches to the developers in question.

If after sending 10 patches I get 5 "this is a subscribers-only list" 
mails, I'm not going to subscribe to 5 lists, forward the patches to 
them and unsubscribe again after this (and repeat this if there's some 
discussion regarding one of these patches).

In my experience, the best solution is a list policy that allows 
subscribers to post and requires moderator approval for non-members.
This policy that is already used by several lists listed in MAINTAINERS 
is IMHO a good compromise between avoiding spam and allowing 
non-subscribers to post to the list.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

