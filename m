Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUGLXMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUGLXMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUGLXMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:12:55 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:16786 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264129AbUGLXMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:12:52 -0400
Subject: Re: desktop and multimedia as an afterthought?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: florin@sgi.com
Content-Type: text/plain
Organization: 
Message-Id: <1089665153.1231.88.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jul 2004 16:45:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Andrei writes:

> I could be wrong, but it seems to me that at least a part of the kernel
> development team has the desktop and multimedia issues very low on the 
> priority list.

You're right, but you imply that this is bad. It would only be
bad if _all_ of the kernel development team had the desktop and
multimedia issues very low on the priority list. It would be
far worse if everyone worked on multimedia issues.

> The CK patches floated around as separate patches for a long time, even
> though they brought significant improvements to the kernel w.r.t.
> desktop and media.
> Now the stock 2.6 kernel has a pretty bad problem with the latency.
> Also, there seems to be a reluctance in accepting the autoregulated
> swappiness patch, even though it markedly improves the overall behaviour
> of the system as a desktop.
  
Reluctance is good. Reluctance keeps out bloat. Reluctance supplies
time to investigate alternate ideas that might be better.

> The CK patches have devouted "cult followers".
> Projects such as PlanetCCRMA, which attempt to build a multimedia-ready
> Linux distribution, are running kernels patched with the CK patches by
> default.

This is expected. It's how proposed features get widespread testing.

> On the Linux multimedia mailing lists and forums, one can often hear
> advices in the vein of "use such-and-such patch if you want your system
> to do any serious multimedia work, the vanilla kernel sucks."
...
> I mean, go read the forums. No one in the multimedia community uses the
> vanilla kernel. They could be all wrong, sure, but there's lots of them.
     
It's too bad that the multimedia community didn't participate
much during the 2.5.xx development leading up to 2.6.0. If they
had done so, the situation might be different today. Fortunately,
fixing up the multimedia problems isn't too risky to do during
the stable 2.6.xx series.
  
> It seems like there's a split-brain situation within the Linux
> community, with the core kernel developers sitting on one side of the
> rift, and the multimedia people on the other side.
  
Nah. People do forget about problems if nobody is reporting them.
Since the problem reports came in late, you get to be last.
 
> Now, i remember someone saying, a while ago, that the server stuff is  
> pretty much done, and the interesting things are going to happen on the
> desktop. That sounds plausible, but if the kernel has poor support for 
> typical desktop scenarios, how are those big desktop improvements going
> to take place?

Much of that is about hot-plug, laptops going to sleep,
busy disks being ripped from the machine, support for
recent video card features, and so on. Multimedia is only
a small part of the big picture, even for desktop usage.



