Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbSA2XIN>; Tue, 29 Jan 2002 18:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSA2XGq>; Tue, 29 Jan 2002 18:06:46 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33809 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S286336AbSA2XGF>; Tue, 29 Jan 2002 18:06:05 -0500
Date: Tue, 29 Jan 2002 18:05:28 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jussi Laako <jussi.laako@kolumbus.fi>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C4DD07B.9C7D4926@kolumbus.fi>
Message-ID: <Pine.LNX.3.96.1020129180237.31511G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Jussi Laako wrote:

> Bill Davidsen wrote:
> > 
> > OT: has someone gotten 2.4.17 rmap-11c and J4 playing together? I looked
> > at it for about five minutes but had no time last night.
> 
> It's in my -jl13 http://www.pp.song.fi/~visitor/linux/

It was 15 by the time I tried it, but I'm still running it. What sched is
in pre7ac1? I looked at the post Alan put up and didn't see it on the
first pass. The Jn scheduler and and low latency seem to play well with
rmap, but the -aa changes to enable better bdflush tuning work well. I
don't want to tune for dbench, but I don't want to ignore it, either.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

