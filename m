Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVACV2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVACV2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVACV2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:28:19 -0500
Received: from mail.dif.dk ([193.138.115.101]:49644 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261912AbVACVY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:24:28 -0500
Date: Mon, 3 Jan 2005 22:35:43 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7 
In-Reply-To: <200501032113.j03LDWsa004885@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.61.0501032232060.3529@dragon.hygekrogen.localhost>
References: <200501032113.j03LDWsa004885@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Horst von Brand wrote:

> "Theodore Ts'o" <tytso@mit.edu> said:
> 
> [...]
> 
> > The real key, as always, is getting users to download and test a
> > release.  So another approach might be to shorten the time between
> > 2.6.x and 2.6.x+1 releases, so as to recreate more testing points,
> > without training people to wait for -bk1, -bk2, -rc1, etc. before
> > trying out the kernel code.  This is the model that we used with the
> > 2.3.x series, where the time between releases was often quite short.
> > That worked fairly well, but we stopped doing it when the introduction
> > of BitKeeper eliminated the developer synch-up problem.  But perhaps
> > we've gone too far between 2.6.x releases, and should shorten the time
> > in order to force more testing.  
> 
> Is there any estimate of the number of daily-straight-from-BK users? I'm
> one, haven't seen any trouble (thus silent up to here).

I'm another. Every morning when I turn on my machine I grab the latest 
-bk, build it with my usual config, install that kernel and reboot, then 
use that as my "kernel of the day". I do this on both my home and work 
box (well, the work box only does this on mondays) and I've had very 
little trouble so far.

-- 
Jesper Juhl


