Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288814AbSAVQvx>; Tue, 22 Jan 2002 11:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288944AbSAVQvk>; Tue, 22 Jan 2002 11:51:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53774 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288814AbSAVQv2>; Tue, 22 Jan 2002 11:51:28 -0500
Date: Tue, 22 Jan 2002 11:51:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33.0201211626230.17139-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.3.96.1020122114508.27258B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Mark Hahn wrote:

> you overestimate human uniqueness - we all have near-identical
> perceptual hardware, and there *is* an absolute limit
> beyond which no human can perceive.  for our purposes, let's
> say it's 5ms.

Let's say that if the original poster didn't see the difference (a) he has
NO functioning "perceptual hardware," or (b) he hasn't tried it, which I
invited him to do.
 
> > There are some responsemarks which may or may not be useful, feel free to
> > actually locate and run these and post the results instead of posting
> 
> I posted "realfeel" last year, AKPM added some touches to it.
> it's in his amlat bundle.  

I was making the point that no quantification is needed, rmap is at the
"wow that's better!" level overywhere I've tried it.

Now if someone could get the rmap performance with memory pressure, add
the -aa improvements to heavy i/o and large memory, and season with a
touch of J4 scheduler, I think we could have response which would blow
your fingers off the keyboard.

OT: has someone gotten 2.4.17 rmap-11c and J4 playing together? I looked
at it for about five minutes but had no time last night. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

