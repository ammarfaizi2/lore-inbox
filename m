Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317638AbSFLGMJ>; Wed, 12 Jun 2002 02:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSFLGMI>; Wed, 12 Jun 2002 02:12:08 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:5371 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317638AbSFLGMH>; Wed, 12 Jun 2002 02:12:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dent@cosy.sbg.ac.at, adilger@clusterfs.com, da-x@gmx.net,
        patch@luckynet.dynu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: Your message of "Tue, 11 Jun 2002 18:29:39 MST."
             <Pine.LNX.4.44.0206111824050.16686-100000@home.transmeta.com> 
Date: Wed, 12 Jun 2002 16:02:44 +1000
Message-Id: <E17I1DQ-0000JA-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206111824050.16686-100000@home.transmeta.com> you wr
ite:
> 
> 
> On Wed, 12 Jun 2002, Rusty Russell wrote:
> >
> > The only really sane way to implement "CONFIG_SMALL_NO_INLINES" that I
> > can think of is to have headers do
> 
> inlines, when used properly, are _not_ larger than not inlining.

Good, now we have a benchmark for inline elimination, if people feel
so strongly about it.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
