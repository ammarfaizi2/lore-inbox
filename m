Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWGZQxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWGZQxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWGZQxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:53:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47620 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030219AbWGZQxG (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 26 Jul 2006 12:53:06 -0400
Date: Wed, 26 Jul 2006 18:53:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: andrea@cpushare.com
Cc: Hans Reiser <reiser@namesys.com>, Nikita Danilov <nikita@clusterfs.com>,
       Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060726165305.GH23701@stusta.de>
References: <200607230920.04129.rene@exactcode.de> <17604.31639.213450.987415@gargle.gargle.HOWL> <20060725123558.GA32243@opteron.random> <44C65931.6030207@namesys.com> <20060726124557.GB23701@stusta.de> <20060726132957.GH32243@opteron.random> <20060726134326.GD23701@stusta.de> <20060726142854.GM32243@opteron.random> <20060726145019.GF23701@stusta.de> <20060726160604.GO32243@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726160604.GO32243@opteron.random>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 06:06:04PM +0200, andrea@cpushare.com wrote:
> On Wed, Jul 26, 2006 at 04:50:19PM +0200, Adrian Bunk wrote:
> > Someone said in this thread 'is used by (tens of) thousands of computers 
> > in governmental laboratories the US "national security" depends upon.'
> 
> There can be people using reiser4 behind the firewall too, what's the
> point? IIRC US .gov even sponsored part of reiser4 development, how do
> you know they're not testing it too?

I don't know.

The klive data might be inaccurate in any direction.

In this case I'd suspect an inaccuraty in one specific direction.

> You don't believe KLive has any relation to reality, but you have no
> way to proof your claim. JFYI: all statistics only take a sample of
> the larger space, the whole point of having a statistic is because you
> can't measure the total. The smaller the sample compared to the total,
> the less the stats are accurate, but they still have some statistical
> significance. And one can always hope that KLive will grow larger.

Size isn't everything.
The problem is getting an accurate sample of data.


Let me try to make the problem clearer by making an example:

Consider you want to know the ratio between housewifes and women with a 
job for women aged between 30 and 40.

Consider you get your data by asking women in shopping malls between
10 and 11 o'clock in the morning on workdays.

Do you understand why the result might be quite different from the 
actual ratio?

Do you understand why asking a million women in shopping malls between
10 and 11 o'clock in the morning on workdays wouldn't make the data
better?


And do you know the Linux Counter at [1]?

I remember several years ago Debian had some default setting in 
some package to send reports there.

smail was at that times the default Debian MTA, and therefore also the 
most popular MTA at the Linux counter...

> Last but not the least defining gentoo users as freaks isn't very nice
> from your part. For all new startups they're the ideal userbase to
> have, and they do a great deal of good work by testing all new stuff

Please read carefully what I said.

I did NOT say:
"All Gentoo users are freaks."

It was more (implicitely) in the direction:
"Many freaks use Gentoo."

The latter is IMHO not that far from reality.

And "freak" wasn't meant negative.

> and they help speeding up innovation. Infact I think having a sample
> of what those brave users run is more important than the rest, the
> rest usually follows the ones living on the edge eventually.

The majority of user will use the filesystem their distribution offers 
as default, no matter what people living on the edge today will use...

cu
Adrian

[1] http://counter.li.org/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

