Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289231AbSANNgb>; Mon, 14 Jan 2002 08:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289234AbSANNgV>; Mon, 14 Jan 2002 08:36:21 -0500
Received: from zero.tech9.net ([209.61.188.187]:30739 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289231AbSANNgJ>;
	Mon, 14 Jan 2002 08:36:09 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, jogi@planetzork.ping.de,
        Ed Sweetman <ed.sweetman@wmich.edu>, yodaiken@fsmlabs.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020114125619.E10227@athlon.random>
In-Reply-To: <20020112121315.B1482@inspiron.school.suse.de>
	<20020112160714.A10847@planetzork.spacenet>
	<20020112095209.A5735@hq.fsmlabs.com>
	<20020112180016.T1482@inspiron.school.suse.de>
	<005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au>
	<20020113184249.A15955@planetzork.spacenet>
	<1010946178.11848.14.camel@phantasy> <3C41E415.9D3DA253@zip.com.au>
	<1010952276.12125.59.camel@phantasy>  <20020114125619.E10227@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 14 Jan 2002 08:38:54 -0500
Message-Id: <1011015540.4137.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 06:56, Andrea Arcangeli wrote:
> On Sun, Jan 13, 2002 at 03:04:35PM -0500, Robert Love wrote:
> > user system.  But things like (ack!) dbench 16 show a marked
> > improvement.
> 
> please try again on top of -aa, and I've to specify this : benchmarked
> in a way that can be trusted and compared, so we can make some use of
> this information.  This mean with -18pre2aa2 alone and only -preempt on
> top of -18pre2aa2.

I realize the test isn't directly comparing what we want, so I asked him
for ll+O(1) benchmark, which he gave.  Another set would be to do
preempt and ll alone.

	Robert Love

