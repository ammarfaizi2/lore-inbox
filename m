Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbSK3R66>; Sat, 30 Nov 2002 12:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbSK3R66>; Sat, 30 Nov 2002 12:58:58 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:17706 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S267278AbSK3R65>;
	Sat, 30 Nov 2002 12:58:57 -0500
Date: Sat, 30 Nov 2002 13:23:45 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021130182345.GA21410@lnuxlab.ath.cx>
References: <20021130013832.GF15682@jerry.marcet.dyndns.org> <Pine.LNX.4.50.0211292103200.26051-100000@montezuma.mastecende.com> <3DE82A4C.B8332D8E@digeo.com> <Pine.LNX.4.50.0211292306000.2495-100000@montezuma.mastecende.com> <20021130064807.GA20277@lnuxlab.ath.cx> <20021130064910.GD15426@jerry.marcet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021130064910.GD15426@jerry.marcet.dyndns.org>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2002 at 07:49:10AM +0100, Javier Marcet wrote:
> * khromy <khromy@lnuxlab.ath.cx> [021130 07:33]:
> 
> >BTW, I'm running 2.4.20-rc4-ac1+preempt and it seems to run good but
> >whenever I leave for a few hours or wake up in the morning mozilla is
> >swaped out.. Any idea when/how this might be fixed?
> 
> I have the problem without leaving it a few hours, but when I do it gets
> definitely worse. Last vmstat output I quoted here showed around 256MB
> swapped. A few hours later - the computer had been sitting idle, only
> the mail server for three users was running which poses no overhead at
> all -, the entire 512MB SWAP space was used. Why, I don't know.
> 
> I'm about to try 2.4.20-jam0, -aa derived. I'll post results from that
> kernel later.

aa runs beautifully but it locked up once on me..

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
