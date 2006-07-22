Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWGVASV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWGVASV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 20:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWGVASV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 20:18:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29448 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751086AbWGVASU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 20:18:20 -0400
Date: Sat, 22 Jul 2006 02:18:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Hans Reiser <reiser@namesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Diego Calleja <diegocg@gmail.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060722001819.GP25367@stusta.de>
References: <44C12F0A.1010008@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C12F0A.1010008@namesys.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2006 at 01:46:18PM -0600, Hans Reiser wrote:

> Is http://wiki.kernelnewbies.org/WhyReiser4IsNotIn truly the "official"
> point of view as claimed by its author?  An interesting method of
> expression for it.  I heard about it from a user who suggested that I
> respond before it got slashdotted.

After two users asked the "Why is Reiser4 still not included?" question 
within a very short amount of time on this list (mailing lists aren't 
write-only, and this issue has been discussed often before...), Diego 
wrote an FAQ for this issue.

Emails by people like Linus, Andrew, Christoph or Al are what comes 
nearest to an official statement.

If there are factual errors or things you consider offensive in the FAQ, 
please try to discuss them with Diego privately first. But changing 
contents of this FAQ wouldn't change anything regarding the Reiser4 
inclusion - the FAQ is only a high level description of the Reiser4 
situation for end users.

> Let me ask that one compare and contrast the ext4 integration procedure
> outlined by Ted Tso, with the procedure experienced by other
> filesystems.  The code isn't even written, benchmarked, or tested yet,
> and it is going into the kernel already so that its developers don't
> have to deal with maintaining patches separate from the tree.  Wow. 
> Kind of hard to argue that it is not politically differentiated, isn't it?

The main difference seems to be that ext4 is being developed by people 
that have already shown and are trusted to develop a filesystem that 
follows the Linux way in all respects.

Note that I didn't say "right way" but "Linux way".

No matter whether it's coding style or the discussion which 
functionality belongs to the VFS level, the Linux kernel has it's (often 
unwritten) rules - but the same is true with other rules for any other 
operating system.

>...
> Actually, if we just had a few more akpms to go around, things would be
> a lot better..... oh well.  We need to recruit more people like him. 
> You can't really have code reviewed by persons less experienced and
> proven than those being reviewed, it just doesn't work too well.  Linux
> needs to look outward more, and welcome persons who have proven
> themselves in other arenas as though we were lucky to get their time. 
> Because we are.  Maybe when we don't have people with the expertise to
> review something, we should go outside the Linux community, like the way
> academic journals will solicit outside reviewers for particular articles
> as they need them.  Our current attitude resembles that of BSD before it
> lost the market to Linux, I remember it well, there was a reason why I
> developed for Linux instead.

A very important part of a review is whether it follows the 
"Linux way" that might be quite different from what someone who comes 
from outwards has to learn before he can start doing a review.

Finding people for the cool stuff like developing a new filesystem is 
relatively easy compared to finding people why are both capable and 
willing to do the boring work of reviewing other people's code.

So we'd need people who are already acknowleged experts in the area, who 
are willing to learn the Linux way, and who will then do the not-fun 
work of reviewing other people's code.

How should this work?
Someone has to offer well-paid jobs for such people?

> Avoiding the problems that some large corporations have with politics
> does not happen automatically as a result of it being free software, it
> requires as much effort as it does in the successful large
> corporations.  Non-profits are in no way immune to being harmed by
> internal politics.

In my experience, the Linux kernel is a big open source project with a 
working structure.

The Linux kernel sometimes looses developers.

That seems to unavoidable, there are there are always problems like:
- Some developers leave the projects if their code was rejected because 
  it didn't match the standards and policies of the project.
- Some developers leave the project if other people's code that didn't 
  match the standards and policies of the project was accepted.

And it's not as if open source projects had in any respect better 
prerequisites than large corporations - open source lacks the "it's our 
job" glue forcing people to work together in large corporations.

>...
> Hans

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

