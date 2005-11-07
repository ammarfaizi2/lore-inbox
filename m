Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVKGVXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVKGVXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVKGVXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:23:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20740 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965064AbVKGVXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:23:11 -0500
Date: Mon, 7 Nov 2005 22:23:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] GIT trivial tree
Message-ID: <20051107212308.GG3847@stusta.de>
References: <20051107165126.GE3847@stusta.de> <Pine.LNX.4.64.0511070856590.3193@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511070856590.3193@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 09:02:29AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 7 Nov 2005, Adrian Bunk wrote:
> > 
> >   http://www.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git
> 
> Please don't try to make me update over http. Either point to master 
> (which is not accessible by all), or point to git://git.kernel.org/. Or do 
> both..
> 
> And if you do the latter (or, in fact, rsync or http for others), please 
> make sure that you delay your "please pull" sufficiently that the contents 
> have actually mirrored out, because otherwise, if the mail comes in while 
> I'm in merging mode (like right now), and I try to pull, I may not have 
> anything to pull at all just because it hasn't mirrored out yet.

OK, I'll try to get this right the next time.

> A side comment (this was true with BK too): I prefer not to see 
> unnecessary two-way merges, since that just makes the history much 
> messier. So
> 
> > Adrian Bunk:
> >   Merge with http://www.kernel.org/.../torvalds/linux-2.6.git
> 
> is _probably_ unnecessary, since by definition the "trivial" tree should 
> basically never have anything that could cause clashes (so if I just pull 
> on it, it should merge fine even without you doing the merge the other 
> way).
>...

Petr (who had already given me a "git for dummies" course yesterday) has 
explained to me why this happened, and it shouldn't happen again.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

