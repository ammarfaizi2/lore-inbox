Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273108AbRI3IXj>; Sun, 30 Sep 2001 04:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273132AbRI3IX3>; Sun, 30 Sep 2001 04:23:29 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:29598 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S273108AbRI3IXW>; Sun, 30 Sep 2001 04:23:22 -0400
Date: Sun, 30 Sep 2001 10:23:42 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2 GB file limitation
Message-ID: <20010930102342.A13042@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <Pine.LNX.4.33.0109290816480.10053-100000@boston.corp.fedex.com> <Pine.LNX.4.33.0109291549180.30595-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0109291549180.30595-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.22i
X-Operating-System: vega Linux 2.4.10-grsecurity-1.8 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2001 at 03:51:53PM +0200, Luigi Genoni wrote:
> > > ?? slackware 8 has large file support (I've been useing it for a while
> > > now)
> > I think you can get >2GB support if you've Gcc 3.0. Even with the latest
> >
> ???
> I am using it and I am using gcc 2.95.3 for normal things,
> and to compiled my kernel and my libc, because gcc
> 3.0.1 produces slower binaries on my Athlons (yes, with athlon
> optimizzations turned on), at less for my programs, and it is better to
> avoid it for glibc compilation because of back compatibility issues.

Yes, gcc3 is (well at least NOW) a piece of shit. It produces BIGGER and
SLOWER binaries ... Checked on: Athlon, AMD K6-2.
With the same gcc command line ...

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]---------[ lgb@lgb.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
