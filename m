Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270448AbRHHKyE>; Wed, 8 Aug 2001 06:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270447AbRHHKxz>; Wed, 8 Aug 2001 06:53:55 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:39884 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S270446AbRHHKxg>;
	Wed, 8 Aug 2001 06:53:36 -0400
Date: Wed, 8 Aug 2001 12:53:42 +0200
From: David Weinehall <tao@acc.umu.se>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is this a bug?
Message-ID: <20010808125342.C17094@khan.acc.umu.se>
In-Reply-To: <3B70AEC5.5FE97ACC@pobox.com> <Pine.LNX.4.33.0108072041400.23797-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0108072041400.23797-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Tue, Aug 07, 2001 at 08:45:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 08:45:15PM -0700, Dr. Kelsey Hudson wrote:
> On Tue, 7 Aug 2001, J Sloan wrote:
> 
> > "Dr. Kelsey Hudson" wrote:
> 
> > > It's a bug in that screwed up compiler redhat shipped with 7.1.
> 
> > Oh please, not this FUD again.....
> 
> Call it what you wish -- But, if I see something break when using a
> certain compiler option versus another compiler option that does not
> cause a break, chances are it's a bug in the compiler. After all, the
> Athlon support *is* a new feature, is it not?
> 
> I don't even know why I bothered replying. Don't feed the trolls... Gotta
> watch for those signs....

Ah, but if you'd been observant you'd have noticed what kind of motherboard
he has (a VIA) and if you have been reading your kernel-list lately,
you'd have known that almost noone has been able to get a Athlon-optimized
kernel to work in a stable manner on those; probably because of the
Athlon-optimizations stressing the hardware too much.

I'd say flakey hardware is the problem here, not the compiler.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
