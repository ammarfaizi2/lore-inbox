Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129844AbRBQAt2>; Fri, 16 Feb 2001 19:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130170AbRBQAtT>; Fri, 16 Feb 2001 19:49:19 -0500
Received: from smtp.alacritech.com ([209.10.208.82]:28435 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S129844AbRBQAtP>; Fri, 16 Feb 2001 19:49:15 -0500
Message-ID: <3A8DCBE2.7A5D311@alacritech.com>
Date: Fri, 16 Feb 2001 16:54:58 -0800
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
CC: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        yakker@alacritech.com
Subject: Re: Linux stifles innovation...
In-Reply-To: <Pine.LNX.4.33.0102161843490.2548-100000@asdf.capslock.lan> <3A8DC2A7.43C7A5C3@alacritech.com> <20010217013422.A3055@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> 
> Matt D. Robinson wrote:
> > My feeling is we should splinter the kernel development for
> > different purposes (enterprise, UP, security, etc.).  I'm sure
> > it isn't a popular view, but I feel it would allow faster progression
> > of kernel functionality and features in the long run.
> 
> "enterprise" XOR security ? I think you understand the problem with
> your approach well ;-)

Actually I do.  Perhaps I should define enterprise as "big iron".  In
that way, enterprise kernels would be far more innovative than a
secure kernel (which cares less about performance gains and large
features and more about just being "secure").  Unless you meant
something else and I'm misinterpreting what you've stated. :)

> Linux scales well from PDAs to large clusters. This is quite an
> achievement. Other operating systems are not able to match this.
> So why do you think that Linux should try to mimic their flaws ?
> Out of pity ?

I always considered SGI's kernels, from the low-end system up to
the large server configurations, to scale well.  Certainly it didn't
work on PDAs. :)  If you consider it a flaw for vendors to be able
to create their own Linux kernels based on optimizations
for their hardware and their customers, then that's a horrible
perspective on overall open source progression.  In fact, I think
if some of these vendors created their own kernel trees, it would
inevitably lead to inclusion of the best features into the primary
kernel tree.  Where's the harm in that?

> BTW, parallel development does happen all the time. The point of
> convergence in a single "mainstream" kernel is that you benefit
> from all the work that's been going on while you did the stuff
> you care most about.

Agreed.  It's great to have a "primary" kernel.  I'd like to see
more splintered kernels (not smaller project efforts), that's all.
And I don't think that convergence happens quickly or efficiently
enough, despite all the great work Linus and Alan do.

> - Werner (having pity with the hungry looking trolls)

--Matt
