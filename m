Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTAMP3B>; Mon, 13 Jan 2003 10:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTAMP3B>; Mon, 13 Jan 2003 10:29:01 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:34218 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261364AbTAMP3B>; Mon, 13 Jan 2003 10:29:01 -0500
Date: Mon, 13 Jan 2003 10:37:51 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why the new config process is a *big* step backwards
In-Reply-To: <20030113153212.GB12500@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0301131037270.26506-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Tomas Szepe wrote:

> Robert,
> 
> please study scripts/kconfig/*, not how one particular frontend is.
> The new kernel configurator is actually a big improvement over the
> traditional stuff we used to have up to 2.4.  Okay, it is a fact that
> xconfig is far from great, but that doesn't matter -- the important
> thing is Kconfig provides a clean, generic system for the actual kernel
> configuration.  As I already pointed out a fortnight ago or so, the
> only config frontend likely to stay in linux.tar in the long run is
> menuconfig, serving as a reference to userland people who are certain
> to come up with heaps of different Kconfig frontends (that is when
> 2.6 ships I guess).
> 
> If you need a nifty graphical frontend right away, I suggest you
> go ahead and write the first off-tree xconfig.

ok, point taken.  i'll take a look at it, thanks.

rday

