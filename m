Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSHHIDa>; Thu, 8 Aug 2002 04:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSHHIDa>; Thu, 8 Aug 2002 04:03:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6662 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S316757AbSHHID3>;
	Thu, 8 Aug 2002 04:03:29 -0400
Date: Thu, 8 Aug 2002 10:06:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Giacomo Catenazzi <cate@debian.org>
Cc: trond.myklebust@fys.uio.no,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: O_SYNC option doesn't work (2.4.18-3)
Message-ID: <20020808080659.GC943@alpha.home.local>
References: <fa.jepn5rv.uiqrqe@ifi.uio.no> <fa.gkqj0av.c661ad@ifi.uio.no> <3D52199C.3030408@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D52199C.3030408@debian.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 09:11:24AM +0200, Giacomo Catenazzi wrote:
> ??? You tell us that this list is only made for official kernels?
> In this case it would not flood my mailing box, no -ac, no -arca/-aa,
> no -dj, no..., no ide-2.4, no experimental patches... NO DEVELOPMENT!

at least, the kernel and patches you are talking about are *announced*
here, so that people have a clue about changes between versions.
 
> NOO. This list is also for bug report of RH/Debian/SuSE/connectiva... 
> kernels.

do you remember one of these vendors announcing their kernels with their
changelog here ? I think that could be a good idea anyway, because that
would tell us what set of patches they found to be stable, but unfortunately,
they don't at the moment. So nobody knows what's in without pulling regularly
their new packages from their respective sites.

> The pourpose of lkml is not only the development but also to find the
> stablest kernel. The errata of RH (and other) will help Marcelo and Alan
> to find the right patches to include in the official kernels.

If you want to help, ask these vendors to post their errata here, associated
with the bug reports, so that anyone can benefit from it.

Cheers,
Willy

