Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSDTAvB>; Fri, 19 Apr 2002 20:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSDTAvA>; Fri, 19 Apr 2002 20:51:00 -0400
Received: from Expansa.sns.it ([192.167.206.189]:33542 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S314395AbSDTAvA>;
	Fri, 19 Apr 2002 20:51:00 -0400
Date: Sat, 20 Apr 2002 02:50:33 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Neil Brown <neilb@cse.unsw.edu.au>, Mike Fedyk <mfedyk@matchmail.com>,
        Andreas Dilger <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RAID superblock confusion
In-Reply-To: <200204191348.g3JDmRH25501@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0204200246110.10621-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Apr 2002, Richard Gooch wrote:

> Luigi Genoni writes:
> >
> >
> > On Thu, 18 Apr 2002, Richard Gooch wrote:
> >
> > > Since I'm not in the "in crowd", and I just want a tool that lets me
> > > frob the mixer, I wasted lots of time downloading many different
> > > tools, reading the README's and compiling ones that didn't depend on
> > > some bloated library (glibc, KDE or Gnome). Then waste more time
> > > finding out which ones actually worked properly.
> >
> > I think you would admitt that it is quite difficoult di find a C source
> > code that does not depend on glibc ;).
>
> glibc != only libc available.
>
yes,
and I have 24 systems based on libc5, and every time I compile something
complex like gcc or XFree86 4.2.0, or something network related I can even
have an hard
time with the sources (the most of times are just minimal hacks).

Point is that actually C sources under Linux are developed 99% on glibc,
and as a result they are mostly developed to link against glibc and to be
compiled with gcc.

Luigi

p.s.
by the way, never had problems to compile linux 2.4 on those systems ;).

