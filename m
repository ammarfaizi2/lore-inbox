Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTJGCeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 22:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJGCeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 22:34:19 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54290
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261773AbTJGCeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 22:34:17 -0400
Date: Mon, 6 Oct 2003 19:31:59 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pascal Schmidt <der.eremit@email.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <Pine.LNX.4.44.0310070215470.32013-100000@neptune.local>
Message-ID: <Pine.LNX.4.10.10310061921220.2266-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Pascal Schmidt wrote:

> On Mon, 6 Oct 2003, Andre Hedrick wrote:
> 
> > No it can not, by only using the headers as the functional API for that
> > snapshot verson of the kernel release, it is the standard means for
> > functionality.
> 
> Well, I don't see "standard means for functionality" mentioned anywhere
> in the GPL or copyright law (though I'm no expert on that).

You should pay a lawyer and learn something then.

> If a header contains a macro that expands to real code and a module
> has to use that, it means that it absolutely needs that part of kernel
> source code to function and then it is a derived work because it
> includes GPL'ed code and would not work without it.

Sorry but usage of headers the functional api is an unprotectable work.
To follow up on the point of boundaries, it is abstract interface to
properly work as a driver in the given space.

Alternative view, using the MS DDK and the associated headers for running
in MicroSoft.  Because a driver uses MicroSoft Headers, does it make it a
derived work belonging to MicroSoft?

> > If the macro is require for any driver and or one in the
> > kernel to function, and is listed in the headers, it is generally deemed
> > to part of the unportected API.
> 
> Says who? Who defines what is unprotected API and what is not?

US Copyright and courts the rest of the pathetic world is lame and brain
dead and even follows our stupidity with DMCA laws also.

<see flame bait, above>

Lawyers who make up the meaning of the laws.  You should really decide to
spend some money to get an expensive education.  $10,000 USD or Euro
should be enough to rudely open your eyes to how the courts operate.
Copyright law is so strange and painful.

I know it was an expensive lesson for me to start writing checks to
lawyers, but less costly than making mistakes based on ignorance.

> > Again it is very simple declare, all modules which are not GPL and reject
> > loading, and we can watch the death of linux as nobody will use it.  Again
> > who cares, because it started out as fun for a Finn in 1991, and should
> > never be of use or value outside of academics.
> 
> Well, silly me, I only buy hardware with open source drivers available.
> I wouldn't agree that something is good and has to be done just because
> it would improve Linux' "success" (I wouldn't define that to be
> commercial success, either).

Does tongue in cheek mean anything?

Cheers,

Andre

PS one day I will figure out how to enable the spell check in pine, sigh.

