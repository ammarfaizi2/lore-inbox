Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311582AbSC1QtY>; Thu, 28 Mar 2002 11:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311960AbSC1QtP>; Thu, 28 Mar 2002 11:49:15 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62223 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311582AbSC1QtD>; Thu, 28 Mar 2002 11:49:03 -0500
Date: Thu, 28 Mar 2002 11:46:38 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: John Summerfield <summer@os2.ami.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Lord <mlord@pobox.com>
Subject: Re: IDE and hot-swap disk caddies 
In-Reply-To: <200203262253.g2QMrlS15084@numbat.Os2.Ami.Com.Au>
Message-ID: <Pine.LNX.3.96.1020328114600.18285A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, John Summerfield wrote:

> > At the interface level, there is some support.
> > Look at hdparm's -b option to tristate the bus.
> 
> There is no mention of -b in hdparm's help screen, and in the man page 
> it's only mentioned in the description of -L.
> 
> Is there a newer version of hdparm I need?

I think he meant -x.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

