Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTFTOn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTFTOn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:43:29 -0400
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:52486 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id S262363AbTFTOnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:43:25 -0400
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Larry McVoy <lm@bitmover.com>, Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Date: Fri, 20 Jun 2003 09:44:05 -0500
User-Agent: KMail/1.5.2
Cc: Werner Almesberger <wa@almesberger.net>, lm@bitmover.com,
       miquels@cistron-office.nl, linux-kernel@vger.kernel.org
References: <063301c32c47$ddc792d0$3f00a8c0@witbe> <20030620120910.3f2cb001.skraw@ithnet.com> <20030620142436.GB14404@work.bitmover.com>
In-Reply-To: <20030620142436.GB14404@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306200944.05937.nleroy@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 June 2003 9:24 am, Larry McVoy wrote:

Larry...

> Here's some mail I sent last night which summarizes my view.  I didn't
> intend to post it here as it is a little harsh but what the heck, in for
> a penny, in for a pound.
>
>     I've said for years that the open source world is all about
>     reimplementing and not about new innovation.  Sure, people make
>     the thing they copy somewhat better and maybe even lots better.
>     I personally like Linux better than any of the Unices and I've been
>     running Unix since 32v timeframe.
>
>     But the deal is that if Linux and the rest of the open source world
>     was creating their own stuff instead of copying someone else's,
>     this wouldn't be a Linux problem, it would be an IBM problem.
>
>     The reason I take this point of view, unpopular though it may be,
>     is that I see open source as basically parasitic.  It lives off the
>     efforts of others and the big bummer is that it is killing its host.
>     If open source can realize this and change gears fast enough to learn
>     to create its own work, great.  But that's going to take a lot more
>     money than open source is currently generating.  Like at least 3
>     orders of magnitude.  Sun spends more in a year on Solaris than all
>     the other open source revenue put together.  Think about that for
>     a while.  Then realize that a ton of the work in Linux was dreamed
>     up by the Solaris engineers.  Remember, I've been on the mailing
>     list since 0.99 days or earlier and I worked at Sun, I know where
>     stuff came from.  There is very very very little new work in Linux.
>     Better tuned?  Sure.  Leaner?  Sure.  Cleaner?  Maybe.  New?  No.
>     So where is the inspiration for new work going to come from when
>     Linux kills off Sun and every other source of innovation?
>
>     Don't get me wrong, Linux is better in some ways.  The main thing,
>     however, is device drivers.  That's hardly innovation.
>
>     I hate to sound like Bill Gates but I start to think he has a point.
>     I wouldn't be surprised if I get sent to /dev/null in your procmailrc
>     for this rant but that's my view of where we sit.

We've communicated before, and I've been a (quiet) supporter of your views.  
But, here I think that I'm forced to take issue.

You sight the Linux kernel as non-inovative, essentially.  I'll certainly 
grant that the general idea of a Unix kernel is not original work, and that 
most of the concepts from which Linux is derived are well known.  I also take 
issue with the idea that there's _nothing_ innovative about LK, but I'm

However, I think that we need to look at the whole open source "picture".

Sendmail, very much open source, was certainly ground-breaking.  The X window 
system.  Nethack, adventure, etc. -- the whole concept of computer gaming 
derives from the open source world (granted the is all from long before the 
term "open source" existsed).

I'm in the "grid computing" world, so I'd like to discuss the inovations in 
it.  The Condor project, of which I am a core member, has it's roots as a 
open source project (originally a BSD-like license), and was very 
ground-breaking in the world of distributed computing, and still is.  The 
reason that Condor became non-open is because pieces of it were closed off 
for profit by groups that I won't mention here.  Shameless plug: Condor is 
now released under the Condoor Public License, and we will be releasing the 
source code as soon as we get it cleaned up and "releasable" 
(http://www.condorproject.org).  The point is that Condor and other open 
source projects (like Globus) are leading the entire field of grid / 
distributed computing.

I'm sure many other such examples exists.  Which is why I have to take 
exception to your blanket statement.

Hope we're still friends....

-Nick

