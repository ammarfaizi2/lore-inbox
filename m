Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWHUATo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWHUATo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWHUATo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:19:44 -0400
Received: from 1wt.eu ([62.212.114.60]:2321 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1751207AbWHUATo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:19:44 -0400
Date: Mon, 21 Aug 2006 02:05:00 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Sean <seanlkml@sympatico.ca>, Greg KH <greg@kroah.com>,
       Adrian Bunk <bunk@stusta.de>, Josh Boyer <jwboyer@gmail.com>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-ID: <20060821000500.GO8776@1wt.eu>
References: <20060803204921.GA10935@kroah.com> <625fc13d0608031943m7fb60d1dwb11092fb413f7fc3@mail.gmail.com> <20060804230017.GO25692@stusta.de> <20060806004634.GB6455@opteron.random> <20060806045234.GA28849@kroah.com> <20060820223046.GB10011@opteron.random> <20060820185123.e84fafaf.seanlkml@sympatico.ca> <20060820231510.GD10011@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820231510.GD10011@opteron.random>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 01:15:10AM +0200, Andrea Arcangeli wrote:
> On Sun, Aug 20, 2006 at 06:51:23PM -0400, Sean wrote:
> > There's no need for a vote.  Users already vote for a maintainer when
> > they decide to use a paticular kernel tree.
> >
> > No user is forced to follow a particular maintainer.  And anyone can step
> > up and declare that they are also offering a maintained tree.
> 
> I never said that 2.6.16-stable is going to succeed, all I'm saying is
> that all testing done on it will be a wasted effort, that's why there
> are no infinite competing trees.

Andrea, I don't agree with you on this.
If 2.6.16 succeeds, some people who currently cannot rely on 2.6 due
to its code changing too fast will be able to make the move. Also, those
who need a good reliability will be able to check in one year if they
consider it reliable enough for their use, based on other user's feedback.

Once those users depend on this kernel, they will probably send fixes
back when they'll find a bug. Right now, many people using 2.6 just
run it off the CD of their pet distro, and when something goes wrong,
they decide the distro is broken and they change to anything else
(which might have a different kernel version). Do not believe that
everyone has enough knowledge to send valuable bug reports and/or
fix bugs. Basically, you have them all reading this list on a somewhat
regular basis.

> So one would hope that an official
> maintainer isn't choosed by random.
> 
> > And this situation is already self correcting; if no users follow, it's
> 
> The real ironic thing, is that the only feedback he has to know if
> users follow or not, is KLive. Which I'm going to shutdown anyway if
> nothing changes w.r.t. 2.6.16-stable since I'm not out to fight with
> anyone, I don't even have a degree in statistics, so it's up to the
> thousands getting a degree in statistics every year to argue with the
> -stable maintainers, certainly not me.

Well, you've been fighting over opinions. Both of you have been a bit
rude with the other one. Adrian has finally removed his mocking (and
IMHO childish) signature. Why don't you consider the problem solved
and keep your project online ?

Willy

