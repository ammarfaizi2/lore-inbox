Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267575AbTBUQr3>; Fri, 21 Feb 2003 11:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbTBUQr3>; Fri, 21 Feb 2003 11:47:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28168 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267575AbTBUQr2>; Fri, 21 Feb 2003 11:47:28 -0500
Date: Fri, 21 Feb 2003 11:53:31 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: shoninnaive@sbcglobal.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 series IDE troubles
In-Reply-To: <1045848644.5275.58.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030221115043.22132K-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Feb 2003, Alan Cox wrote:

> On Fri, 2003-02-21 at 13:01, j wrote:
> > least from what I see in searchs on these errors. Usually the problem
> > is blamed on the user and they are asked hundreds of irritating questions about hardware and configuration.
> > 
> 
> And without that information there is no way to fix it. At a first guess 
> you've stuck an IDE master and a flash slave via an adapter on the same
> cable. 

Didn't he say it worked in 2.2? If that's true then perhaps it should in
2.4 and later.

I've given up a bought a USB flash adaptor, my ISA bus PCMCIA adaptor
hasn't worked for flash since about 2.4.16 or so. Not a complaint, but
there may be issues in that support, I just didn't have time to fight with
the problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

