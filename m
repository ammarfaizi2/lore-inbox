Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267387AbTBVS47>; Sat, 22 Feb 2003 13:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbTBVS47>; Sat, 22 Feb 2003 13:56:59 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57353 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267387AbTBVS46>; Sat, 22 Feb 2003 13:56:58 -0500
Date: Sat, 22 Feb 2003 14:02:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: shoninnaive@sbcglobal.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 series IDE troubles
In-Reply-To: <1045853980.1196.1.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030222135641.27473B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Feb 2003, Alan Cox wrote:

> > And without that information there is no way to fix it. At a first guess 
> > > you've stuck an IDE master and a flash slave via an adapter on the same
> > > cable. 
> > 
> > Didn't he say it worked in 2.2? If that's true then perhaps it should in
> > 2.4 and later.
> 
> Did I say otherwise ? But if he isnt using 2.4.21pre-ac then it wont

Will this not migrate into mainline? Or is there some objection to it?

> 
> > I've given up a bought a USB flash adaptor, my ISA bus PCMCIA adaptor
> > hasn't worked for flash since about 2.4.16 or so. Not a complaint, but
> > there may be issues in that support, I just didn't have time to fight with
> > the problem.
> 
> With 2.4.21pre (the firs 2.4 IDE I hacked on seriously) pcmcia flash works on
> my test setups, and gets used fairly hard for digital cameras

I suppose I should stick a media in again and try 2.4.21-pre4-ac5 and
2.5.61-ac1, which are what I have moderately working in other ways. The
digital camera is exactly what drive my use.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

