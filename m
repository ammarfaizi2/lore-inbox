Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267904AbTAHO4r>; Wed, 8 Jan 2003 09:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267905AbTAHO4r>; Wed, 8 Jan 2003 09:56:47 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61190 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267904AbTAHO4q>; Wed, 8 Jan 2003 09:56:46 -0500
Date: Wed, 8 Jan 2003 10:02:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: jeff gerard <jeff-lk@gerard.st>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] menuconfig color sanity
In-Reply-To: <20030108104714.GM268@gage.org>
Message-ID: <Pine.LNX.3.96.1030108095857.21895A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, jeff gerard wrote:

> using yellow and green text with a "white" background in menuconfig works all
> right on console, but it looks like crap under xterm, rxvt, etc. no
> matter whose fault that is, the trivial patch below makes things more
> readable without any major change in appearance. applies to 2.4 and 2.5.
> 
> now you can stop wondering about support for "lug and play", "mateur radio", 
> and "elephony" in the linux kernel.

Man, did you look at this on a console? That is uglier than a hedgehog's
asshole! Good idea, poor implementation. Please retry, the default colors
are not as bad on an xterm as the new colors on a console. And with small
memory machines I sure don't build kernels using X! 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

