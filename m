Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWGZUuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWGZUuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWGZUuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:50:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63238 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750896AbWGZUuX (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 26 Jul 2006 16:50:23 -0400
Date: Wed, 26 Jul 2006 22:50:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: andrea@cpushare.com
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Hans Reiser <reiser@namesys.com>,
       Nikita Danilov <nikita@clusterfs.com>, Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060726205022.GI23701@stusta.de>
References: <20060725123558.GA32243@opteron.random> <44C65931.6030207@namesys.com> <20060726124557.GB23701@stusta.de> <20060726132957.GH32243@opteron.random> <20060726134326.GD23701@stusta.de> <20060726142854.GM32243@opteron.random> <20060726145019.GF23701@stusta.de> <20060726160604.GO32243@opteron.random> <20060726170236.GD31172@fieldses.org> <20060726172029.GS32243@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726172029.GS32243@opteron.random>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 07:20:29PM +0200, andrea@cpushare.com wrote:
> On Wed, Jul 26, 2006 at 01:02:36PM -0400, J. Bruce Fields wrote:
>...
> > For exactly the same quality of sampling, yes, the larger the better,
> > but the point of diminishing returns comes pretty quickly.  So given
> > limited resources it's probably more important to work on the quality of
> > the sample rather than on its size....
> 
> No matter how you see it, the larger the better (in the worst case it
> won't make a difference). Certainly if I could work on the quality,
> that would be more important than adding 1 more user. But I can't work
> on the quality.

But depending on the nature of the error, the worst case might be the 
common case (as I've already explained in another email).

If you can't ensure the quality of your data, please don't use this data 
to wrongly draw any conclusions from them [1].

cu
Adrian

[1] the conclusion itself might or might not be true
    e.g. there _could_ be an 1:5 ratio between reiser4 and ext3 users
    but your data is not in any way able to support or reject this 
    statement

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

