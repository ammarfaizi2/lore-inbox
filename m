Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbSI3Teu>; Mon, 30 Sep 2002 15:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSI3Teu>; Mon, 30 Sep 2002 15:34:50 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58639 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261208AbSI3Tet>; Mon, 30 Sep 2002 15:34:49 -0400
Date: Mon, 30 Sep 2002 15:32:42 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jens Axboe <axboe@suse.de>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <20020929091229.GA1014@suse.de>
Message-ID: <Pine.LNX.3.96.1020930151754.20863I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Jens Axboe wrote:

> On Sun, Sep 29 2002, jbradford@dial.pipex.com wrote:
> > > Anyway, people who are having VM trouble with the current 2.5.x series, 
> > > please _complain_, and tell what your workload is. Don't sit silent and 
> > > make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x 
> > > thing.
> > 
> > I think the broken IDE in 2.5.x has meant that it got seriously less
> > testing overall than previous development trees :-(.  Maybe after
> > halloween when it stabilises a bit more we'll get more reports in.
> 
> 2.5 is definitely desktop stable, so please test it if you can. Until
> recently there was a personal show stopper for me, the tasklist
> deadline. Now 2.5 is happily running on my desktop as well.

2.5.38-mm2 has been stable for me on uni, what is the status of SMP? I had
what looked like logical to physical mapping problems on a BP6 and Abit
dual P5C-166, resulting in syslog data on every drive including those with
no Linux partition. That was somewhere around 2.5.22 to 2.5.26.
 
> 2.5 IDE stability should be just as good as 2.4-ac.

A laudable goal.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

