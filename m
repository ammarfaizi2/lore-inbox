Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293343AbSBYIIG>; Mon, 25 Feb 2002 03:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293344AbSBYIHp>; Mon, 25 Feb 2002 03:07:45 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:4993 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S293343AbSBYIHe>;
	Mon, 25 Feb 2002 03:07:34 -0500
Date: Mon, 25 Feb 2002 00:07:42 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
Message-ID: <20020225080742.GA3122@netnation.com>
In-Reply-To: <3C771D29.942A07C2@starband.net> <20020222204456.O11156@work.bitmover.com> <3C77270A.1CBA02E8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C77270A.1CBA02E8@zip.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 09:22:18PM -0800, Andrew Morton wrote:

> Larry McVoy wrote:
> > 
> > Try 2.72, it's almost twice as fast as 2.95 for builds.  For BK, at least,
> > we don't see any benefit from the slower compiler, the code runs the same
> > either way.
> > 
> 
> Amen.
> 
> I want 2.7.2.3 back, but it was the name:value struct initialiser
> bug which killed that off.  2.91.66 isn't much slower than 2.7.x,
> and it's what I use.
> 
> "almost twice as fast"?  That means that 2.7.2 vs 3.x is getting
> up to a 3x difference.  Does anyone know why?

Me too.  Everybody says "it's the final code that matters", but a lot of
us would be more productive if the thing would just compile faster.  I've
done the same (used 2723 during development/debugging) and it helped
quite a lot.

I remember Borland Turbo Pascal's compiler... Yes, yes, but that thing
compiled insane amounts of code in split seconds on 386 hardware.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
