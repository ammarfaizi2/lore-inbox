Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSJAGYW>; Tue, 1 Oct 2002 02:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261496AbSJAGYW>; Tue, 1 Oct 2002 02:24:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3778 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261495AbSJAGYV>;
	Tue, 1 Oct 2002 02:24:21 -0400
Date: Tue, 1 Oct 2002 08:26:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
Message-ID: <20021001062630.GM3867@suse.de>
References: <20020929091229.GA1014@suse.de> <Pine.LNX.3.96.1020930151754.20863I-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020930151754.20863I-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30 2002, Bill Davidsen wrote:
> On Sun, 29 Sep 2002, Jens Axboe wrote:
> 
> > On Sun, Sep 29 2002, jbradford@dial.pipex.com wrote:
> > > > Anyway, people who are having VM trouble with the current 2.5.x series, 
> > > > please _complain_, and tell what your workload is. Don't sit silent and 
> > > > make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x 
> > > > thing.
> > > 
> > > I think the broken IDE in 2.5.x has meant that it got seriously less
> > > testing overall than previous development trees :-(.  Maybe after
> > > halloween when it stabilises a bit more we'll get more reports in.
> > 
> > 2.5 is definitely desktop stable, so please test it if you can. Until
> > recently there was a personal show stopper for me, the tasklist
> > deadline. Now 2.5 is happily running on my desktop as well.
> 
> 2.5.38-mm2 has been stable for me on uni, what is the status of SMP? I had
> what looked like logical to physical mapping problems on a BP6 and Abit
> dual P5C-166, resulting in syslog data on every drive including those with
> no Linux partition. That was somewhere around 2.5.22 to 2.5.26.

Well I do all my 2.5 testing on SMP, I don't even remember when I last
compiled a UP 2.5 kernel. Well works for me as I wrote earlier, I don't
keep the deskop up more than a few days at the time though. Then I boot
a newer 2.5 on it.

> > 2.5 IDE stability should be just as good as 2.4-ac.
> 
> A laudable goal.

If you know of any points where this is currently not true, I'd like to
hear about it. I'm considering this goal reached. Whether 2.4-ac is at
the level we want is a different story.

-- 
Jens Axboe

