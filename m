Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285411AbRLGElw>; Thu, 6 Dec 2001 23:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285412AbRLGElm>; Thu, 6 Dec 2001 23:41:42 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:4017 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S285411AbRLGEle>; Thu, 6 Dec 2001 23:41:34 -0500
Date: Thu, 6 Dec 2001 21:41:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] (no subject)
Message-ID: <20011207044130.GJ30935@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011207043059.GI30935@cpe-24-221-152-185.az.sprintbbd.net> <24800.1007699773@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24800.1007699773@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 03:36:13PM +1100, Keith Owens wrote:
> On Thu, 6 Dec 2001 21:30:59 -0700, 
> Tom Rini <trini@kernel.crashing.org> wrote:
> >On Fri, Dec 07, 2001 at 03:17:53PM +1100, Keith Owens wrote:
> >> 2.5.2-pre1      Add the kbuild 2.5 and CML2 code, still using
> >>                 Makefile-2.5, supporting both CML1 and CML2.
> >>                 i386, sparc, sparc64 can use either kbuild 2.4 or 2.5,
> >>                 2.5 is recommended.
> >>                 ia64 can only use kbuild 2.5.
> >>                 Other architectures continue to use kbuild 2.4.
> >>                 Wait 24 hours for any major problems then -
> >
> >Could we wait longer here?  Maybe 48 or 72 to give other arches time to
> >convert and attempt to sync again?  Or at least show it to Keith so he
> >can try and sync it up. :)
> 
> We will not get all architectures converted in 48 hours or even 72.
> kbuild 2.5 has been available for months and only i386, ia64, sparc32
> (I did all those) and sparc64 (Ben Collins) have been converted.  Alpha
> is in progress.  Unconverted architectures stay on 2.5.2-pre1 until
> they do the conversion, but there is no need to hold up everybody else.

I think at least part of it is a time thing.  It's not official so it's
not on the urgent to do list.  Once it gets in I can imagine other
people picking it up again.  I know rmk mentioned he played with it, 6
months ago.  Which is about when I played with PPC too.  I imagine once
it gets in other people/arches will start to try too, and probably have
a few more suggestions for things that i386/ia64/sparc* haven't run
into.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
