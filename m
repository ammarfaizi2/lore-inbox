Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292365AbSBUNSY>; Thu, 21 Feb 2002 08:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292367AbSBUNSO>; Thu, 21 Feb 2002 08:18:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24078 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292363AbSBUNRz>; Thu, 21 Feb 2002 08:17:55 -0500
Date: Thu, 21 Feb 2002 08:16:32 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: John Alvord <jalvo@mbay.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Connecting through parallel port
In-Reply-To: <str77ukfcime75ot3akiqb4f60d6t0urc6@4ax.com>
Message-ID: <Pine.LNX.3.96.1020221080853.28609A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, John Alvord wrote:

> On Wed, 20 Feb 2002 10:39:36 -0500 (EST), Bill Davidsen
> <davidsen@tmr.com> wrote:

> >There was a protocol called PLIP which did just what you want. I've used
> >it many times for laptop install (Patrick even fixed it in Slackware at my
> >request).
> >
> >Unfortunately, while the feature is still in recent 2.[45] kernels, it
> >appears to be broken. The last laptop I installed needed a network card to
> >get working.

> This was interesting when NIC (network interface cards) cost $100.
> Nowadays, they are a lot less costly and interest in the PLIP solution
> has evaporated.

Unless cards now come with their own slot, this is still very useful. A
system without parallel is very unusual, while one without network is far
more common, and one without a place to even add a network is not that
hard to find. While a home user with only a few systems which he can
configure at will has no trouble adding a NIC, business use in many places
doesn't work that way, and honestly I have a hard time telling someone to
buy NICs, cables, a hub, etc, when a $7 cable will work between systems
with a functional PL/IP kernel.

Considering the low use things supported in the kernel, I see no reason to
think PL/IP is less so. Not a lot of TokenRing out there these days, even
in an IBM shop;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

