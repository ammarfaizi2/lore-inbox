Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285263AbRLGAKT>; Thu, 6 Dec 2001 19:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285328AbRLGAKK>; Thu, 6 Dec 2001 19:10:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54522 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285320AbRLGAJ7>;
	Thu, 6 Dec 2001 19:09:59 -0500
Date: Thu, 6 Dec 2001 19:09:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rene Rebe <rene.rebe@gmx.net>
cc: greg@kroah.com, jonathan@daria.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
In-Reply-To: <20011207005707.6a09706a.rene.rebe@gmx.net>
Message-ID: <Pine.GSO.4.21.0112061903230.29985-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Dec 2001, Rene Rebe wrote:

> > > usbdevfs does not require devfs, which enables the majority of Linux
> > > users to actually use it.
> > 
> > s/majority of/& sane/
> 
> Writing bash scripts is easier than adding two lines to devfsd.conf?? Btw.
> sane users do not use such a mahor/messy distro ...

Sane users don't run stuff with known unfixable security holes.  The only
variant that has any promise to get that crap fixed got no testing to
speak about.

Ask Richard if you don't believe me - or grep the l-k archives.  Again,
all variants of devfs up to and including 2.4.16 are unfixable according
to devfs author.

BTW, which distro are you talking about?

