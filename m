Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTB0UKr>; Thu, 27 Feb 2003 15:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbTB0UKr>; Thu, 27 Feb 2003 15:10:47 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:21262 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266796AbTB0UKp>; Thu, 27 Feb 2003 15:10:45 -0500
Date: Thu, 27 Feb 2003 15:04:18 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <20030227005619.GA2756@gnuppy.monkey.org>
Message-ID: <Pine.LNX.3.96.1030227144704.21890B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Bill Huey wrote:

> On Wed, Feb 26, 2003 at 02:31:33PM -0500, Bill Davidsen wrote:
> > On Mon, 24 Feb 2003, Bill Huey wrote:
> > > You don't need data. It's conceptually obvious. 
> > 
> >   The mantra of doomed IPOs ill-fated software projects, and the guy down
> > the street who has never invested in a company which was still in business
> > 24 months later. No matter how great the concept it still has to work. 
> 
> I'm not disagreeing with that, but if you read the previous exchange you'd see
> that I was reacting to what seemed to be an obviously rude dismissal of how
> latency effects both IO performance of a system and trashes the usability of
> the a priority driven scheduler. It's basic computer science.

No argument from me, but I have seen systems driving up the system time
and beating the cache with scheduling logic and context switches. There's
a balance to be had there, and in timeslice size, and other places as
well, and real data are always useful.

> >   It's conceptionally obvious that professional programmers working for a
> > major software house will write a better os than a grad student fighting
> > off boredom one summer... in the end you always need data.
> 
> Had to read your post a couple of times to make sure that the tone of it
> wasn't charged. :)

It's always more effective if it's subtle and and people take an instant
to get it.

> All I can say now is that I'm working on it. We'll see if it's vaporware
> in the near future.

Great. I have no doubt that when you have convinced yourself one way or
the other you won't have any problem convincing me. When the io was slow,
the VM was primitive, and the scheduler was a doorknob, preempt made a big
improvement. Now that the rest of the kernel doesn't suck, it's a lot
hardware to make a big improvement.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

