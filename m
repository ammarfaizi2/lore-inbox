Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVADAu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVADAu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVADAqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:46:17 -0500
Received: from mail.tmr.com ([216.238.38.203]:19213 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262005AbVADAma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:42:30 -0500
Date: Mon, 3 Jan 2005 19:02:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, "Theodore Ts'o" <tytso@mit.edu>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7 
In-Reply-To: <Pine.LNX.4.61.0501032232060.3529@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.3.96.1050103190042.30038F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Jesper Juhl wrote:

> On Mon, 3 Jan 2005, Horst von Brand wrote:
> 
> > "Theodore Ts'o" <tytso@mit.edu> said:
> > 
> > [...]
> > 
> > > The real key, as always, is getting users to download and test a
> > > release.  So another approach might be to shorten the time between
> > > 2.6.x and 2.6.x+1 releases, so as to recreate more testing points,
> > > without training people to wait for -bk1, -bk2, -rc1, etc. before
> > > trying out the kernel code.  This is the model that we used with the
> > > 2.3.x series, where the time between releases was often quite short.
> > > That worked fairly well, but we stopped doing it when the introduction
> > > of BitKeeper eliminated the developer synch-up problem.  But perhaps
> > > we've gone too far between 2.6.x releases, and should shorten the time
> > > in order to force more testing.  
> > 
> > Is there any estimate of the number of daily-straight-from-BK users? I'm
> > one, haven't seen any trouble (thus silent up to here).
> 
> I'm another. Every morning when I turn on my machine I grab the latest 
> -bk, build it with my usual config, install that kernel and reboot, then 
> use that as my "kernel of the day". I do this on both my home and work 
> box (well, the work box only does this on mondays) and I've had very 
> little trouble so far.

Somewhere there is a pawn shop with only one big brass ball, and I know
where the other two are...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

