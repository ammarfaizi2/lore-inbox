Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268248AbTCFRsw>; Thu, 6 Mar 2003 12:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268252AbTCFRsw>; Thu, 6 Mar 2003 12:48:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:29112 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268248AbTCFRsv>;
	Thu, 6 Mar 2003 12:48:51 -0500
Date: Thu, 6 Mar 2003 18:58:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <1046976597.17715.93.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303061858050.16060-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Mar 2003, Alan Cox wrote:

> On Thu, 2003-03-06 at 17:11, Ingo Molnar wrote:
> > X is special. Especially in Andrew's wild-window-dragging experiment X is
> > a pure CPU-bound task that just eats CPU cycles no end. There _only_ thing
> > that makes it special is that there's a human looking at the output of the
> > X client. This is information that is simply not available to the kernel.
> 
> Just like a streaming video server
> Just like a 3D game using DRI
> 
> X isnt special at all. [...]

i'm convinced we are talking about the same thing. My argument was that X
is special _only_ because humans are looking at it. Ie. it's not special
at all to the kernel.

	Ingo

