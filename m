Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273696AbRI3QAO>; Sun, 30 Sep 2001 12:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273691AbRI3P7x>; Sun, 30 Sep 2001 11:59:53 -0400
Received: from Expansa.sns.it ([192.167.206.189]:34319 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S273666AbRI3P7s>;
	Sun, 30 Sep 2001 11:59:48 -0400
Date: Sun, 30 Sep 2001 17:59:23 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
cc: safemode <safemode@speakeasy.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2 GB file limitation
In-Reply-To: <20010930112152.D13042@vega.digitel2002.hu>
Message-ID: <Pine.LNX.4.33.0109301756510.7978-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would be interested to know on which processor your are seeing those
results.
In fact i do not have doubts that on somethuing like an alpha
gcc 3.0.2 is faster.
Maybe it could be faster also on PIV, I do not know. I never tried gcc
3.0.2, i just used gcc 3.0.1 on Athlon systems, but I am
going to gcc 3.0.2 snapshots as soon.

Luigi


On Sun, 30 Sep 2001, [iso-8859-2] Gábor Lénárt wrote:

> On Sun, Sep 30, 2001 at 04:59:49AM -0400, safemode wrote:
> > > Yes, gcc3 is (well at least NOW) a piece of shit. It produces BIGGER and
> > > SLOWER binaries ... Checked on: Athlon, AMD K6-2.
> > > With the same gcc command line ...
> >
> > gcc 3.0.2 produces lame binaries that are 45 seconds faster encoding
> > 74minutes of audio than the gcc 2.95.4 binaries with the same cflags.
> > gcc 2.95.4 produces a binary of 39432 bytes when gcc 3.0.2 with the same
> > flags on the same source produces a binary of 37452 bytes.  I then tested it
> > with lame.  gcc 2.95.4 produced a binary of 245664 bytes and 3.0.2 produced
> > one of 238016 bytes.  Same exact cflags and settings.
> > So basically my testing absolutely contradicts your statement.  So who is
> > right?
>

