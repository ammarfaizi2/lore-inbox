Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWG0N6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWG0N6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWG0N6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:58:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52237 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750709AbWG0N6Y (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Thu, 27 Jul 2006 09:58:24 -0400
Date: Thu, 27 Jul 2006 15:58:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: andrea@cpushare.com
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Hans Reiser <reiser@namesys.com>,
       Nikita Danilov <nikita@clusterfs.com>, Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060727135823.GA19718@stusta.de>
References: <20060726145019.GF23701@stusta.de> <20060726160604.GO32243@opteron.random> <20060726170236.GD31172@fieldses.org> <20060726172029.GS32243@opteron.random> <20060726205022.GI23701@stusta.de> <20060726211741.GU32243@opteron.random> <20060727065603.GJ23701@stusta.de> <20060727115229.GD32243@opteron.random> <20060727121811.GN23701@stusta.de> <20060727131032.GE32243@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727131032.GE32243@opteron.random>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 03:10:32PM +0200, andrea@cpushare.com wrote:
> On Thu, Jul 27, 2006 at 02:18:11PM +0200, Adrian Bunk wrote:
> > They could only be considered positive if someone expected less than
> > 35 reiser4 users worldwide.
> 
> The only thing we know for sure is that 35 out of 500 KLive user are
> running reiser4, worldwide we have no clue.
> 
> > If you are intelligent (which I assume), you should have learned by this 
> > how to not present your data.
> 
> I think readers are intelligent enough too to interpret the KLive data
> properly for themself, without you having to prevent their eyes to see
> the raw KLive data.
> 
> When you tell me how I should not present my data, you're asking me to
> censor part or all of the very output of the KLive project. I'd rather
> wipe out KLive completely, than to censor it. The way I presented it
> was absolutely not biased, if you can make more transparent and
> unbiased sql queries than the ones I did, please post them and I'll be
> glad to run them.

What about the following statement:

"Gentoo is 47 times as popular as SuSE among KLive users (a service
 offered by a SuSE employee gathering data from many users worldwide)."

Is any part of this information wrong?

Is it therefore OK to put this information to /. ?

Surely not, but you might get the point.

> > [..] (I'm a happy ext2 user).
> 
> Oh my, I hope you're only choosing the fs for your own workstation.
> 
> Even though I don't pretend to fully understand someone who claims to
> be happy with ext2,

It's stable, and if the machine crashes the fsck is really great (Linus' 
tree contains at least a dozen patches that had their temporary home in 
my lost+found). (I don't care that the fsck takes 20 minutes on a 250 GB 
partition.)

Other people have other preferences and do therefore prefer other 
filesystems.

> I've no idea why you hate so much the stuff
> running at cpushare.com domain. But if it helps KLive is actually one
> of the non commercial projects I'm hosting there, and the only reason
> I keep it there, is to be sure not to find it filled by ads.

This isn't against cpushare.com, it's against publishing things people 
will easily misinterpret.

The Linux Counter [1] is another non commercial project gathering 
similar data (including live data about running kernels and uptimes) 
from far more users, and I've already given an example in this thread 
how someone could have misinterpreted the data offered there. And if 
someone would argue with data from there in a similar easy to 
misinterpret way on this list, I'd react similarly.

And another example would be that you could say "one third of all Linux 
Counter machines are still running kernels < 2.6". This would be based 
on current information submitted automatically from nearly 5000 
machines. But people would read this is "one third of all machines are 
still running kernels < 2.6". But the data doesn't have the quality for 
this generalization. And this is exactly the problem.

> Now let's try to get some work done instead of only sending emails ;)

Agreed.  ;-)

cu
Adrian

[1] http://counter.li.org/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

