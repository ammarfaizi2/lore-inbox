Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSHGXar>; Wed, 7 Aug 2002 19:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSHGXaq>; Wed, 7 Aug 2002 19:30:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49168 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315388AbSHGXaq>; Wed, 7 Aug 2002 19:30:46 -0400
Date: Wed, 7 Aug 2002 19:28:19 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why 'mrproper'?
In-Reply-To: <20020807170041.GA259@win.tue.nl>
Message-ID: <Pine.LNX.3.96.1020807191903.14463G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Andries Brouwer wrote:

> On Wed, Aug 07, 2002 at 08:55:25AM -0400, Bill Davidsen wrote:
> 
> > Having started out on the four floppy MCC "distribution" of Linux,
> > building kernels clean with 'make distclean,' can someone provide a quick
> > historical note as to what mrproper buys? A quick look at the tree after
> > each didn't tell me much.
> 
> Funny that you ask this question first now.

It came to me as I was looking for something else in 2.4.19. Notably that
"make backup" backs up "linux" even though the tar file now unpacks into
linux-2.4.19. That looks kind of like a problem waiting to bite some
kernel developer.

> mrproper came in 0.99p7
> distclean came in 0.99p14 as a synonym for mrproper.

It certainly isn't such now, it does a good bit more. Anyway, I have my
bit of history for the day, thanks all!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

