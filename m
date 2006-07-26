Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWGZTBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWGZTBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWGZTBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:01:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:46804 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751757AbWGZTBE (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:01:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n6ZWK/pBaFpNMzX1Poxc/PtiPKjSU/A/G3HzUjNsL+q2yEq4nW0aW0XzLyHkpLIDjyJSLmBF9I/Nvr3r0F/tAUA970pXV1mrCibLbS0DHGic51U6Y0lQUQudbM1YCWo6dKZMV1jNTGTVxgK5L4x+iTrVVx7hkkCDeU0rVxFZ8Fg=
Message-ID: <88ee31b70607261201k24f4bf16s6a3a0baa1d376dcb@mail.gmail.com>
Date: Thu, 27 Jul 2006 04:01:02 +0900
From: "Jerome Pinot" <ngc891@gmail.com>
To: "andrea@cpushare.com" <andrea@cpushare.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Hans Reiser" <reiser@namesys.com>,
       "Nikita Danilov" <nikita@clusterfs.com>,
       "Rene Rebe" <rene@exactcode.de>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
In-Reply-To: <20060726172029.GS32243@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <17604.31639.213450.987415@gargle.gargle.HOWL>
	 <44C65931.6030207@namesys.com> <20060726124557.GB23701@stusta.de>
	 <20060726132957.GH32243@opteron.random>
	 <20060726134326.GD23701@stusta.de>
	 <20060726142854.GM32243@opteron.random>
	 <20060726145019.GF23701@stusta.de>
	 <20060726160604.GO32243@opteron.random>
	 <20060726170236.GD31172@fieldses.org>
	 <20060726172029.GS32243@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, andrea@cpushare.com <andrea@cpushare.com> wrote:
> On Wed, Jul 26, 2006 at 01:02:36PM -0400, J. Bruce Fields wrote:
> > On Wed, Jul 26, 2006 at 06:06:04PM +0200, andrea@cpushare.com wrote:
> > > JFYI: all statistics only take a sample of the larger space, the whole
> > > point of having a statistic is because you can't measure the total.
> > > The smaller the sample compared to the total, the less the stats are
> > > accurate
> >
> > Definitely not true in general.  If I wanted to know the gender ratio at
> > the latest OLS I'd take the results from a sample of a dozen chosen
> > randomly over the results from a sample of hundreds all taken from the
> > men's room.
>
> Well, your example is perhaps the worst one since you wouldn't be
> decreasing the quality of your stats very much by only doing the
> sample in the men's room ;). I guess you meant the woman's room.
>
> > For exactly the same quality of sampling, yes, the larger the better,
> > but the point of diminishing returns comes pretty quickly.  So given
> > limited resources it's probably more important to work on the quality of
> > the sample rather than on its size....
>
> No matter how you see it, the larger the better (in the worst case it
> won't make a difference). Certainly if I could work on the quality,
> that would be more important than adding 1 more user. But I can't work
> on the quality.

Maybe you could try pushing the use of klive by some distros arguing
it's "a way of getting usage statistics in order to improve kernel
quality and hardware support". I mean, not just an extra package but a
service launch at the first boot so anyone can use it.

klive is a nice project, it just needs more _different_ users and
maybe, a support of some distros.

Maybe, you could try add a page in the klive wiki for putting packages
and RPMs of klive for several distros ? What do you think ? It's a
first step to get it merge into distros.

In my case, I got some .tgz that feel lonely...

Maybe be in 2 years, we will know EXACTLY of much people use
EXT4/Reiser5/CoincoinFS/CrashFS...

-- 
Jerome Pinot
http://ngc891.blogdns.net/
