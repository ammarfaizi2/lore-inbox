Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVE2Bxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVE2Bxl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 21:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVE2Bxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 21:53:40 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:22688 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261212AbVE2Bxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 21:53:38 -0400
Date: Sat, 28 May 2005 19:55:46 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Bill Huey <bhuey@lnxw.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <20050528054503.GA2958@nietzsche.lynx.com>
Message-ID: <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com>
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
 <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
 <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
 <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>
 <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au>
 <20050528054503.GA2958@nietzsche.lynx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Bill Huey wrote:

> > It isn't clear to me yet. I'm sure you can make your interrupt
> > latencies look good, as with your scheduling latencies. But when
> 
> My project was getting a solid spike at 4 usec for irq-thread
> startups and Ingo's stuff is better. It's already there.

Is that worst case?

> > I wouldn't consider a non response (or a late response) to mean that
> > a point has been conceeded, or that I've won any kind of argument :-)
> 
> Well, you're wrong. :)
> 
> Well, uh, ummm, start writing RT media apps and you will know what
> I'm talking about. Dual kernel stuff isn't going to fly with those
> folks especially with an RT patch as good as this already in the
> general kernel. More experience with this kind of programming makes
> it clear where the failures are with a dual kernel approach.

Media apps are actually not that commonplace as far as hard realtime 
applications are concerned.

	Zwane

