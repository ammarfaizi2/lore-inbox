Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbSLKS73>; Wed, 11 Dec 2002 13:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbSLKS73>; Wed, 11 Dec 2002 13:59:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4115 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267198AbSLKS72>; Wed, 11 Dec 2002 13:59:28 -0500
Date: Wed, 11 Dec 2002 13:51:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Daniel Egger <degger@fhm.edu>, Dave Jones <davej@codemonkey.org.uk>,
       Joseph <jospehchan@yahoo.com.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
In-Reply-To: <1039539080.14302.29.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021211134909.19397B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Dec 2002, Alan Cox wrote:

> 
> > Interesting. I have no clue about which C3 you're talking about here but
> > a VIA Ezra has all 686 instructions including cmov and thus optimising 
> > for PPro works best for me.
> 
> Well if you optimise for ppro it won't actually always work. Also the
> scheduling seems to be best with 486. Remember the C3 is a single issue
> risc processor.

Is this the CPU in the $200 "Lindows" PC Wal-Mart is selling? I was
thinking of one for a low volume router, and it looks as if there are two
VIA chips called C3 (or advertizers have hacked the specs).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

