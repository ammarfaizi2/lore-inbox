Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264004AbSKMXGb>; Wed, 13 Nov 2002 18:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbSKMXGb>; Wed, 13 Nov 2002 18:06:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24582 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264004AbSKMXGa>; Wed, 13 Nov 2002 18:06:30 -0500
Date: Wed, 13 Nov 2002 18:11:50 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Steinmetz <ast@domdv.de>
cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <3DD2C0BE.80002@domdv.de>
Message-ID: <Pine.LNX.3.96.1021113181006.31924D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Andreas Steinmetz wrote:

> Sam Ravnborg wrote:
> > On Wed, Nov 13, 2002 at 02:32:27PM -0500, Bill Davidsen wrote:
> >>Also noted, somewhere between 2.5.45 and 2.5.46 distclean vanished from 
> >>"make help." It's really useful to have distclean work to build patched 
> >>kernels for distribution, hopefully this is an oversight and not a new 
> >>policy.
> > 
> > Since they are equal I removed the help for the less used version.
> 
> Not so nice. /me e.g. is used to distclean, never used mrproper and 
> distclean is a standard target in most projects, so people are probably 
> more used to distclean than mrproper which is kernel specific.
> The thing to point this out is that if the help is removed the target 
> will presumably be removed sooner or later, too.
> 

Might as well, the distclean functionality is gone, neither does the full
cleanup.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

