Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273230AbRI3JWB>; Sun, 30 Sep 2001 05:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273242AbRI3JVv>; Sun, 30 Sep 2001 05:21:51 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:54156 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S273230AbRI3JVc>; Sun, 30 Sep 2001 05:21:32 -0400
Date: Sun, 30 Sep 2001 11:21:52 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: safemode <safemode@speakeasy.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2 GB file limitation
Message-ID: <20010930112152.D13042@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <Pine.LNX.4.33.0109290816480.10053-100000@boston.corp.fedex.com> <Pine.LNX.4.33.0109291549180.30595-100000@Expansa.sns.it> <20010930102342.A13042@vega.digitel2002.hu> <20010930085955.76BE016EBB@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010930085955.76BE016EBB@vega.digitel2002.hu>
User-Agent: Mutt/1.3.22i
X-Operating-System: vega Linux 2.4.10-grsecurity-1.8 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 04:59:49AM -0400, safemode wrote:
> > Yes, gcc3 is (well at least NOW) a piece of shit. It produces BIGGER and
> > SLOWER binaries ... Checked on: Athlon, AMD K6-2.
> > With the same gcc command line ...
> 
> gcc 3.0.2 produces lame binaries that are 45 seconds faster encoding 
> 74minutes of audio than the gcc 2.95.4 binaries with the same cflags.   
> gcc 2.95.4 produces a binary of 39432 bytes when gcc 3.0.2 with the same 
> flags on the same source produces a binary of 37452 bytes.  I then tested it 
> with lame.  gcc 2.95.4 produced a binary of 245664 bytes and 3.0.2 produced 
> one of 238016 bytes.  Same exact cflags and settings. 
> So basically my testing absolutely contradicts your statement.  So who is 
> right? 

Well, you may be right. I got my results with the first (pre?)release
of gcc3. I'm going to try gcc 3.0.2 now ... Thanx for the correction.

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]---------[ lgb@lgb.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
