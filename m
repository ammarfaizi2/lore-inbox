Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280736AbRKYFuA>; Sun, 25 Nov 2001 00:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280737AbRKYFtv>; Sun, 25 Nov 2001 00:49:51 -0500
Received: from otter.mbay.net ([206.40.79.2]:3085 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S280736AbRKYFtn>;
	Sun, 25 Nov 2001 00:49:43 -0500
Date: Sat, 24 Nov 2001 21:49:39 -0800 (PST)
From: John Alvord <jalvo@mbay.net>
To: David Relson <relson@osagesoftware.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Releases
In-Reply-To: <4.3.2.7.2.20011124231412.00b40c50@mail.osagesoftware.com>
Message-ID: <Pine.LNX.4.20.0111242147500.26049-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Development kernels are development kernels... nothing else. Look to
distributors for high degrees of quality assurance testing. When you run a
development kernel you have joined the development team, even if you don't
know it. Finding  and reporting bugs is your job...

john alvord

On Sat, 24 Nov 2001, David Relson wrote:

> Greetings to All,
> 
> Over the past few months, I've been listening in on LKML, with occasional, 
> minor comments - mostly to help newbies.  Now, I think it's time for a 
> suggestion ...
> 
> As we all know, several of the recent releases have had defects that have 
> __required__ patches before they could be built (or used safely).  Problems 
> with symlinks, loopbacks, and unmount come to mind as being like 
> this.  They are all show stoppers that required immediate fixes and the 
> creation of a new release or of the next -pre1 version.
> 
> I have a tendency to tink that it's better to be running a released kernel, 
> than a pre-release kernel.  I'd much rather be running a kernel named 2.4.x 
> than a kernel named 2.4.y-pre?.  With the recent problems, the working 
> versions tend to be the -pre1 or -pre2 releases, not the released 
> one.  With a bit of QA, I think we can have 2.4.x releases be the stable 
> releases.  Here's how...
> 
> When the kernel maintainer, now Marcelo for 2.4, is ready to release the 
> next kernel, for example 2.4.16, I suggest he switch from "pre?" to "-rc1" 
> (as in release candidate).  A day or two with -rc1 will quickly show if it 
> has a show stopper.  If so, then the minor fixes (and nothing else) go into 
> -rc2.  A day or two ..., and either -rc3 appears or we have a stable 
> release and 2.4.16 is ready to be released.
> 
> Let's go the extra distance and have the releases be usable, stable 
> kernels!  It's what users want and it's within the abilities of the 
> developers to produce.  Let's do it :-)
> 
> David
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

