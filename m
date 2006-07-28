Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWG1KBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWG1KBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWG1KBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:01:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6663 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932606AbWG1KBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:01:44 -0400
Date: Fri, 28 Jul 2006 12:01:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Luigi Genoni <genoni@sns.it>, andrea@cpushare.com,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Nikita Danilov <nikita@clusterfs.com>, Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: the ' 'official' point of view' expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060728100143.GB23554@stusta.de>
References: <20060726145019.GF23701@stusta.de> <20060726160604.GO32243@opteron.random> <20060726170236.GD31172@fieldses.org> <20060726172029.GS32243@opteron.random> <20060726205022.GI23701@stusta.de> <20060726211741.GU32243@opteron.random> <20060727065603.GJ23701@stusta.de> <4284.192.167.206.189.1153989192.squirrel@darkstar.linuxpratico.net> <20060727100446.GK23701@stusta.de> <44C97593.6030808@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C97593.6030808@namesys.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 08:25:23PM -0600, Hans Reiser wrote:
> Adrian Bunk wrote:
> 
> >
> >
> >But you can not tell based on klive data whether the ratio of 
> >reiser4:ext3 users in the world is more like 1:5, 1:500 or 1:50000.
> >
> ><--  snip  -->
> >
> >I can't prove that the 1:5 ratio is wrong, but the point is that 
> >claiming a 1:5 ratio was true based on the klive data is not better than 
> >claiming it based on no data. 
> >
> Yes, but I have been surprised that linux conference attendees all know
> about reiser4, so I think it is consistent with the notion that reiser4
> usage may well be much much higher than one would expect of a filesystem
> that is not in the main tree,
>...

There were already several long flamewars^Wdiscussions about reiser4 on 
linux-kernel.

There has already been some amount of press articles covering reiser4.

But how much usage is the result of this?

There seem to be the the following possibilities how users get reiser4 
into their kernel today:
1. -mm kernel
2. non -mm kernel
   a) patch downloaded from namesys.com
   b) through their distribution
      - in a kernel image
      - as patch
   c) patch forwarded through other channels

2b) seems to be the only number that is easily measurable.
Do you have some download statistics for namesys.com?

Multiplying the downloads for the 2.6.16 patches with 10 seems to be the 
best estimate for the order of magnitude of current reiser4 users that 
seems to be available.

> Hans

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

