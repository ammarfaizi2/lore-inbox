Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSKGTAH>; Thu, 7 Nov 2002 14:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSKGTAG>; Thu, 7 Nov 2002 14:00:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35596 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261486AbSKGTAD>; Thu, 7 Nov 2002 14:00:03 -0500
Date: Thu, 7 Nov 2002 14:05:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.46-mm1
In-Reply-To: <4051130868.1036659083@[10.10.2.3]>
Message-ID: <Pine.LNX.3.96.1021107134549.31227A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Martin J. Bligh wrote:

> > For what it's worth, the last mm kernel which booted on my old P-II IDE
> > test machine was 44-mm2. With 44-mm6 and this one I get an oops on boot.
> > Unfortunately it isn't written to disk, scrolls off the console, and
> > leaves the machine totally dead to anything less than a reset. I will try
> 
> Any chance of setting up a serial console? They're very handy for 
> things like this ...

Certainly not with a real serial terminal ;-) As far as going through a
crossover cable to another system, it's doable, but finding the time, the
cable, etc... maybe next week. I just wanted to get the base report out in
case someone had more info, or if it was a known problem. 

I will try to capture it, but I'll try any new versions which come out
before then as well.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

