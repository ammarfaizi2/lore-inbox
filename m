Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbRCARJy>; Thu, 1 Mar 2001 12:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbRCARJk>; Thu, 1 Mar 2001 12:09:40 -0500
Received: from cr481834-a.ktchnr1.on.wave.home.com ([24.42.218.237]:28657 "EHLO
	scotch.homeip.net") by vger.kernel.org with ESMTP
	id <S129723AbRCARJX>; Thu, 1 Mar 2001 12:09:23 -0500
Date: Thu, 1 Mar 2001 12:17:46 -0500 (EST)
From: God <atm@pinky.penguinpowered.com>
To: linux-kernel@vger.kernel.org
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
In-Reply-To: <3A9E72D3.36B28B8F@namesys.com>
Message-ID: <Pine.LNX.4.21.0103011148540.918-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Hans Reiser wrote:

> Date: Thu, 01 Mar 2001 19:03:31 +0300
> 
> Todd wrote:

> > hans,
 
> > we've found that the TCP and UDP performance on 2.4 is *dramatically*
> > better than 2.2.

[..]

> > i'd recommend it's networking performance to anyone.


> > 
> > On Thu, 1 Mar 2001, Hans Reiser wrote:

> > > They know that iMimic's polymix performance on Linux 2.2.* is half what it is on
> > > BSD.  Has the Linux 2.4 networking code caught up to BSD?

> > > Can I tell them not to worry about the Linux networking code strangling their
> > > webcache product's performance, or not?

> 
> The problem is that I really need BSD vs. Linux experiences, not Linux 2.4 vs.
> 2.2 experiences, because the webcache industry tends to strongly disparage Linux
> networking code, so much better isn't necessarily good enough.
> 

It isn't just the webcache industry, heh.  I have not yet played with 2.4,
let alone under what I consider stress; but from experience with 2.2 and
eairlier I could see why one would take fbsd over linux.  Between
mysterious messages popping up on the console (be it they are related to
NIC drivers or not), and other oddities as ram and fd's fill up, fbsd
could be considered by some to be better suited.  


On the topic of perfromance, I see Todd and a few others post some
numbers, but has anyone kept track of them through kernel versions and 
drivers?   It would be interesting to see something like lmbench run on
each, and their results recorded.

I'm tempted to run various tests before and after I upgrade from 2.2.x to
2.4.x, just to see the difference ....

</crazy>

