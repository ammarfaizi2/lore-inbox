Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270165AbRHWTb0>; Thu, 23 Aug 2001 15:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270174AbRHWTbQ>; Thu, 23 Aug 2001 15:31:16 -0400
Received: from stanis.onastick.net ([207.96.1.49]:2834 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S270165AbRHWTbM>; Thu, 23 Aug 2001 15:31:12 -0400
Date: Thu, 23 Aug 2001 15:31:26 -0400
From: Disconnect <lkml@sigkill.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823153126.H25051@sigkill.net>
In-Reply-To: <20010823144406.G25051@sigkill.net> <Pine.LNX.4.33L.0108231608520.31410-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33L.0108231608520.31410-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Rik van Riel did have cause to say:

> On Thu, 23 Aug 2001, Disconnect wrote:
> 
> > ONLY task that they will use python for.  And everyone who builds a kernel
> > will have gcc, so thats the 'ideal' dependency.  Second and third most
> > likely, a C++ compiler or perl (depending on what you figure the
> > installbase of each one is).  Forth, some form of java runtime.  And after
> > that is python.
> 
> Sounds like you'd just might be fanatical enough to implement
> CML2 in C or Perl, then ;)
> 
> Personally, I'd welcome such a thing...

You are mistaking my position I think.  Personally, I like python quite a
bit ;) 

But my point isn't that its good/bad for CML2.  My point is that I would
be very surprised if you had to install python in order to configure and
build a kernel under CML2, once CML2 is the official configuration
platform.  (Right now it is necessary to have python to use cml2.  But
CML2 is not yet in the stock kernel sources.)

But until ESR either chimes in or releases the final CML2, this is a moot
discussion.

(As far as someone else's point about a JRE not being installed on most
systems, those were guesstimates rather than statistics.  And even if
-every- distribution included eg kaffe by default, there would still be
people yelling if the kernel had a new dependency on it. ;) ..)

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
