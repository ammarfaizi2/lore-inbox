Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268090AbTBXGAS>; Mon, 24 Feb 2003 01:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268117AbTBXGAS>; Mon, 24 Feb 2003 01:00:18 -0500
Received: from [65.39.167.210] ([65.39.167.210]:44558 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S268090AbTBXGAR>;
	Mon, 24 Feb 2003 01:00:17 -0500
Date: Mon, 24 Feb 2003 01:10:28 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Larry McVoy <lm@bitmover.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Bill Davidsen <davidsen@tmr.com>,
       Ben Greear <greearb@candelatech.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <20030224045717.GC4215@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0302240109420.31224-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, Larry McVoy wrote:

> Date: Sun, 23 Feb 2003 20:57:17 -0800
> From: Larry McVoy <lm@bitmover.com>
> To: Martin J. Bligh <mbligh@aracnet.com>
> Cc: Bill Davidsen <davidsen@tmr.com>, Ben Greear <greearb@candelatech.com>,
>      Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Minutes from Feb 21 LSE Call
>
> On Sun, Feb 23, 2003 at 03:37:49PM -0800, Martin J. Bligh wrote:
> > >> For instance, don't locks simply get compiled away to nothing on
> > >> uni-processor machines?
> > >
> > > Preempt causes most of the issues of SMP with few of the benefits. There
> > > are loads for which it's ideal, but for general use it may not be the
> > > right feature, and I ran it during the time when it was just a patch, but
> > > lately I'm convinced it's for special occasions.
> >
> > Note that preemption was pushed by the embedded people Larry was advocating
> > for, not the big-machine crowd .... ironic, eh?
>
> Dig through the mail logs and you'll see that I was completely against the
> preemption patch.  I think it is a bad idea, if you want real time, use
> rt/linux, it solves the problem right.

So your saying I need to switch to rt/linux to run games or an mp3 player?

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

