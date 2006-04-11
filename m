Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWDKQOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWDKQOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWDKQOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:14:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29706 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750858AbWDKQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:13:59 -0400
Date: Tue, 11 Apr 2006 18:13:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ramakanth Gunuganti <rgunugan@yahoo.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
Message-ID: <20060411161358.GI3190@stusta.de>
References: <9CF84823-E0BA-404C-9C5A-CAFF0D4C92DF@mac.com> <20060411154944.65714.qmail@web54308.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411154944.65714.qmail@web54308.mail.yahoo.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 08:49:44AM -0700, Ramakanth Gunuganti wrote:
> 
> Thanks for the replies, talking to a lawyer seems to
> be too stringent a requirement to even evaluate Linux.
> Who would be the ultimate authority to give definitive
> answers to these questions? 

There is none:

The kernel has _many_ people holding a copyright on part of the kernel, 
and there's no ultimate authority except for the COPYING file shipped 
with the kernel sources.

The GPL is just a licence, and if you distribute your product to N 
countries, this means you can potentially be sued in N countries based 
on N different copyright laws.

There are things that are clear. E.g. if you'd have read the COPYING 
file shipped with the kernel sources, you could have answered at least 
one of your questions yourself.

But the exact borders of what is a "derived work" work and what is not 
are not well-defined and therefore unknown unless there have been court 
cases in all N countries you are distributing your product to.

Many things have never been challenged in court, and might never be, but 
remember that e.g. Harald Welte recently has much success with enforcing 
the GPL in cases of obvious violations at for products shipped in 
Germany at German courts.

> Since it's the Linux kernel that's under GPLv2, any
> work done here should be released under GPLv2. That
> part seems to be clear, however any product would
> include other things that could be proprietary. If
> Linux kernel is made part of this proprietary package,
> how does the distribution work. Can we just claim that
> part of the package is under GPL and only release the
> source code for the kernel portions. 

I am not a lawyer, but the distribution alone shouldn't be a problem - 
that is similar to what most Linux distributions are doing.

> -Ram

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

