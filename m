Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSGATVo>; Mon, 1 Jul 2002 15:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSGATVn>; Mon, 1 Jul 2002 15:21:43 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:41925 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S316289AbSGATVl>; Mon, 1 Jul 2002 15:21:41 -0400
Date: Mon, 1 Jul 2002 14:24:03 -0500 (CDT)
From: "Justin M. Forbes" <kernelmail@attbi.com>
X-X-Sender: jmforbes@leaper.linuxtx.org
To: Adrian Bunk <bunk@fs.tum.de>
cc: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
In-Reply-To: <Pine.NEB.4.44.0207012045110.24810-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0207011418200.27325-100000@leaper.linuxtx.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Adrian Bunk wrote:

> On Mon, 1 Jul 2002, Bill Davidsen wrote:
> 
> > I suggested that 2.5 be opened when 2.4 came out, so I like the idea of
> > 2.7 starting when 2.6 is released. I think developers will maintain the
> > 2.6 work out of pride and desire to have a platform for the "next big
> > thing." And their code can always be placed on hold for 2.7 until they
> > clarify their thinking on 2.6, if that's really needed.
> > <Snip>
> 
>   If 2.7 doesn't start before 2.6 is _really_ stable everyone who wants
>   to have a new development tree is more interested in making 2.6 a really
>   good kernel instead of focussing immediately on 2.7 .
> 
> 
> Just my 0.02 (Euro-)cent
> Adrian
> 

I would have to agree with Adrian here.  I think that with the feature 
freeze happening in October, many people will be sitting on new ideas for 
immediate implementation into 2.7 as soon as that kernel is available.  If 
the venue is there for 2.7 work to really begin, alot of attention will be 
taken away from the 2.6 tree.  If 2.6 is out for a while before 2.7, 
people will spend more time stabilizing the 2.6 tree, and can continue to 
test their pre 2.7 work against current 2.6.  Waiting doesnt stifle the 
work process for new features too much, but tends to encourage 
stabilization of 2.6 in the meantime.

Justin

