Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289250AbSAGQUu>; Mon, 7 Jan 2002 11:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289248AbSAGQUm>; Mon, 7 Jan 2002 11:20:42 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:52123 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S289253AbSAGQUY>; Mon, 7 Jan 2002 11:20:24 -0500
Date: Mon, 7 Jan 2002 11:21:04 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade
 performance still suck :-(
In-Reply-To: <Pine.LNX.4.33.0201070808340.13875-100000@shell1.aracnet.com>
Message-ID: <Pine.LNX.4.33.0201071118440.5017-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 7 Jan 2002, Alan Cox wrote:
> 
> > > knobs. It just won't happen. Fixing VM behavior is the only way. It has to
> > > work satisfactorily _without_ tuning.
> >
> > Thats something you will never achieve. Virtual memory is about heuristics,
> > crystal ball gazing and guesswork. There are always some workloads where you
> > want little caching and some where you want lots of caching - such as a
> > fileserver.

non sequitur: Linus would like an adaptive VM, which recognizes
apps with the properties you describe.  there's no theoretical
or practical reason this cannot be achieved.

> Thank you, Alan!! Now if the *other* kernel developers would just buy
> into this. :)

you have the source.  whinging about knobs is just whinging.
all serious knobs require recompilation anyway.

